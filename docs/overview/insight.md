---
layout: default
parent: Overview
title: Insight
permalink: /overview/insight
nav_order: 2
---

# ArchGuard Insight（架构洞见）

```
field:dep_name == /.*dubbo/ field:dep_version > 1.12.3
```

- 字符串。'xxx'、"xxx" 的形式，即视为字符串。

### 表达式转换

处理逻辑（详细见：InsightModel.kt)：

1. 通过 `field:` 作为分隔符，将字段名和字段值分隔开，取出其中的字段值和表达式，如：`dep_name == /.*dubbo/`，`dep_version > 1.12.3`。
2. 解析字符串，并转换表达为三部分：
   1. 字段（filed）。为了方便设计，这里的 `dep_name` 对应于数据库中的字段。
   2. 比较（comparison）。比较的类型为 `==`、`>`、`<`、`>=`、`<=`、`!=`。
   3. 过滤（filter）条件。过滤的值类型为 `string`、`like`、`regex`。
3. 

### 判断

