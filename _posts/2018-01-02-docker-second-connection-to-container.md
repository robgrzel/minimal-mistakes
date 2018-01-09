---
title: "Docker : separate connection to existing container"
categories:
  - Docker Container
tags:
  - Docker
gallery:
  - url: /assets/images/unsplash-gallery-image-1.jpg
    image_path: /assets/images/unsplash-gallery-image-1-th.jpg
    alt: "placeholder image 1"
    title: "Image 1 title caption"
---



# Docker: connect new separate session to container running, ie. pintos with gdb

In my lab0 with pintos I had to run pintos with gdb, but this set container on hold.
So when I had to get second connection to this container, I try to do:

`docker start -ia "id"`

But this connected me to existing run of /bin/bash in this container. I found solution
[here](https://stackoverflow.com/questions/17903705/is-it-possible-to-start-a-shell-session-in-a-running-container-without-ssh).

Simply do:

`docker exec -it "id" /bin/bash`

This works.

