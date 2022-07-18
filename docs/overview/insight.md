---
layout: default
parent: Overview
title: Insight
permalink: /overview/insight
nav_order: 2
---

洞见提供的是一种[架构自治服务](https://www.phodal.com/blog/architecture-self-governance-service/)。 它是一种面向架构分析领域的数据自助服务。它提供了一种集成一体的数据分析方案，让开发人员、架构师、管理者等可以根据不同任务，自由搭配、组合出适用于自身洞察需求的任务/函数。

## 为什么我们需要架构自治服务？

**Log4j 的跟踪**

我们从 SourceGraph 的 Insight 工具上获得了启发，在这个工具的 Demo 上，它提供了一个 Log4j 版本的趋势跟踪。开发人员可以通过编写表达式，诸如于：>= 1.12.0 的方式来进行数据统计。于是，我们又一次地迎来了 aha 时刻：这不就是在过去的几个月里，诸多 ArchGuard 用户面临的一类痛点吗？对于的 IT 大型组织来说，从治理的层面来说，这种跟踪能提供更高的全局视野。

**改变是一种进行时**

从一个 “无序” 的状态到一个 “有序” 的时期，都需要一个很长的过程。这种缓慢的过程里，每个人或者组织的应对方式都是不同的，有的是可视化，有的是通过数据。不论采用的是何种方式，它都需要对于进行时的数字化。

**最佳实践的局限性**

技术专家的日常，总是会向人传播各种 “最佳实践”，那并不是人们所需要的。于多数人而言，他们更想要的是能解决当前的问题，需要的是一种最好的实践。这种实践可能是代码上的实践，分层架构上的实践，边界划分上的实践。除此以外，看上去 “标准化” 的架构度量模型，往往很难以在多数大型组织上适用。

## ArchGuard 架构洞见

架构洞见（Insight）查询的表示形式：

```
dep_name == /.*dubbo/
|        |         |
|        |         |
|        |         |
└─字段    └─ 比较符  └─ 值
```

- 字段。对应于数据库中的表。
- 比较符。即：`==`、`>`、`<`、`>=`、`<=`、`!=`。
- 值。以 `'`、`"` 和 <code>\`</code> 在始尾表示字符串，`/` 在始尾表示为正则，`@` 在始尾表示为模糊匹配。
  - 字符串（QueryMode.StrictMode）。`'xxx'`、`"xxx"`、<code>\`xxx\`</code> 的形式，即视为字符串。
  - 正则（不推荐，QueryMode.RegexMode）。`/xxx/` 的形式，即视为正则。
  - 模糊匹配（**建议**，QueryMode.LikeMode）。`@xxx@` 的形式，即视为模糊匹配。

重点：出于性能原因，不建议采用正则表达式，建议采用**模糊匹配**的方式。模糊匹配采用的是数据库自带的 `LIKE` 方式进行的，而正则表达式则是在查询后过滤的。

查询结构为 普通查询 then 后置查询，其中：

- 后置查询仅支持**正则匹配**及**版本号匹配**
- 普通查询仅支持**其他**查询

主要的两种模式：

- 普通查询（filter in query, regular query)
- 后置查询（filter after query, post query)

如果查询中没有出现 `then` 关键字：

- 整条语句中的每条表达式都为**正则**模式, 则为仅后置查询（postquery only), 此模式下先从数据库中取出所有数据，然后执行后置查询并返回最终结果
- 整条语句由**其他**模式构成，则为普通查询（regular query only), 此模式下执行完普通查询后直接作为最终结果返回

## 查询示例

**sca**

- 说明：项目依赖（Gradle/Maven、NPM 等）
- 数据库表：`project_composition_dependencies`

支持 `dep_name` 和 `dep_version` 的查询：

- dep_name：查询某个模块的所有版本。
- dep_version：查询某个版本号，并可进行比较。

**issue**

- 说明：基于 Rule 的 issue 分析（rule-sql、rule-test、rule-webapi 等）
- 数据库表：`governance_issue`

支持 `name`、`severity`、`rule_type` 的查询：

- name：查询某个 issue 的所有版本。
- severity：查询某个级别 severity 的所有版本，如：`HINT, WARN, INFO, BLOCKER` 等
- rule_type：查询某个类型 rule 的所有版本，如：`TEST_CODE_SMELL`、`HTTP_API_SMELL`、`SQL_SMELL` 等

## 如何实现？

**解析字符串成模型**（详细见：InsightsParser.kt)

1. 原始字符串先通过 tokenizer 生成对应的 token 列表，这一步空格和\t 制表符将会被丢弃
2. 通过第一步得到的 token 列表生成 Query 对象，其含有一个解析过程中生成的`Either<QueryExpression, QueryCombinator>`列表以供后续使用，大致步骤如下：
   #### 遍历 token 列表
   1. 遇到 AND 或 OR token，则向列表内插入`Either.Right(QueryCombinator(...))`对象
   2. 遇到 Identifier token，则记录相关信息
   3. 遇到 Comparison token，同样记录相关信息
   4. 碰到 String, Like 和 Regex，首先检查有没有 Identifier 和 Comparison 相关信息，没有则抛异常，有则向列表内插入`Either.Left (QueryExpression(...))`对象
   5. 重复步骤一，直到遍历结束

**执行普通查询**（filter in query）

1. 将模型转换成 SQL 语句。
   - 如果 Query 对象中的 query 列表 中的 QueryExpression 的 QueryMode 为如下的类型，，则认为可以直接生成 SQL 语句。
     - `QueryMode.StrictMode`
     - `QueryMode.LikeMode`
   - 示例：如果模型中有 `dep_name` 和 `dep_version`，则转换成 SQL 语句，如：`SELECT * FROM project_composition_dependencies WHERE dep_name = 'dubbo' AND dep_version = '1.12.3'`。
2. 执行 SQL 语句，并返回结果。

**执行查询后过滤**（filter after query）

执行后置查询，仅支持`QueryMode.RegexMode`

以普通查询的结果为输入进行后置查询，然后返回最终结果
