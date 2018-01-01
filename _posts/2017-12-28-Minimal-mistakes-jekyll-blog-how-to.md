---
title: "Jekyll, Minimal-Mistakes: how to set this blog and test on docker"
categories:
  - Jekyll
  - How To
  - This Blog
tags:
  - How To
  - This Blog
  - Jekyll
  - Ruby
  - Minimal-Mistakes
  - Docker
gallery:
  - url: /assets/images/ladder-hright.png
    image_path: /assets/images/ladder-hright.png
    alt: "splash layout example"
---

# Step 1:

Fork this github: `https://mmistakes.github.io/minimal-mistakes/`
and change name to: `robgrzel.github.io`

Or fork this github: `https://mmistakes.github.io/robgrzel/robgrzel.github.io`
and change name to : ...

Use github-desktop to clone this repo on our host machine.
Now work on host machine with this clone.

# Steps 2:

Make changes in _config.yml, where most important is : `url: https://robgrzel.github.io`
You may also change `timezone: ...` to fit your region.

# Step 3:

Pull docker image in power shell with admin: `docker pull jekyll/jekyll:pages`
it may not work so also pull: `docker pull jekyll/jekyl:latest`

# Step 4:

Run docker container by powershell script RunInDocker.ps1 that contains : 


```powershell
#JEKYLL_ENV=development make it crash,
docker run --volume="$PWD":/srv/jekyll --name jekyll_robgrzel.github.io `
-it -p 127.0.0.1:4000:4000 -e JEKYLL_ENV=docker jekyll/jekyll:latest `
jekyll s --config _config.yml,_config.dev.yml --force_polling --incrementall
```

where:
- we mount our current directory as volume, and docker image will see it as dir /srv/jekyll
- we name our container jekyll_robgrzel.github.io
- we run it interactive way with tty by: -it
- we expose address of localhost on docker-host on port 4000 and on docker-container we expose port 4000
- we set env variable to jekyll named docker
- we use image jekyll:jekyll:latest from docker hub
- on this image we run command : `jekyll s ...`, where:
-- we set config files manually and we use _config.dev.yml to override url
-- we update website on change from host/container with --force_pooling and --incremental

# Step 5:

Use github-desktop to update our repo. Changes should appear after ~ 5[min].

