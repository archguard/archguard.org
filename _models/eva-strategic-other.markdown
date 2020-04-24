---
layout: single
title: 策略·模式·方法 ｜ 业界其他评估方式与模型
header:
  overlay_filter: "rgba(99, 183, 175, 0.6)"
  overlay_image: /assets/images/background.jpg
sidebar:
  nav: "models"
permalink: /models/evaluate-strategic/other/
classes: wide
---

## 业界常见评估方式

传统软件架构评估方法按评估形式，一般分为三种。
* **调查问卷**，由对系统架构了解的专家人等，以回答和总结问卷的形式，对系统架构做出主观评估
* **度量**，将软件系统架构各项指标完全量化，通过客观的数字指标来评估架构的好坏
* **场景评估**，即挑选出重要的系统使用场景(如系统用户如何使用系统的 )，根据不同场景中各架构的表现分别作评估

## 业界评估其他模型

### SAAM
[Software Architecture Analysis Method](https://resources.sei.cmu.edu/library/asset-view.cfm?assetid=29288)

SAAM卡耐基梅隆大学软件工程研究所的Kazman等人于1983年提出的一种非功能质量属性的体系结构分析方法，是最早形成文档并得到广泛使用的软件体系结构分析方法。最初它用于比较不同的软件体系的体系结构，用来分析SA的可修改性，后来实践证明也可用于其它的质量属性如可移植性、可扩充性等，发展成了评估一个系统的体系结构。

### ATAM
[Architecture Tradeoff Analysis Method](https://baike.baidu.com/item/%E8%BD%AF%E4%BB%B6%E4%BD%93%E7%B3%BB%E7%BB%93%E6%9E%84%E5%88%86%E6%9E%90%E6%96%B9%E6%B3%95/20837104?fr=aladdin#3)

ATAM是在SAAM的基础上发展起来的，SEI于2000年提出ATAM方法，针对性能、实用性、安全性和可修改性，在系统开发之前，对这些质量属性进行评价和折中。SAAM考察的是软件体系结构单独的质量属性，而ATAM提供从多个竞争的质量属性方面来理解软件体系结构的方法。使用ATAM不仅能看到体系结构对于特定质量目标的满足情况，还能认识到在多个质量目标间权衡的必要性。


### CBAM
[Cost Benefit Analysis Method](https://wikieducator.org/Change_with_digital_technologies_in_education/Personal_context/Concerns-based_models)

CBAM在ATAM（构架权衡分析方法）上构建，用来对构架设计决策的成本和收益进行建模，是优化此类决策的一种手段。