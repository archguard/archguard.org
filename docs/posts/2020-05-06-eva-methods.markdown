---
layout: default
parent: Posts
title:  "评估·改造·守护 ｜ 评估方法"
categories:
- Blog
- ArchGuard
---

## 代码评估

> 代码的评估通常可以使用两种方式：静态扫描工具，人工代码检视，他们之间互为补充。
{: .notice--info}

### ArchGuard



### 其他静态扫描工具
> 静态代码分析是指无需运行被测代码，仅通过分析或检查源程序的语法、结构、过程、接口等来检查程序的正确性，找出代码隐藏的错误和缺陷。统计证明，在整个软件开发生命周期中，30% 至 70% 的代码逻辑设计和编码缺陷是可以通过静态代码分析来发现和修复的。
> 
> 但是，由于静态代码分析往往要求大量的时间消耗和相关知识的积累，因此对于软件开发团队来说，使用静态代码分析工具自动化执行代码检查和分析，能够极大地提高软件可靠性并节省软件开发和测试成本。
{: .notice--info}

#### Sonar
> 一个开源的代码质量管理系统。
{: .notice--info}

* 支持超过25种语言
* 提供重复代码、编码标准、单元测试、代码覆盖率、代码复杂度、潜在Bug、注释和软件设计报告
* SonarLint可在IDE中使用， SonarQube通常与CI/CD工具集成使用，提供更全面的扫描，但通常扫描时间也会稍长，可以考虑在并行流水线中定时运行


#### CheckStyle
> Checkstyle 是在软件开发中的一种静态代码分析工具，用来检查Java源代码是否符合编码规则。
{: .notice--info}

* 常见配置： [Google style guide](https://google.github.io/styleguide/javaguide.html) // [Sun Code Conventions](https://checkstyle.org/styleguides/sun-code-conventions-19990420/CodeConvTOC.doc.html)
* 更关注代码风格： 类、属性和方法的Javadoc；属性和方法的命名规范；函数参数数量、代码行的长度的限制；标题(Header)是否存在；包的导入、类、访问控制修饰符、代码块的使用；字符间的间隔；重复代码；代码中多种复杂度的度量

#### FindBugs
> FindBugs是由Bill Pugh和David Hovemeyer创建的开源程序，用来查找Java代码中的程序错误。
{: .notice--info}

* 它使用静态分析来识别Java程序中上百种不同类型的潜在错误。
* 潜在错误可分为四个等级：恐怖的（scariest）、吓人的（scary）、令人困扰的（troubling）和值得关注的（of concern），这是根据其可能产生的影响或严重程度，而对开发者的提示。
* FindBugs操作的是Java字节码，而非源代码。


#### PMD
> PMD(Programming Mistake Detector)是一种开源分析Java代码错误的工具。
{: .notice--info}

[PMD](https://pmd.github.io/)


### 代码检视

#### 组织形式/流程
* 关键点：频繁小批、定时定量、持续改进
* 形式：集体代码检视/结对代码检视（如一对一）

#### 检视关注点
* 关注“代码对不对”与“代码好不好”
* 除了看代码流程，还可以通过检视测试案例，检视代码对不对
* 检视“代码好不好”，可以更多关注静态扫描工具扫不出来的地方，如命名是否表意、分层架构、是否需要重构到模式等
* 检视时还可以留意是否有性能、安全等的非功能性问题。如在一个多次循环中的DB操作是否会导致延时增加、连接中是否使用了SSL等安全方式等等。

## 架构评估
