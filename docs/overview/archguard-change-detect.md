---
layout: default
parent: Overview
title: 变更影响分析
permalink: /overview/change-detect
nav_order: 15
---

通过分析和配置系统潜在的代码修改点，进而通过依赖关系，分析出变更的影响范围。它即能帮助架构师分析需求的影响，又能帮助测试人员更精准地测试系统中的内容。

ArchGuard 代码变更影响分析，会根据 commit id，选择某一区间内的代码变更的影响范围。

## 代码变更影响分析的实现原理

核心逻辑：

```kotlin
override fun analyse(): List<ChangedCall> = context.run {
    logger.info("diff from $since to $until on branch: $branch with path: $path")
    val differ = GitDiffer(path, branch, depth)
    val sinceRev = since.substring(0, minOf(SHORT_ID_LENGTH, since.length))
    val untilRev = until.substring(0, minOf(SHORT_ID_LENGTH, until.length))
    val changedCalls = differ.countBetween(sinceRev, untilRev)

    client.saveDiffs(changedCalls)

    changedCalls
}
```

即，通过 `GitDiffer` 获取两个 commit 之间的代码变更，然后结合静态代码分析调用链，分析出变更的影响范围。

诸如于通过函数变更，分析出调用链的变更，进而分析出影响的范围。


