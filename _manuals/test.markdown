---
layout: single
title: 操作手册｜测试工具
header:
  overlay_filter: "rgba(99, 183, 175, 0.7)"
  overlay_image: /assets/images/background2.jpg
sidebar:
  nav: "docs"
permalink: /manuals/arch-test/
toc: true
---

## A/B 测试套件工具
> 源自：Thoughtworks (未集成ArchGuard)
{: .notice--warning}

### 工具适用场景

- 当系统业务黑盒的情况下，可以使用A/B测试套件，对比新旧系统执行结果是否一致来确定业务没有被修改

### 步骤

- 准备数据，并把数据库数据做成docker镜像，作为基准化的测试数据。
- 将Goreplay部署到旧的系统上，录制操作
- 部署新旧系统，回放Goreplay路数数据，使用Diffy对比请求结果，以及最终两个数据库中数据是否一致
