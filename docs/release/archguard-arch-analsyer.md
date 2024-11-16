---
layout: default
parent: What's new in ArchGuard
title: ArchGuard Arch Analsyer
permalink: /release/archguard-arch-analsyer
---

TL;DR：[https://github.com/archguard/archguard](https://github.com/archguard/archguard)

过去的几个月里，我们一直在探索用 AI 辅助跨项目、跨大量微服务的系统的开发。其中一个重要的话题就是，从现有的软件架构去生成知识，文档是落后、多版本的，
只有代码才保留着真相。

> ArchGuard 是一个由 Thoughtworks 发起的面向微服务（分布式场景）下的开源架构治理平台。它可以在设计、开发过程中，帮助架构师、
> 开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。

在经历了大量的分析与实践之后，我们从 ArchGuard 提取了新的 analyser：Architecture Analyser。与现有的代码、Git、OpenAI、Estimate
等 analyser 相比， Architecture Analyser 是一个集大成者，它集成了其它 analyser 的功能，同时还提供了更多的功能。

## 生成式 AI 时代的知识汲取

与其说是，AI 时代的架构知识，不如说是 AI 时代的架构知识生成。过去，我们通过分析 API 调用链等，并不能能好的得到业务、架构等信息。而，当我们提供了
相对充裕的信息，如：API 调用链、数据库依赖、消息队列依赖等，就能让 AI 生成出对应的信息资产。

### 场景 1：领域模型中的领域知识

对于后端代码而言，知识的核心在于其 “领域知识”，即在富血模型、领域驱动设计等一系列技术实践方式中，我们通过领域模型来表达业务逻辑。在不同的语言、
工具和平台中，它们有着各种不同的实现，如：

- 在胖服务层的 MVC 架构中，我们可以结合数据库表来获取关键的领域知识；
- 在 DDD 四层架构下，我们可以通过领域模型来获取领域知识；
- 在采用 Protobuf 的微服务架构中，我们可以通过解析 IDL 文件来获取领域知识。
- ……

这样一来，我们就可以让结合类名、方法名、字段名等信息，来生成出对应的领域知识。如下结合是 ArchGuard 分析器的输出：

![](/assets/images/genai-domain-description.png)

```markdown
上报播放数据，包括应用、客户端、版本、渠道、位置、查询ID、设备ID、会话ID、总时长、播放时长、数据类型、页面和模块。
```

在下一步中，就可以结合用户的问题来找到对应的匹配代码。

### 场景 2：从调用链中汲取业务知识

过去，在 ArchGuard 中，我们运行通常 `feat-datamap` 模块来生成数据库地图。它只能帮我们做一些可视化，由人来判断，潜在的、可能的业务逻辑。
而当我们由 ArchGuard 分析完后，就可以让 AI 生成出对应的业务逻辑。

![](/assets/images/genai-database-call.png)

如下是 ArchGuard 分析器的输出：

```yaml
packageName: go-common/app/interface/openplatform/monitor-end/dao
methods: Dao.Groups
sqls: `SELECT id, name, receivers, `interval`, ctime, mtime FROM `alert_group` WHERE id in (0) AND is_deleted = 0`
```

就可以生成如下的信息：

```markdown
查询未删除的告警组详情，涉及字段包括：ID、名称、接收者、告警间隔、创建时间及更新时间。
```

在结合由 AI 生成领域词典之后，我们可以得到更准确的描述。但是我的场景之下，只需要这样一个简单的描述，具体可以根据实际情况来调整 prompt。

## ArchGuard 架构分析器如何助力分析领域知识？

ArchGuard 架构分析器的本质是对原有的知识进行再提炼，以将专家经验转换为分析工具和数据。再结合 AI 的生成能力，替换传统的人力分析方式，以解决
知识的提取问题。

### ArchGuard 的架构模型

既然讨论到架构分析，那肯定就涉及到 ArchGuard 的架构模型。由于当前阶段的 ArchGuard 更多的是开发态的数据分析，所以早期我们采用的是《实用体系软件结构》
中的四层架构：

- 概念架构。领域特定组件
- 模块架构。系统、子系统、模块、层
- 执行架构。进程、任务、线程、客户端、服务器、缓冲区、消息队列
- 物理架构。文件、目录、链接器库、包、程序库

详细见，我们在 GitHub 的文档：https://archguard.org/concepts 。如下是 IDEA 可视化出来的架构模型：

![](/assets/images/arch-view-model.png)

当然，这个模型还有待进一步优化，比如我们添加的 `outboundService`、`architectureStyle`，在当前尚还属于一个不太适合的位置。

#### 场景示例：支持策略化的 Code Review

在热门的 Code Review 领域，除了结合 Sonarlint 之外，我们可以基于物理架构来设计多种 review 策略。诸如于：

![](/assets/images/core-model.png)

- 基于变更频率与行数，来决定 review 的上下文；
- 基于代码复杂度，来决定 review 的优先级；

不过，考虑到生成式 AI 的局限性，还是有待进一步研究。

### ArchGuard 架构分析器的数据来源

ArchGuard 架构分析器的数据来源于我们持续丰富的架构知识库，包括：

- 在 1.0 版本中，支持的架构度量
- 在 1.4 版本中，支持了代码中的：代码到数据库调用关系的展示
- 在 1.6 版本中，支持了对于软件依赖的分析
- 在 2.0.0 版本中，支持的代码复杂度分析
- 在 2.0.3 版本中，支持的 OpenAPI 分析
- 在 2.2.2 版本中，我们提供了对 Protobuf 文件的解析和分析功能，支持自动提取服务、消息、接口等元素，构建服务地图和依赖关系图。
- ……

随着，越来越多的公司使用 ArchGuard，其数据源也越来越丰富。

## 如何使用 ArchGuard 架构分析器？

### 步骤 1：使用 CLI 运行

你可以直接从 GitHub 下载最新的 `scanner_cli-2.2.8-all.jar`，又或者是通过 shell 来一键安装 ArchGuard 架构分析器：

```bash
curl -fsSL archguard.org/install-cli.sh | bash
```

随后，你可以通过如下命令来运行 ArchGuard 架构分析器：

```bash
archguard --language=go --type=architecture --output=json --path=.
```

（PS：如果你使用的是 `jar` 包，请使用 `java -jar scanner_cli.jar --language=go --type=architecture --output=json --path=.`）

其中，`--language` 用于指定语言，`--type` 用于指定类型，`--output` 用于指定输出格式，`--path` 用于指定扫描路径。随后，会输出
`0_architecture.json` 便是 ArchGuard 分析的架构数据。还可以通过如下命令来上传到远程服务器：

```bash
archguard --language=go --type=architecture --output=http --server-url=http://localhost:3000 --path=. --system-id=1
```

其中的 `--output=http` 用于指定输出到远程服务器， `--server-url` 用于指定远程服务器地址，`--system-id` 是用于指定后端标识。

### 步骤 2：实现服务端

默认的，ArchGuard 架构分析器默认的路径是 `/api/scanner/1/reporting`，如你可以使用 `curl` 来上传数据：

```
curl -X POST -H "Content-Type: application/json" -d @0_architecture.json http://localhost:3000/api/scanner/1/reporting
```

对应的，只需要在服务端实现对应的接口即可。

## 总结

复杂的问题得回归复杂的本源：软件架构。ArchGuard 架构分析器的发布，是我们对于软件架构的一次尝试。我们希望通过 ArchGuard 架构分析器，让 AI
能够更好的理解软件架构，从而更好的生成软件知识。
