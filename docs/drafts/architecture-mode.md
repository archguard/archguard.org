---
layout: default
parent: Posts
title:  "一个验证中的架构模型"
categories:
- Blog
- ArchGuard
---

## 为什么要给架构建模？
ArchGuard 作为架构治理平台，“架构”作为核心概念贯穿始终，没有模型，何谈实现。因此，对“架构”这个有些抽象的词汇，我们开始尝试着对它一点点具象开来。
在[为“架构”再建个模：如何用代码描述软件架构?](https://www.phodal.com/blog/architecture-model)中提到为了实现对架构的治理，有两个核心的部分就是架构模型、架构治理模型。这次我们探究的就是“架构模型”这一部分。

## 那么什么是架构？
先来重新看下几个定义:

《软件架构：架构模式、特征及实践指南》一书中 Neal Ford 对于架构的定义：
```
软件架构中包含系统的结构、系统必须支持的架构特征、架构决策以及设计原则。系统的结构是指实现该系统的一种或多种架构风格（如微服务、分层和微内核等）。架构特征定义了系统的成功标准。架构决策定义了一组关于如何构建系统的规则。设计原则是关于如何构建系统的非必须遵循的指导原则。
```

Bob 大叔（Robert C. Martin）的《架构整洁之道》书中的定义：
```
软件系统的质量是由它的构建者所决定的，软件架构这项工作的实质就是规划如何将系统切分成组件，并安排好组件之间的关系，以及组件之间互相通信的方式。
```

在 TOGAF（The Open Group Architecture Framework）中对架构有这么一个定义：
```
Architecture = Structure of Components + Relationships + Principles & Guidelines
```

这样看来，一些模糊的描述，仿佛逐渐清晰了起来。这些定义都有一些共同的部分，比如“组件”，“组件间的关系”，“指导原则”以及对于“架构风格”这个维度的泛化分析。


## 如何为架构建模？
架构是静态的，也是动态的，这个动态体现在架构处于设计到开发的不断演进，也体现在开发到运行的实际work。

这就有了 ArchGuard 的三态架构模型
- 设计态
- 开发态
- 运行态

#### 设计态
设计态是目标架构。目标架构简单来看的话，应当是符合某种特定架构风格的架构，比如分层架构，六边形架构等。
但是，基于现实来看，很难会有某个架构完全符合到标准标准架构风格，基于现实的权衡取舍，会有属于适合与当前状况的适配架构设计。甚至，会有多种架构风格混合使用。

到这里，仿佛有了一点点疑问，我们的目标架构一定要是标准的吗？不标准的架构会不会本身就有问题？

这个我们也思索了很久，但 ArchGuard 作为给架构师的工具，是为架构师服务的，将评判架构好坏的权力交给架构师，ArchGuard 只负责提供基于架构师意愿的最高效好用的效率提升。

所以这里，没有特定的规则，选取了 DSL 的方式，将目标架构设计的自由最大限度的交由架构师。

架构工作台己就绪，DSL 设计进行中，敬请期待！

#### 开发态
开发态对应的实现架构。对于实现架构而言，是对系统现状的展示，从现有系统中分析出当前架构。通过对目标架构和实现架构的对比分析，可以对目标架构的落地进展进行追踪，并且通过对目标架构和实现架构减小偏差，真正实现架构守护。

```mermaid
classDiagram
class ArchSystem {
	String id
	String name
	Architecture architecture
	List~ArchSystem~ subSystems
}

class Architecture {
	List~ArchComponent~ components
	List~ArchConnection~ connections
	ArchLinter: linter
}

class ArchComponent {
	String name
	ArchComponentType type
	List~ArchComponent~ components
}

class ArchComponentConnection {
	String source
	String target
}

class ArchLinter {
	String name
}

class LayeredArchitecture {
	List~ArchLayer~ archLayers
}

class MicroserviceArchitecture {
	List~ArchService~ archServices
}


ArchSystem <-- Architecture
Architecture <-- ArchComponent
Architecture <-- ArchComponentConnection
Architecture <-- ArchLinter
Architecture <|-- LayeredArchitecture
Architecture <|-- MicroserviceArchitecture

```


#### 运行态
运行态是体现在 APM、Docker、k8S 等等上的执行时架构。执行架构是对实现架构的补充，进一步验证当前架构的实际运行情况。但是，当我们观测到执行架构时，代码实现已经完成，这时再回过头来改动，成本巨大。所以，这一阶段的架构，更多的充当的是一个监控验证的作用。

#### 贯穿三态，聚焦治理
在整个三态过程中，架构治理的成本逐步增加。在设计态，架构师有足够自由的方式来制定目标架构，在运行态，是对现实情况的反馈监控。因此，ArchGuard 对于架构治理的重点放在了开发态，在可治理的初期就进行介入，守护架构开发的整个流程。
 
 ![](../../assets/images/ArchModel-Flow.png)

 
 
