---
layout: splash
permalink: /notes/hyper-v_notes/
title: "Hyper-V Notes"
excerpt: "Hyper-V management and how to avoid typical issues..."
toc: true
author_profile: false

---

# problem with networking on hyper-v 

Note:
- Usually need to use default-switch to acces sky network and connect to host.
- Lan works works better than wifi
- Wifi may not have option available for hyper-v to work

For example over lan cable I have this settings for:
 
 - windows:
 - docker: 
 - hyperv:



# problems with networking from hyperv ubuntu 14/16
I can ping to any ip but not by names, so ping 8.8.8.8 or ping 192.168.1.1
will be fine, but ping to google.com do not work. Also sudo apt update throws
error bcos of no connection.
After checking 

This is problem with dns on my hyperv guest. Googling told me that ubuntu 17 dont
have this issue, but I still had to stick to 14 or 16 sometimes.
Doing : cat /etc/resolv.conf shows that:
...
nameserver 172.26.2.1
...
im asking for names from my guest address:

First solution was found here (How do I set my DNS when resolv.conf is being overwritten?):
https://unix.stackexchange.com/questions/128220/how-do-i-set-my-dns-when-resolv-conf-is-being-overwritten

By editing : /etc/dhcp/dhclient.conf
and adding : supersede domain-name-servers 8.8.8.8;
then doing : sudo dhclient -r eth0 && sudo dhclient eth0
and checking : cat /etc/resolv.conf
we have: 
...
nameserver 8.8.8.8
...
so we can do : ping google.com
but after : sudo apt update
or even after few seconds, we may get in same issue again -.- ...
So while we still have connection, lets follow: https://unix.stackexchange.com/a/163506/67024
and install: sudo apt-get install dnsmasq
then edit : sudo nano /etc/dnsmasq.conf
and add this lines:
...
server=8.8.8.8
server=8.8.4.4
...