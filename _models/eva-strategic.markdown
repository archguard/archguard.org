---
layout: single
title: 策略·模式·方法 ｜ 评估策略
header:
  overlay_filter: "rgba(99, 183, 175, 0.6)"
  overlay_image: /assets/images/background.jpg
sidebar:
  nav: "models"
permalink: /models/evaluate-strategic/
toc: true
---

## 业务导向架构评估

### 制定评估策略的原则
> 聚焦业务价值最大方向，快速定向智能评估，务求架构决策更客观，投资更精准
{: .notice--info}

### 评估方式

传统软件架构评估方法按评估形式，一般分为三种。
* **调查问卷**，由对系统架构了解的专家人等，以回答和总结问卷的形式，对系统架构做出主观评估
* **度量**，将软件系统架构各项指标完全量化，通过客观的数字指标来评估架构的好坏
* **场景评估**，即挑选出重要的系统使用场景(如系统用户如何使用系统的 )，根据不同场景中各架构的表现分别作评估

> - ArchGuard主张从业务导向出发，聚焦业务价值最大方向 - 以是否能带来所关注的业务价值，评估当前技术策略是否适宜，让投资决策更聚焦更精准，最终牵引技术改造带来更多的业务价值。
> - 同时，ArchGuard依托多年沉淀并广被认可的技术规范，构建于强大的技术扫描内核，坚持以客观度量的方式主导评估，降低评估门槛的同时便于规模化推广。
{: .notice--warning}


### 聚焦评估阶段常见痛点
* 架构已经腐化，业务知识散落在系统各处，难以下手
* 纯靠人力评估的话，对评估人员能力要求太高了
* 没有统一的业务术语和架构表示方法，因而难以沟通
* 从组织级层面看，系统太多，如何能规模化综合评估？
* 评估出了改进项，但难以排定改造的优先级

### 相关参考
* [The Elephant in the Architecture](https://martinfowler.com/articles/value-architectural-attribute.html)
* [为什么要从业务价值导向架构决策？](https://zhuanlan.zhihu.com/p/111293116)


## 策略模型

### 市场响应力评估模型
> 市场响应力：当市场发生改变时，现有业务为了能够适应市场，业务作出反应的能力
{: .notice--info}

#### 适配场景
- 系统收集不到业务反馈，不知道业务该怎么走
- 每次新增功能都需要3，5个月才能上线，跟不上竞品更新速度

#### 评估维度

![市场响应力评估模型](/assets/images/market.png)

### 质量评估模型
> 质量：业务上线后，该业务是否能满足客户期望，有多少严重Bug
{: .notice--info}

#### 适配场景
- 测试返修率高，总是反复测试才能上线
- 经常出现上线失败，需要紧急修复
- 客户经常投诉，页面错乱，业务出错

#### 评估维度

![质量评估模型](/assets/images/quality.png)

### 可用性评估模型
> 可用性：业务不稳定，访问出错
{: .notice--info}

#### 适配场景
- 上线无法实现零停机时间
- 经常接到客户投诉，页面打不开了，连接错误

#### 评估维度

![可用性评估模型](/assets/images/reliability.png)

### 开放性评估模型
> 开放性：当出现出现创新性业务时，原有系统能不能很好的支撑
{: .notice--info}

#### 适配场景
- 新增线上渠道，系统需要花很长时间改造才能支持新渠道
- 给其他系统提供API，需要花很长时间开发接口

#### 评估维度

![开放性评估模型](/assets/images/openable.png)

## 业界其他评估模型
### SAAM
[Software Architecture Analysis Method](https://resources.sei.cmu.edu/library/asset-view.cfm?assetid=29288)

SAAM卡耐基梅隆大学软件工程研究所的Kazman等人于1983年提出的一种非功能质量属性的体系结构分析方法，是最早形成文档并得到广泛使用的软件体系结构分析方法。最初它用于比较不同的软件体系的体系结构，用来分析SA的可修改性，后来实践证明也可用于其它的质量属性如可移植性、可扩充性等，发展成了评估一个系统的体系结构。

### ATAM
[Architecture Tradeoff Analysis Method](https://baike.baidu.com/item/%E8%BD%AF%E4%BB%B6%E4%BD%93%E7%B3%BB%E7%BB%93%E6%9E%84%E5%88%86%E6%9E%90%E6%96%B9%E6%B3%95/20837104?fr=aladdin#3)

ATAM是在SAAM的基础上发展起来的，SEI于2000年提出ATAM方法，针对性能、实用性、安全性和可修改性，在系统开发之前，对这些质量属性进行评价和折中。SAAM考察的是软件体系结构单独的质量属性，而ATAM提供从多个竞争的质量属性方面来理解软件体系结构的方法。使用ATAM不仅能看到体系结构对于特定质量目标的满足情况，还能认识到在多个质量目标间权衡的必要性。


### CBAM
[Cost Benefit Analysis Method](https://wikieducator.org/Change_with_digital_technologies_in_education/Personal_context/Concerns-based_models)

CBAM在ATAM（构架权衡分析方法）上构建，用来对构架设计决策的成本和收益进行建模，是优化此类决策的一种手段。
