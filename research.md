---
permalink: /research/
title: "Research"
layout: page
---

Autonomous systems, from delivery drones to extended reality glasses, are poised to transform society, but their practical deployment is fundamentally limited by on-device resource constraints.
My research group tackles this critical challenge through **resource-aware autonomy**.
The goal is to enable practical deployment of realtime applications requiring environmental knowledge, such as fully autonomous mobile devices or extended reality devices, on commodity hardware.
We set out to achieve this by utilizing next-generation wireless networking to connect end-edge-cloud systems, and adding cross-layer intelligence to balance system constraints, like energy efficiency, with application requirements, like latency or safety.
We categorize the process to conduct this research into **_three pillars_**, outlined below.

### Instrumentation and Data Collection ###
The first pillar consists of instrumenting applications and systems in order to measure their behavior, collect data, and ultimately evaluate solutions.
We achieve this by modifying existing applications or operating systems, or generating standalone applications in Python or C++.
Typical outcomes include open-source tools [1], benchmark suites [2], or datasets.

[1] [MARS framework: Middleware for Adaptive Reflective Systems](https://github.com/duttresearchgroup/MARS)<br>
[2] [Chauffeur: Benchmark Suite for Design and End-to-End Analysis of Self-Driving Vehicles on Embedded Systems](https://github.com/duttresearchgroup/Chauffeur)

### Data Analysis and Modeling ###
The second pillar builds on the data collected from the instrumentations.
We use statistical methods to identify useful patterns in the data collected to understand the relationship between inputs, application, system, and measured behavior.
Typical outcomes include predictive models of application behavior [3][4].

[3] [Donyanavard et al., CODES+ISSS'16](https://dl.acm.org/doi/abs/10.1145/2968456.2968459)<br>
[4] [Hernández et al., IROS'21](https://ieeexplore.ieee.org/abstract/document/9635978)

### Runtime Decision-making ###
The third pillar builds on the behavioral models and analysis.
We define optimization problems based on application goals and system constraints, and solve them at runtime in order to operate the system and application in the most efficient and effective way, given dynamic inputs and environments.
Typical outcomes include runtime policies for computational offloading [5] or resource sharing [6][7][8].

[5] [Shahhosseini et al., TECS'22](https://dl.acm.org/doi/full/10.1145/3520129)<br>
[6] [Rahmani et al., ASPLOS'18](https://dl.acm.org/doi/abs/10.1145/3173162.3173199)<br>
[7] [Donyanavard et al., MICRO'19](https://dl.acm.org/doi/abs/10.1145/3352460.3358312)<br>
[8] [Maity et al., TECS'21](https://dl.acm.org/doi/abs/10.1145/3466875)

## Projects
* [Expanding AI Capacity in San Diego](https://expandai.sdsu.edu/)

### Realtime Environmental Understanding
Autonomous cyber-physical systems (A-CPS) execute complex software pipelines on resource-constrained devices, for applications that interact with the physical world without human intervention.
A-CPS must collect and process sensory information in order to understand and navigate the environment.
Visual-inertial simultaneous localization and mapping (SLAM) is an essential task for A-CPS.
A-CPS provide clear advantages: they can operate in environments too hazardous or remote for direct human presence, and they can do so persistently without fatigue.
A-CPS applications rely on accurate realtime SLAM to provide environmental understanding.
In our recent work [9], we address performance degradation experienced by realtime visual-SLAM executing on resource-constrained autonomous devices.
We implement a fully online, runtime adaptive masking strategy that selectively processes only the most informative regions of each input frame based on the current computational budget and timing constraints, resulting in reduced frame dropouts, ultimately improving tracking performance.

Following the initial investigation into localization, we are now focusing on the three-dimensional (3D) mapping space, specifically 3D Scene Graphs (3DSG).
3DSGs represent a critical advancement in scene understanding, extending two-dimensional (2D) scene graphs to capture the complex geometric and semantic relationships within 3D environments.

[9] [Rebel et al., TECS'25](https://dl.acm.org/doi/full/10.1145/3761808)

### Operating Systems and Architecture for Autonomous Devices
Autonomous systems, such as autonomous vehicles (AVs), rely heavily on data from various sensors to make critical decisions in real-time for safe navigation of physical environments.
Workloads consist of complex latency-sensitive tasks that require sophisticated operating system (OS) features.
Autonomous systems must simultaneously execute tasks with different timing constraints and priorities, including sensor data processing, object detection, path planning, and control signal generation, posing unique challenges in the design of CPU scheduling policies.
The efficient storage and retrieval of sensor data are crucial to ensure that information from sensors such as LiDAR, radar, and cameras is available for processing, not only with minimal delay, but also in a timely manner.
In recent work in collaboration with UC Irvine, we have developed a context-aware I/O scheduler for autonomous systems, addressing the limitations of the scalability and predictability of rosbag, a sensor-logging software [10].
Ongoing work is investigating CPU task scheduling for mixed-criticality workloads executing on autonomous devices [11].

[10] [Seo, Sung et al., ISQED'25](https://ieeexplore.ieee.org/abstract/document/11014394)<br>
[11] [Seo, Sung et al., VTC'25](https://ieeexplore.ieee.org/abstract/document/11174897)

### Reservoir Computing in Edge Networks
Reservoir Computing (RC) is a computational paradigm that leverages the dynamic properties of Recurrent neural networks (RNN) while avoiding the complexity of training all internal weights.
Due to its efficiency and suitability for temporal pattern recognition, RC has gained attention in resource-constrained environments, such as edge computing.
Our work explores the implementation of a RC architecture on an edge device, focusing on the challenges and opportunities of deploying distributed, low-latency machine learning systems at the edge for a network of autonomous battery-powered end-devices.
In ongoing work, we propose a modular system architecture where the input and output layers are handled by lightweight agents, while the core reservoir is deployed on a central edge device [12].
The architecture offers a promising solution for realtime inference in distributed systems, particularly where hardware resources and latency are critical constraints.

[12] [Kauuwai et al., NICE'25]()

## Media
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/iGdzzA-jpNc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

<!--iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/iDVT4Gyp8q8" title="Fall 2022 Colloquium Talk - Bryan Donyanavard (09/09/2022)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe-->
