---
layout: default
title: Resources
nav_order: 100
permalink: resources
---

## Flink

[Flink 从 0 到 1 学习—— 分享四本 Flink 国外的书和二十多篇 Paper 论文](https://xie.infoq.cn/article/0c69c8a21ab99f28d008872ac)

## Metrics

### **[度量 Autonomy 的指标](https://github.com/taowen/modularization-examples/blob/master/docs/Part1/AutonomyMetrics.md)**

Autonomy 的愿景就是尽量减轻上述的症状，让拆分出来的代码更独立（更具有Autonomy）。从而新需求需要的沟通可以更少，不需要的功能也可以比较容易被干掉。

假定业务逻辑肯定要拆分，拆分成

    文件
    文件夹
    Git仓库

以 Autonomy 为目标的话，我们可以很容易判断 Git 仓库是主要的着手点。为了减少沟通，每个块业务和产品经理，应该有个对口的 Git 仓库。不选择文件和文件夹的主要原因是 Git 仓库一般对应了编程语言的 Package 的概念，如果是 JavaScript 的话，对应的有 package.json 文件。使用 Git 仓库比较容易依赖编译器进行依赖检查。而选择了文件或者文件夹，则很容易变成表面上拆开了，但是仍然有调用关系，实际上仍然和写在一起没有区别。

### **[度量 Consistency 的指标](https://github.com/taowen/modularization-examples/blob/master/docs/Part1/ConsistencyMetrics.md)**

一致性指标是对“相乘组合关系”的Git仓库的额外要求，是为了防御常见的设计错误：

    过度抽象：强行把一堆不相关的东西拧巴到一起。所以引入了“必要参数占比”和“咨询量”这两个指标。
    过早抽象：没想清楚的情况下，根据局部的一两处重复就抽出一个可复用的东西。所以引入了“使用次数”，“使用率”和“阻断率”这三个指标。

