---
layout: single
title: 操作手册｜安装下载
header:
  overlay_filter: "rgba(99, 183, 175, 0.7)"
  overlay_image: /assets/images/background2.jpg
sidebar:
  nav: "docs"
permalink: /manuals/download/
---

### Step1. 安装docker

* [下载链接](https://docs.docker.com/get-docker/)

### Step2. 下载部署工程

```
git clone https://github.com/archguard/archguard_deploy.git 
```

### Step3. 执行命令
- Start all containers
`./deploy.sh up`
- Stop all containers
`./deploy.sh stop`
- Remove all containers
`./deploy.sh rm`


