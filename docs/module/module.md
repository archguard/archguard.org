---
layout: default
title: Modules
nav_order: 8
has_children: true
permalink: /modules
---

{: .no_toc .text-delta }

1. 目录
   {:toc}

所有的 Scanner 都以 Jar 包 + CLI 的方式来提供服务，使用的框架是：clikt，语言是：Kotlin。

## Scanner Download

Scanner 下载过程：

1. 从 GitHub 的 release 下载对应的版本到应用的运行目录。
   - 在本地时，则与后端代码同级（即和 build.gradle.kts 同级）
   - 在镜像内，则与 /home/spring/app.jar 同级
2. 将 Scanner 从应用目录，拷贝到代码仓库的临时目录
