# Build-time image optimization. Commit only the original images; resized copies
# are generated during `jekyll build` and published under /images/opt/.
#
# Liquid filter (returns a hash with src / width / height):
#
#   {% assign img = '/images/photo.jpg' | resize_image: 800 %}             800px wide WebP (never upscaled)
#   {% assign img = '/images/photo.jpg' | resize_image: 560, height: 600 %} center-cropped to 560x600
#   {% assign img = '/favicon.png' | resize_image: 32, format: 'png' %}     other output formats
#   <img src="{{ img.src }}" width="{{ img.width }}" height="{{ img.height }}">
#
# Options: height (crop to exactly width x height), quality (default 70), format (default webp).
#
# Several sizes for srcset (sizes larger than the original are skipped, never upscaled):
#
#   {% assign img = '/images/photo.jpg' | image_srcset: '800,1400', quality: 75 %}
#   {% assign img = '/images/photo.jpg' | image_srcset: '560,1120', crop: '14:15' %}   center-cropped to 14:15
#   <img src="{{ img.src }}" srcset="{{ img.srcset }}" sizes="..." width="{{ img.width }}" height="{{ img.height }}">
#
# img.src / width / height describe the largest generated size; img.srcset uses "w" descriptors.
#
# People headshots (`headshot:` in _people/*.md) are handled automatically and exposed
# to _includes/profile.html as page.headshot_opt (src, srcset, width, height).
#
# Generated files are cached in .jekyll-cache/images and only rebuilt when the original
# changes. Requires ImageMagick (`magick` or `convert`); without it the original image is
# used as-is, so the site still builds.

require "fileutils"
require "open3"

module ImageOptimizer
  OUT_DIR = "images/opt"
  DEFAULT_QUALITY = 70
  DEFAULT_HEADSHOT = "/images/avatar.png"
  # Headshots show at 150px (desktop) and up to 300px (mobile, often at 3x density)
  HEADSHOT_WIDTHS = [200, 400, 600, 900].freeze
  HEADSHOT_QUALITY = 75

  class << self
    # Returns { "src", "width", "height" }, or nil when the image can't be optimized.
    def variant(site, path, width, height: nil, quality: DEFAULT_QUALITY, format: "webp")
      return unless tool && path.is_a?(String)

      src = site.in_source_dir(path)
      unless File.file?(src)
        Jekyll.logger.warn("Images:", "#{path} not found")
        return
      end

      name = File.basename(path, ".*") + (height ? "-#{width}x#{height}" : "-#{width}") + ".#{format}"
      base = File.join(site.in_source_dir(".jekyll-cache", "images"), "q#{quality}")
      dest = File.join(base, OUT_DIR, name)
      return unless fresh?(src, dest) || convert(src, dest, width, height, quality)

      unless published.key?(dest)
        published[dest] = dimensions(dest)
        site.static_files << Jekyll::StaticFile.new(site, base, OUT_DIR, name)
      end
      w, h = published[dest]
      { "src" => "/#{OUT_DIR}/#{name}", "width" => w, "height" => h }
    end

    # Returns { "src", "srcset", "width", "height" } for the given widths, or nil.
    # crop: "W:H" aspect ratio to center-crop to. Sizes larger than the original are replaced
    # by a single copy at the largest size the original can provide (never upscaled).
    def srcset(site, path, widths, crop: nil, quality: DEFAULT_QUALITY)
      orig_w, orig_h = original_size(site, path)
      return unless orig_w

      ratio = crop && crop.to_s.split(":").map(&:to_f)
      height_for = ->(w) { ratio && (w * ratio[1] / ratio[0]).round }
      max_w = ratio ? [orig_w, (orig_h * ratio[0] / ratio[1]).floor].min : orig_w
      sizes = widths.map { |w| [w, max_w].min }.uniq.sort

      variants = sizes.filter_map { |w| variant(site, path, w, height: height_for.(w), quality: quality) }
      return if variants.empty?

      largest = variants.last
      largest.merge("srcset" => variants.uniq { |v| v["width"] }.map { |v| "#{v["src"]} #{v["width"]}w" }.join(", "))
    end

    def reset
      @published = {}
      @original_sizes = {}
    end

    private

    def published
      @published ||= {}
    end

    def original_size(site, path)
      return unless tool && path.is_a?(String)

      src = site.in_source_dir(path)
      return unless File.file?(src)

      (@original_sizes ||= {})[src] ||= begin
        out, status = Open3.capture2(*tool, src, "-auto-orient", "-format", "%w %h", "info:")
        status.success? ? out.split.map(&:to_i) : nil
      end
    end

    def fresh?(src, dest)
      File.exist?(dest) && File.mtime(dest) >= File.mtime(src)
    end

    def convert(src, dest, width, height, quality)
      FileUtils.mkdir_p(File.dirname(dest))
      geometry = height ? ["-resize", "#{width}x#{height}^", "-gravity", "center", "-extent", "#{width}x#{height}"]
                        : ["-resize", "#{width}x>"]
      _, err, status = Open3.capture3(*tool, src, "-auto-orient", "+profile", "!icc,*", *geometry,
                                      "-quality", quality.to_s, "-define", "webp:method=6", dest)
      return true if status.success?

      Jekyll.logger.warn("Images:", "failed to convert #{src}: #{err.strip}")
      false
    end

    def dimensions(path)
      out, status = Open3.capture2(*tool, path, "-format", "%w %h", "info:")
      status.success? ? out.split.map(&:to_i) : [nil, nil]
    end

    def tool
      return @tool if defined?(@tool)

      @tool = [["magick"], ["convert"]].find do |cmd|
        _, status = Open3.capture2e(*cmd, "-version")
        status.success?
      rescue Errno::ENOENT
        false
      end
      Jekyll.logger.warn("Images:", "ImageMagick not found, using original images") unless @tool
      @tool
    end
  end

  module Filter
    # Falls back to the original path (without size) when optimization isn't possible.
    def resize_image(path, width, options = {})
      site = @context.registers[:site]
      opts = options.transform_keys(&:to_sym).slice(:height, :quality, :format)
      ImageOptimizer.variant(site, path, width.to_i, **opts) || { "src" => path }
    end

    # widths: comma-separated string, e.g. "800,1400"
    def image_srcset(path, widths, options = {})
      site = @context.registers[:site]
      opts = options.transform_keys(&:to_sym).slice(:crop, :quality)
      ImageOptimizer.srcset(site, path, widths.to_s.split(",").map(&:to_i), **opts) || { "src" => path }
    end
  end

  class Headshots < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      site.collections["people"]&.docs&.each do |doc|
        path = doc.data["headshot"] || DEFAULT_HEADSHOT
        next unless path.is_a?(String) && path.match?(/\.(jpe?g|png|webp)\z/i)

        opt = ImageOptimizer.srcset(site, path, HEADSHOT_WIDTHS, quality: HEADSHOT_QUALITY)
        doc.data["headshot_opt"] = opt if opt
      end
    end
  end
end

Liquid::Template.register_filter(ImageOptimizer::Filter)
Jekyll::Hooks.register(:site, :after_reset) { ImageOptimizer.reset }
