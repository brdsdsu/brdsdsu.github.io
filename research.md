---
permalink: /research/
title: "Research"
layout: page
---

Our current research focus is on **resource-aware autonomy**. 
The goal is to enable practical deployment of realtime applications requiring environmental knowledge, such as fully autonomous mobile devices or extended reality devices, on commodity hardware. 
We set out to achieve this by utilizing next-generation wireless networking to connect end-edge-cloud systems, and adding cross-layer intelligence to balance system constraints, like energy efficiency, with application requirements, like latency or safety. 
We categorize the process to conduct this research into _three pillars_, outlined below.

### Instrumentation and Data Collection ###
The first pillar consists of instrumenting applications and systems in order to measure their behavior, collect data, and ultimately evaluate solutions.
We achieve this by modifying existing applications or operating systems, or generating standalone applications in Python or C++.
Typical outcomes include open-source tools [1], benchmark suites [2], or datasets.

[1] [MARS framework: Middleware for Adaptive Reflective Systems](https://github.com/duttresearchgroup/MARS)<br>
[2] [Chauffeur: Benchmark Suite for Design and End-to-End Analysis of Self-Driving Vehicles on Embedded Systems](https://github.com/duttresearchgroup/Chauffeur) 

### Data Analysis and Modeling ###
The second pillar builds on the data collected from the instrumentations.
We use statistical methods to identify useful patterns in the data collected to understand the relationship between inputs, application, system, and measured behavior.
Typical outcomes include predictive models of application behavior [1][2].

[1] [Donyanavard et al., CODES+ISSS'16](https://dl.acm.org/doi/abs/10.1145/2968456.2968459)<br>
[2] [Hernández et al., IROS'21](https://dl.acm.org/doi/abs/10.1145/2968456.2968459)

### Runtime Decision-making ###
The third pillar builds on the behavioral models and analysis.
We define optimization problems based on application goals and system constraints, and solve them at runtime in order to operate the system and application in the most efficient and effective way, given dynamic inputs and environments.
Typical outcomes include runtime policies for computational offloading [1] or resource sharing [2][3][4].

[1] [Shahhosseini et al., TECS'22](https://dl.acm.org/doi/full/10.1145/3520129)<br>
[2] [Rahmani et al., ASPLOS'18](https://dl.acm.org/doi/abs/10.1145/3173162.3173199)<br>
[3] [Donyanavard et al., MICRO'19](https://dl.acm.org/doi/abs/10.1145/3352460.3358312)<br>
[4] [Maity et al., TECS'21](https://dl.acm.org/doi/abs/10.1145/3466875)

## Projects
* [Expanding AI Capacity in San Diego](https://expandai.sdsu.edu/)

## Media
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/iGdzzA-jpNc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
  
<!--iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/iDVT4Gyp8q8" title="Fall 2022 Colloquium Talk - Bryan Donyanavard (09/09/2022)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe-->
