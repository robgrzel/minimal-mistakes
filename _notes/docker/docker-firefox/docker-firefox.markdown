---
layout: splash
permalink: /notes/docker_notes/docker-firefox/
title: "Docker Apps: run firefox on docker, display on host"
excerpt: "Example on firefox, how to omit ssh to display from docker on host."
toc: true
author_profile: false
---

# INTRO

With Docker we do not need ssh to run some image on same machine. Even on remote machine,
first we may use ssh then run docker, thought I did not test it, just guess. 
We will set Xming as our display server on Windows, get and set ip address of this server
on our host and run firefox on guest in docker. Its similar to using HyperV+Putty(SSH)+Xming.

If rly want to do docker with ssh, here You go:
https://hub.docker.com/r/robertdebock/docker-centos-openssh/

# SET WINDOWS HOST DISPLAY SERVER

1. Install Xming
2. Run Xlauncher
2.1. set with multiwindows
2.2. set with xming parameters: `-ac` # to allow all connections as in (http://theunixtips.com/xming-client-4-rejected-from-ip/)

# SET OUT DISPLAY ADDRESS 

1. Check our host ip (ie. with ipconfig)
2. Set display 0 port 0 on address 192.168.1.102
set-variable -name DISPLAY -value 192.168.1.102:0.0

# DOCKER FILE

```Batch
FROM ubuntu:14.04
RUN apt-get update && apt-get install -y firefox
CMD /usr/bin/firefox
```

# SET DOCKER IMAGE

```powershell
docker build -t firefox "E:\Dev Nuts & Cakes\DockerApps\Docker-Firefox"
```

# RUN DOCKER IMAGE

```powershell
docker run -ti --rm -e DISPLAY=$DISPLAY --name firefox-container firefox
```