---
layout: splash
permalink: /notes/docker_notes/
title: "Docker Notes"
excerpt: "Docker settings, management and usage..."
toc: true
author_profile: false

---
# GENERAL COMMAND OF DOCKER

```powershell
# create volume
docker volume create myvol

# pull image from cloud/hub
docker pull [user]/image

# build docker image tagged by -t with dockerfile in directory 
docker build -t myimage "X:\MyDirWithDockerfile\"

# run iterativelly with tty /bin/bash as root user using docker image as container
docker run -it "myimagename or myimageid" /bin/bash
## example: docker run interactive image adc7e1e17105 with /bin/bash
docker run -it adc7e1e17105 /bin/bash

# to resume after exit:
## first check id with
docker ps -a
## then use "id" to resume without "" 
docker start -a -i "id"

# issue when doing: RUN ...build.sh
## solution based on (https://github.com/docker/for-win/issues/1166) is to:
before RUN ...build.sh, add a:
RUN chmod +x ...build.sh

# pushing image to cloud
docker login
docker tag myimage [user]/myimage
docker push [user]/myimage
```

# DOCKER SPECIFICS ABOUT RUN
```powershell

# docker run /bin/bash in myimage 
docker run -it myimage /bin/bash

## ... as user myuser  
docker run -it -u myuser myimage /bin/bash

## ... with volume myvolume in ...
### ... /home/myvolume
docker run -it -u myuser -v myvolume:/home/myvolume
### ... /myvolume
docker run -it -v myvolume:/myvolume

# connect to already run myimage
docker start -ia (docker ps -a | grep myimage | awk '{print $1;}')
```

# DOCKER SPECIFICS ABOUT REMOVAL
```powershell

# remove containers manually
## first get id of our containers (docker container ls - do not work somehow...)
docker ps -a
## now remove by our id (without "")
docker rm "id"

# docker remove all containers
docker rm $(docker ps -a -q)

# remove first from specific containers with pintos word in name
 docker rm (docker ps -a | grep pintos | awk '{print $1;}')

# remove images with <none> name and force it (usually remove all images -.-)
docker rmi $(docker images -f "dangling=true" -q) -f
```

# INSTANTIATE MININET CONTAINER IN VOLUME
```powershell

docker volume create mininet

# download container (https://hub.docker.com/r/qvestor/mininet/)
docker pull qvestor/mininet

# create mininet-container with volume mininet mounter in /home/mininet ; 
docker run -it --privileged -v mininet:/home/mininet --name mininet-container qvestor/mininet /bin/bash

# now inside container run:
service openvswitch-switch start

# P.S. If error like Exception: Error creating interface pair (s1-eth1,s2-eth1): RTNETLINK answers: File existsts occurs, type:
mn -c to clean up mininet
```
# SETUP PINTOS CONTAINER IN VOLUME AND RUN IT AS USER PINTOS

## build image

```powershell

## build image with tag by -t and dockerfile in local dir
docker build -t pintos "E:\PintOS\"
## build docker image from git (cant use properly, causes permission denied when running script bash scripts .sh)
docker build -t pintos https://github.com/robgrzel/PintOS.git
## pull already build image from docker hub that has files in https://github.com/robgrzel/PintOS.git
docker pull robgrzel/pintos
```
## run image

```powershell

## run /bin/bash in docker image,
docker run -it --privileged --name pintos-container --dns=8.8.8.8 -v E:\PintOS\workspace:/home/pintos/workspace -P robgrzel/pintos /bin/bash
## where: 
###  -u(ser), not needed here, set at built time
###  -dns=8.8.8.8 let to acces net by name
###  -P expose all ports of image
###  --name if your container name what u want to run
###  -v let u mount volume pintos in directory /home/pintos
###  -it its interactive with tty
### with this command:
## examples of run:
### (if you build image yourself )
docker run -it -u pintos --privileged -v pintos:/home/pintos --name pintos-container --dns=8.8.8.8 -P pintos /bin/bash
### (if you pull image robgrzel/pintos you may do)
docker run -it -u pintos --privileged -v pintos:/home/pintos --name pintos-container --dns=8.8.8.8 -P robgrzel/pintos /bin/bash
### (if u run with user as root)
docker run -it --privileged -v pintos:/home/pintos --name pintos-container --dns=8.8.8.8 -P robgrzel/pintos /bin/bash
### (if to run in detached mode, when u want to run ie. ssh server (but have to run it first))
docker run -d --privileged --name pintos-container --dns=8.8.8.8 -v pintos:/home/pintos -P pintos-ssh 
```

Reason is that we have created docker volume in dockerfile that is hidden somewhere
Its not possible (dont know how yest how to!) to copy files from buildin volume to
directory during runtime, so at least I can share directory from my host E:\PintOS\workspace 
that will be mounted as /home/pintos/workspace

## attach after exit from run
```powershell
# connect to first running container with pintos in name
docker start -ia (docker ps -a | grep pintos | awk '{print $1;}')
```

# RUN DETACHED DOCKER IMAGE WITH SSH-SERVER

based on:
https://blog.docker.com/2013/07/docker-desktop-your-desktop-over-ssh-running-inside-of-a-docker-container/

!!!! Found that ssh is not necessary for docker, as in example docker-firefox [docker firefox display on host][link-docker-firefox]

```powershell
docker pull rogaha/docker-desktop
docker run -d --privileged --name docker-desktop --dns=8.8.8.8 -P rogaha/docker-desktop
```

# DOCKER CONTAINER OF CENTOS WITH SSH-SERVER
based on : https://hub.docker.com/r/robertdebock/docker-centos-openssh/
```powershell


```

# DOCKER FOR MINICONDA3
```powershell
docker pull continuumio/miniconda3
docker run -i -t continuumio/miniconda3 /bin/bash

#Alternatively, you can start a Jupyter Notebook server and interact with Miniconda via your browser:
docker run -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "
  /opt/conda/bin/conda install jupyter -y --quiet &&
  mkdir /opt/notebooks &&
  /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser"
```

# DOCKER RUN FIREFOX FOR GRAPHICAL OUTPUT:
- Go to [docker firefox display on host][link-docker-firefox]

Test null link [null link][link-post-null]

[link-docker-firefox]: {{ "/notes/docker_notes/docker-firefox" | absolute_url }}
[link-post-null]: {{ "" | absolute_url }}{% post_url 2016-07-20-null_post %}
