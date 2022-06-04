---
layout: default
title: Interactive Analysis
parent: Setup
nav_order: 2
permalink: /setup/interactive-analysis
---

## 原型参考与设计：可交互环境与文档体验

什么是文档？什么是代码？两者没有一个明确的界限，文档是可执行的，代码也是可执行的。不过，从最终的形态上来说，它们都是知识。所以，重点依旧在于如何将这些知识显式化。所以从原型参考上，我们关注于：可交互环境与文档体验设计。

### 可交互环境：Jupyter & Zeppelin &  Nteract

作为交互性编程的业内代表，Jupyter 成为了我们研究的第一个对象。不过，从实现上，我们并没有从它本身的源码上汲取到太多的内容（ “代码”）。反而是，围绕于它的生态及竞争对手上，我们看到了一些更有意思的亮点，诸如于 Kotlin Jupyter、Zeppelin、Nteract 等。

* Nteract 提供了一系列的组件、SDK 来，用来构建交互式应用，诸如于消息通信等等。然而 Nteract ，在设计的时候主要是在 Electron 环境下使用，所以有一些库是无法使用的，如 ZeroMQ —— 设计时是只针对于 Node 环境的。
* Zeppelin 构建了一个更简单的执行环境（Interpreter），与 Jupyter 的 Kernel API 相比，它可以提供一些更有意思的实现层面的抽象。
* Kotlin Jupyter 则成了我们现在实现的一个基石。因为它还处于早期试验阶段，我们在构建的过程中，遇到过一系列的依赖包丢失的情况。

回过头来看，我们应该需要再回去看看 Jupyter 的抽象接口，或许能再提供更多的思路。

### 文档阅读体验与文档工程体验

对于文档体验来说，我一直主张应该关注于两个部分：

* 文档阅读体验。即向读者提供的文档体验。
* 文档工程体验。即向工程提供的文档编写体验。（这一部分往往容易被忽视）

对于文档体验来说，除了用于说明性编程的各类架构图，还需要提供各类的定义化能力。其参考来源来源主要是：我们日常的开发中的编程语言的文档编写，详细可以参考《[API 库的文档体系支持：主流编程语言的文档设计](https://www.phodal.com/blog/api-ducumentation-design-dsl-base/)》与《[文档工程体验设计：重塑开发者体验](https://www.phodal.com/blog/documentation-enginnering-experience-design/)》。

而诸如于 Mermaid、Graphviz 这一类的图即代码（diagram as code），它们在两者提供了一个很好的平衡（只针对于程序员）。

## 技术评估：DSL、REPL 与编辑器

再回到实现上来，在进行架构工作台的技术评估时，我们关注于架构师编写的 DSL（领域特定语言）语法、REPL（read–eval–print loop） 运行环境以及用于交互的编辑器。其核心关注点是：如何构建更好的[开发者体验](https://github.com/phodal/dx)，一个老生常谈的、难话题。

### DSL 语法：Antlr vs Kotlin DSL

在 ArchGuard 中，主要使用的是 Antlr 框架来进行不同语言的语法解析（即 Chapi）。因此，使用 Antlr 来设计一个新的 DSL 及其编译器前端，对于我们而言，并不存在技术上的挑战。甚至于，在以往的经历中，我们也有大型 IDEA 插件架构设计与开发的经历。

然而对于 DSL 来说，我们要考虑的核心因素是：

* **语法的学习成本。**
* **语法的体验设计。**
* **语法的编辑器/IDE 支持。**

如果语法只是是个语言的 API，那它能大大降低学习成本。虽然 Kotlin 有点陌生，但是 Groovy + Gradle 都很熟吧。于是乎，我们采用的方式是基于 Kotlin 语言自带的 [Type-safe builders﻿](https://kotlinlang.org/docs/type-safe-builders.html) 来构建构建 DSL。官方给的一个参考示例是 Ktor 的路由示例：

```javascript
routing {
    get("/hello") {
        call.respondText("Hello")
    }
}
```

除了已经有丰富的 IDE、编辑器的支持之外。在构建**架构适应度函数**时，也可以使用语言库提供的数学功能，以便于定制各类的计算规则。

### 架构 REPL：Kotlin Scripting vs Kotlin Jupyter

而对于构建一个交互式架构 REPL 来说，我们需要需要考虑的一个核心点是：**构建执行上下文（EvalContext）**。即后面运行的代码是依赖于前面代码提供的上下文的，如变量等：`val x = 2 * 3`，后续就可以使用 `x` 。

对于我们来说，有两个选择：

* Kotlin 语言自带的试验性功能：Kotlin Scripting 提供了一种无需事先编译或打包成可执行文件即可将 Kotlin 代码作为脚本执行的技术。因为，对于我们来说，只需要构建我们的 DSL 包，就可以直接执行。


* Kotlin Jupyter 的实现也是基于 Kotlin Scripting 提供了一系列的 API 封装。

在 REPL 上，起初我们纠结于自己实现，还是基于 Kotlin Jupyter，毕竟 Jupyter 包含了一系列的不需要的代码。后来，发现代码好复杂，虽然都是 MIT 协议，但是我们也不想维护一个不稳定功能的下游版本。

因此，在最后，我们基于 Kotlin Jupyter 的 API 构建了 ArchGuard 的架构 REPL。

### 探索编辑器：ProseMirror vs Others

对于编辑器来说，考虑的核心点是：**组件扩展性**。即，可以按需添加用于展示图表的组件，又或者是其它的结果展示相关组件。

在设计上 Jupyter、Zeppelin 采用的是块（Cell）式编辑器，即文档是按**块**的形式切开来的。稍有区别的是 Jupyter 基于 CodeMirror，则 Zeppelin  是基于 Monaco Editor。这种基于块式的编辑功能，有点割裂，提供的交互体验对于纯键盘操作不友好。

于是乎，为了探索更好的文档交互方式，我们陆陆续续参考了一系列的编辑器：CodeMirror、Draft.js、Lexical、ProseMirror 等。ProseMirror 是 CodeMirror 作者的另外一个作品，融合了 Markdown 与传统的 WYSIWYG 编辑器。也就是说：即可以写 Markdown 也可以用富文本的方式（PS：在编写此文时，我使用的 Quake 的底层也是 ProseMirror）。即，它可以同时满足两类人的需求，**使用 Markdown 和不使用 Markdown**，他们能都从编辑器上获得自己的鼠标（markdown）和键盘（富文本）。

探索完之后，我们发现基于 ProseMirror 的 [rich-markdown-editor](https://github.com/outline/rich-markdown-editor) 能提供所需要的功能。只需要编写一些**类** ProseMirror 插件，不需要编写大量的 markdown 相关的处理功能。

## 落地：构建数据通讯与结果呈现

为了验证整个 PoC （Proof of Concept，概念证明）是可行的，接下来就是让数据作为胶水把一切串联起来，构建这样一个完整的端到端示例：


1. 前端 → REPL。在前端编写 DSL，执行运行，交数据发送给 REPL。
2. REPL → 前端。REPL 解析数据，将后续的 Action，返回给前端。
3. 前端 → 后端。前端根据 Action，决定是显示架构图，还是发请求给后端。
4. 后端 → 前端。后端根据前端的请求，执行对应的命令，再将结果返回给前端。
5. 前端。前端再根据后端的数据处理。

所以，其实核心的部分只有一个：**模型的设计**，诸如于：Message 和 Action。

### 数据传输与处理：Message 模型

在 REPL 服务中，通过 WebSocket 接收到前端的数据之后，就需要将其转换为对应的数据，并返回给前端。如下是在 PoC 中，我们所定义的 Message ：

```javascript
data class Message(
    var id: Int = -1,
    var resultValue: String,
    var className: String = "",
    var msgType: MessageType = MessageType.NONE,
    var content: MessageContent? = null,
    var action: ReactiveAction? = null,
)
```

在执行前端传入的代码后，会根据不同的执行结果，返回一些后续的 Action 信息（代码中的 `ReactiveAction`），以及对应的数据（在 `action` 中）。

### REPL：构建执行环境

对于 REPL 来说，我们还需要做的事情有：


1. 构建 REPL 环境。如添加 ArchGuard DSL 的 jar 包，以及对应的 Kotlin Scripting、Kotlin Jupyter 的 Jar。
2. 添加 `% archguard` Magic。添加一个自定义的 `LibraryResolver` 。

虽然对于 REPL 不熟悉，但是幸好在有 Kotlin Jupyter 的源码作为参考，这个过程并不算太痛苦。虽然过程，也是异常的痛苦：没有可用的文档、环境只为 Jupyter 设计、只能看测试用例。但是，至少还是可以看**测试用例** —— 测试是个好东西。

在开发环境下，会加载 Java 运行环境的 classpath （详细见：**KotlinReplWrapper**）：

```javascript
val property = System.getProperty("java.class.path")
var embeddedClasspath: MutableList<File> = property.split(File.pathSeparator).map(::File).toMutableList()
```

在运行环境下，则会只引用所需要的 jar 包。两个环境的不一致，也需要在后续探索一下如何进行优化。

### 编辑器：

在我们落地的过程中，编辑器的实现被分为两部分，一个是编写 ProseMirror 插件，另外一个则是完善 Monaco Editor 的感知。

**ProseMirror** **插件编写**

针对于代码块，编写了 `LivingCodeFenceExtension` 插件替换了 rich-markdown-editor 中的代码块语法功能，并指向了 Monaco Editor 组件：

```javascript
<CellEditor
  language={language}
  code={value}
  removeSelf={this.deleteSelf(props)}
  codeChange={this.handleCodeChange}
  context={this.options.context}
  languageChange={this.handleLanguageChange}
/>
```

再围绕于两个编辑器，构建了一系列的交互，如：语言变更、删除代码块、执行代码等。

**围绕 Monaco Editor** **构建 DSL 开发者体验**

Monaco Editor 的完善，主要会围绕于：添加代码高亮、自动填充与智能感知。现在，只完成了基本的功能，还有很多功能需要后续进行探索。

### 结果展示与图形

对于结果来说，其核心的部分在 `ResultDispatcher` 上，顾名思义，根据不同的结果来展示不同的展示结果，诸如于：

```javascript
switch (result.action.actionType) {
  case ActionType.CREATE_REPO:
    return <BackendActionView data={data} actionType={BackendActionType.CreateRepos} />;
  case ActionType.CREATE_SCAN:
    return <BackendActionView data={data} actionType={BackendActionType.CreateScan} />;
  case ActionType.GRAPH:
    return <GraphRender result={result} context={context}/>;
}
```

而为了更好的呈现**技术相关的图形细节**，我们在 ArchGuard 中引入了第**五个图形库**（由于几个图形库的存在，构建变成了一件痛苦的事，大概是最大的技术债了）：Mermaid。先前的 Echart.js 可以为我们提供低成本的图形编写，D3.js 则是提供了更灵活的定制能力。

## 最后，尝试一下部署吧

在我们写完 PoC ，并自信满满地打了 tag 之后，发现自动构建出来的 Docker 镜像是不 work 的，这大半夜的。最后，总结下来，原因有两：


1. 未配置 Nginx 的 WebSocket 。
2. Kotlin REPL 依赖于 unpack 环境。

好在，只要再快速修复（quickfix）、打个 tag 就能解决了。事实证明，但凡是想 quickfix，都没法 quickfix。

### 配置 WebSocket

首先，根据网上的文档，配置好对应的 WebSocket：

```javascript
location /ascode {
  proxy_pass http://archguard-backend:8080;
  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $connection_upgrade;
}
```

于是，重构构建镜像之后，发现后端又出问题了，运行的 REPL 环境出错。

### 配置 Kotlin REPL classpath

如上所述，REPL 在代码中配置的是：

```javascript
val property = System.getProperty("java.class.path")
var embeddedClasspath: MutableList<File> = property.split(File.pathSeparator).map(::File).toMutableList()
```

但是，在 Spring 打包后，classpath 只有一个，并且 Kotlin Scripting 会有一系列的问题，这个时候需要 `requiresUnpack`。详细见：Spring Gradle 插件文档：《[Spring Boot Gradle Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/current/gradle-plugin/reference/htmlsingle/)》，只是对应的解释说明：必须从 fat jars 中解压才能运行的**库列表**。 将每个库指定为具有 <groupId> 和 <artifactId> 的 <dependency>，它们将在运行时解包。

效果上，就是 Spring 在运行的时候，会将对应的库从 BootJar 中解压出来到临时的目录。

```javascript
tasks.withType<KotlinCompile> {
    kotlinOptions {
        jvmTarget = "1.8"
        freeCompilerArgs = listOf("-Xjsr305=strict")
    }
}

tasks.withType<BootJar> {
    requiresUnpack("**/kotlin-compiler-*.jar")
    requiresUnpack("**/kotlin-script-*.jar")
    requiresUnpack("**/kotlin-jupyter-*.jar")
    requiresUnpack("**/dsl-*.jar")
}
```

当然，编码上，一个一个去找太麻烦了，于是就找到临时目录遍历一下：

```javascript
val tempdir = compiler[0].parent
embeddedClasspath = File(tempdir).walk(FileWalkDirection.BOTTOM_UP).sortedBy { it.isDirectory }.toMutableList()
```

最后，生成的 classpath 值如下所示：

```bash
ikotlin - Classpath used in script: [/tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-script-runtime-1.6.21.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-jupyter-kernel-0.11.0-89-1.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/dsl-2.0.0-alpha.12.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-compiler-embeddable-1.6.21.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-jupyter-api-0.11.0-89-1.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-jupyter-lib-0.11.0-89-1.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-jupyter-shared-compiler-0.11.0-89-1.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-jupyter-common-dependencies-0.11.0-89-1.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f/kotlin-script-util-1.6.21.jar, /tmp/app.jar-spring-boot-libs-5edaa25c-496e-4eb0-b7d6-1118a8cc280f]
```

如此一来，它总算能正确启动了，然后再打一个新的 tag：`v2.0.0-alpha.12` 。


