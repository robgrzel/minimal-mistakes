---
title: "Kattis: medium - area of robot protection"
categories:
  - Kattis Medium
  - Java
  - Algorithms
  - Convex Hull
tags:
  - Kattis
  - Medium 
  - Programming
  - Java
  - Algorithms
  - Convex Hull
gallery:
  - url: /assets/images/ladder-hright.png
    image_path: /assets/images/ladder-hright.png
    alt: "splash layout example"
---


# Problem
 
During one of my interviews I had to solve problem of finding maximum area of robot protection as in: [robot-protection](https://open.kattis.com/problems/robotprotection)

## Conclusions about problem:
```md
- Given a configuration of beacons, your job is to determine the area that the robot can patrol. 
- You should assume that the robot starts at the first beacon of the configuration.
```

My understanding:
- Second information seems useless. 
- Basically robot may move between any given points in straight lines. Task is to find maximum area he can move around. 
- Hmm.... For me it seems like convex hull problem. So to solve it, one has to implement Convex Hull Algorithm. 

# Solution

## Simple implementation:
- We do not have any keys here, 
- We store points 

array to store initial points.

## Notes for upgrade:
- We do not need some special order of this points
- We do not need duplicates

Looking at above If its simple iteration over next points we may use use HashSet.
 
```java 

```
 
 
Test it with this set:
```md
4
3
10
21
10
3
20
10
10
3
10
10
10
4
15
15
15
45
```

