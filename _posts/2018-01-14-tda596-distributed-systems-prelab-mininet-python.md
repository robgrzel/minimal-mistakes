---
title: "TDA596 Distributed Systems: lab0 : intro to mininet, python"
categories:
  - TDA596 Distributed Systems  
tags:
  - TDA596
  - Distributed Systems
  - Notes
  - Mininet
  - Docker
  - Python
  - Powershell
gallery:
  - url: /assets/sets/gdb-remote-clion/toolchains.PNG
    image_path: /assets/files/gdb-remote-clion/toolchains.PNG
    alt: "toolchains config"
    title: "Toolchains config"
---

# Distributed Systems - Lab0 Intro

I joined this course bit late and somehow forgot to do prelab (lab0), after all 4 labs, still have to do it so here we go. Btw, its good opportunity to play with vim. So I will at the sime time make a post and do it on vim. First we will deal with seting OS for Mininet. Then we will do basic python exercises given by google. Set simple http server in python. And test mininet.

# Python

Python is easy and awesome. Similar to bash and child of c/cpp. Everyone know Python, If you dont, then shame on you. This father, I, feels pity for your misfortunate life. 




# Mininet

Usually you will use Mininet on VBox, but on Windows there is Hyper-V that for me is much more smooth. You may export VBox image of Mininet on Ubuntu to vhd type that will be readable by Hyper-V import. But we will go with spirit of time and do it on docker. I, your grandpa, heard a lot of good things about docker, like ... eee its must-go, thats why we will use docker.

Goto powershell admin:

```powershell

##host
#build locally
docker build -t mininet-docker E:\_Docker-Containers\docker-mininet
#or pull from cloud
docker pull robgrzel/docker-mininet

#run mininet container as ssh server
docker run -itd -p 3122:22 -p 6633:6633 -p 6653:6653 -p 6640:6640 -h mininet --privileged --security-opt seccomp:unconfined --name mininet-container --dns=8.8.8.8 -v E:/tmp/X11-unix:/tmp/.X11-unix -v ${PWD}:/home/mininet/$(${PWD}|split-path -leaf) -P docker-mininet

# P.S. If error like Exception: Error creating interface pair (s1-eth1,s2-eth1): RTNETLINK answers: File existsts occurs, type:
mn -c to clean up mininet

# check ur "ipv4" for display:
ipconfig

#connect by ssh
ssh -X -p 3122 mininet@127.0.0.1

## guest
#set display for x-server
export DISPLAY=192.168.1.103:0.0 #here is is "ipv4" from host

#check firefox
firefox

#check mininet
mn --test pingall
```

Code here is obvious to guess. But what is inside dockerfile?

```dockerfile
# Mininet

#docker params
FROM ubuntu:16.04
MAINTAINER Robert Grzelka <robert.grzelka@outlook.com>
ARG user=robgrzel

#install software
RUN apt-get update && \
apt-get install -y --no-install-recommends \
openssh-server cmake gcc build-essential nano vim \
python tcpdump telnet byacc flex iproute2 \
gdbserver less bison valgrind firefox \
curl iproute2 iputils-ping mininet net-tools \
tcpdump x11-xserver-utils xterm sudo

#set ssh server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#create user mininet within sudo group
RUN useradd -m -d /home/mininet -s /bin/bash mininet
RUN /bin/bash -c "echo -e '1\n1' | passwd mininet"
RUN adduser mininet sudo
RUN mkdir -p /home/mininet

USER root
WORKDIR /root

#some ping fix
RUN cp -r /bin/ping /sbin/ping \
 && cp -r /bin/ping6 /sbin/ping6 \
 && cp -r /usr/sbin/tcpdump /usr/bin/tcpdump \
 && chmod +x /entry.sh

RUN chmod 777 `which ping`
 
#expose ports for host usage
EXPOSE 22 6633 6653 6640

#it was some mininet bug
RUN service openvswitch-switch start && ovs-vsctl set-manager ptcp:6640

#set network interface eth0 as dhcp (check interfaces with ifconfig)
RUN echo -e "auto eth0\niface eth0 inet dhcp" >> /etc/network/interfaces

#start ssh server (thats why we do detached mode run : docker run -d)
CMD ["/usr/sbin/sshd", "-D"]
```


