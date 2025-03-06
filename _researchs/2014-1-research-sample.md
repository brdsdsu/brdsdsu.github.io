---
layout: post
title: Markdown Sample
tags: [ Autonomy, Robotics ]
---

$$Ullamco$$ magna non proident duis ex magna enim ea. Est veniam sint magna ex excepteur dolor ad id. Consequat cupidatat anim ut voluptate exercitation nostrud non officia adipisicing reprehenderit officia sit deserunt. Non do minim consequat veniam ad commodo laboris culpa proident aute dolore proident pariatur fugiat cupidatat. Reprehenderit ad magna tempor. Sit ut aliqua elit velit velit aliquip ad Lorem tempor nulla non.

$$
Q(s_t, a_t) \leftarrow Q(s_t, a_t) + \alpha \left( r_t + \gamma \max_{a{\prime}} Q(s_{t+1}, a{\prime}) - Q(s_t, a_t) \right)
$$

This is a demo of all styled elements in Jekyll Now.

[View the markdown used to create this post](https://raw.githubusercontent.com/barryclark/www.jekyllnow.com/gh-pages/_posts/2014-6-19-Markdown-Style-Guide.md).

This is a paragraph, it's surrounded by whitespace. Next up are some headers, they're heavily influenced by GitHub's markdown style.

## Header 2

### Header 3

#### Header 4

A link to [Jekyll Now](http://github.com/barryclark/jekyll-now/). A big ass literal link <http://github.com/barryclark/jekyll-now/>

An image, located within /images

![an image alt text]({{ site.baseurl }}/images/jekyll-logo.png "an image title")

* A bulletted list
- alternative syntax 1
+ alternative syntax 2
  - an indented list item

1. An
2. ordered
3. list

Inline markup styles:

- _italics_
- **bold**
- `code()`

> Blockquote
>> Nested Blockquote

Syntax highlighting can be used with triple backticks, like so:

```c
#include <stdio.h>

int main(void) {
	printf("Hello World!");
	return 0;
}
```

Use two trailing spaces  
on the right  
to create linebreak tags  

Finally, horizontal lines

----
****