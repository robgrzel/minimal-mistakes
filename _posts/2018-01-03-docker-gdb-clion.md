---
title: "GDB: Remote on Docker with CLion"
categories:
  - GDB
  - Remote Debugging
  - Docker
  - CLion
tags:
  - Development
  - Tools
  - GDB
  - SSH
  - Docker
  - Remote Debugger
  - CLion
  - MinGW
  - Windows
feature_row:
  - url: /assets/files/gdb-remote-clion/mingw-w64-x86_64-multiarch.zip
    image_path: /assets/files/gdb-remote-clion/mingw-w64-x86_64-multiarch.zip
    alt: "gdb.zip"
    title: "GDB multiarch got from [here](https://youtrack.jetbrains.com/issue/CPP-8137)"
gallery:
  - url: /assets/sets/gdb-remote-clion/toolchains.PNG
    image_path: /assets/files/gdb-remote-clion/toolchains.PNG
    alt: "toolchains config"
    title: "Toolchains config"
  - url: /assets/sets/gdb-remote-clion/deployment.PNG
    image_path: /assets/files/gdb-remote-clion/deployment.PNG
    alt: "deployment config"
    title: "deployment config"
  - url: /assets/sets/gdb-remote-clion/debugger.PNG
    image_path: /assets/files/gdb-remote-clion/debugger.PNG
    alt: "debugger config"
    title: "debugger config"
  - url: /assets/sets/gdb-remote-clion/run.PNG
    image_path: /assets/files/gdb-remote-clion/run.PNG
    alt: "run config"
    title: "run config"
  - url: /assets/sets/gdb-remote-clion/debug.PNG
    image_path: /assets/files/gdb-remote-clion/debug.PNG
    alt: "debug in action"
    title: "debug in action"
---


To set remote debugger GDB on docker container we need to setup it as ssh server. 

# Docker Part

Check out my other post [docker-gdb-ssh]{{ "" | absolute_url }}{% post_url 2018-01-03-docker-with-ssh-and-gdb %}

# CLion Part

CLion using standard MinGW-w64 with bundled GDB will throw error similar to:

```bash
Remote debugging using 10.0.9.1:3127
Couldn't establish connection to remote target
Remote register badly formatted:
T1106:0100000000000000;07:a00ec8ffff7f0000;10:5fab1023e62a0000;
here: 0000000;07:a00ec8ffff7f0000;10:5fab1023e62a0000;
```

It appears that we need GDB build on Windows for Linux, binaries can be found [here](https://youtrack.jetbrains.com/issue/CPP-8137),
but I keep it locally too: {% include feature_row %}. 

Extract to some dir and follow CLion config as in pics:

{% include gallery %}.




