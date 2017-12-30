---
layout: splash
permalink: /home/
header:
  overlay_color: "#5e616c"
  overlay_image: "/assets/images/mirai.jpg"
  cta_label: "<i class='fa fa-download'></i> Collections"
  cta_url: "/collections/"
  caption: "Caption..." 
excerpt: 'My personal dev notes, or how to whack and hack!'
feature_row:
  - image_path: /assets/images/bash-logo.png
    alt: "bash"
    title: "Bash"
    excerpt: "bunch of useful commands worth to keep at hand..."
    url: "/notes/bash_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"
    overlay_filter: rgba(255,255,255,1)

  - image_path: /assets/images/docker.png 
    alt: "docker"
    title: "Docker"
    excerpt: "How to manage docker(-compose) (including this blog)..."
    url: "/notes/docker_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"

  - image_path: /assets/images/hyperv.png
    alt: "hyper-v"
    title: "Hyper-V"
    excerpt: "How to manage hyper-v"
    url: "/notes/hyper-v_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"

  - image_path: /assets/images/vbox.png
    alt: "vbox"
    title: "Virtual Box"
    excerpt: "How to manage Virtual-Box"
    url: "/notes/vbox_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"

  - image_path: /assets/images/powershell.png
    alt: "powershell"
    title: "Powershell"
    excerpt: ""
    url: "/notes/powershell_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"

  - image_path: /assets/images/ubuntu.png
    alt: "linux"
    title: "Linux Notes"
    excerpt: ""
    url: "/notes/linux_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/windows.png
    alt: "windows"
    title: "Windows Notes"
    excerpt: ""
    url: "/notes/windows_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/
    alt: "JetBrains"
    title: "JetBrais Notes"
    excerpt: ""
    url: "/notes/jetbrains_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"

  - image_path: /assets/images/
    alt: "Visual Studio"
    title: "Visual Studio Notes"
    excerpt: ""
    url: "/notes/vs_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/
    alt: "Vim-spf13"
    title: "Vim-spf13 Notes"
    excerpt: ""
    url: "/notes/vim_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/
    alt: "HPC"
    title: "HPC Notes"
    excerpt: ""
    url: "/notes/hpc_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"    
    
  - image_path: /assets/images/
    alt: "cmake"
    title: "CMake Notes"
    excerpt: ""
    url: "/notes/cmake_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"

  - image_path: /assets/images/
    alt: "cpp"
    title: "C++ Notes"
    excerpt: ""
    url: "/notes/cpp_notes/"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/
    alt: "java"
    title: "Java Notes"
    excerpt: ""
    url: "/notes/java_notes"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/
    alt: "python"
    title: "Python Notes"
    excerpt: ""
    url: "/notes/python_notes"
    btn_class: "btn--primary"
    btn_label: "goto"
    
  - image_path: /assets/images/
    alt: "mining"
    title: "Mining Notes"
    excerpt: ""
    url: "/notes/mining_notes"
    btn_class: "btn--primary"
    btn_label: "goto"

null_row:
  - image_path: /assets/images/
    alt: ""
    title: "Notes"
    excerpt: ""
    url: ""
    btn_class: "btn--primary"
    btn_label: "goto"
 
github:
  - excerpt: '{::nomarkdown}<iframe style="display: inline-block;" src="https://ghbtns.com/github-btn.html?user=mmistakes&repo=minimal-mistakes&type=star&count=true&size=large" frameborder="0" scrolling="0" width="160px" height="30px"></iframe> <iframe style="display: inline-block;" src="https://ghbtns.com/github-btn.html?user=mmistakes&repo=minimal-mistakes&type=fork&count=true&size=large" frameborder="0" scrolling="0" width="158px" height="30px"></iframe>{:/nomarkdown}'
intro:
  - excerpt: 'Pictures do not have much relation, only my dream was to become hacker; [<i class="fa fa-twitter"></i> @robgrzel](https://twitter.com/robgrzel){: .btn .btn--twitter} [<i class="fa fa-paypal"></i> Tip Me](https://www.paypal.me/robgrzel){: .btn .btn--primary}'
  
date: 2017-12-29

---

{{ page.date | date: "%c" }}

{% include feature_row id="intro" type="center" %}

{% include feature_row %}

