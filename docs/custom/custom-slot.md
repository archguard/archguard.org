---
layout: default
title: Custom Slot
parent: Custom
nav_order: 13
permalink: /custom/custom-slot
---

Slot（数据槽）是 ArchGuard 中用来构建数据分析流的一种机制。最典型的用法是在 analyser 分析完之后，结合 rule 来对数据进行分析。

接口实现见：Slot.kt。

SQL 示例：

```kotlin
class SqlRuleSlot : Slot {
    override var material: Materials = listOf()
    override var outClass: String = Issue.Companion::class.java.name

    override fun ticket(): Coin {
        return listOf(String::class.java.name)
    }

    override fun prepare(items: List<Any>): List<Any> {
        val ruleSets = listOf(SqlRuleSetProvider().get())
        this.material = ruleSets
        return ruleSets
    }

    override fun process(items: List<Any>): OutputType {
        return SqlRuleVisitor(items as List<String>).visitor(this.material as Iterable<RuleSet>)
    }
}
```

- `ticket()` 用于告知 SlotHub 当前的 Slot 所需要的数据类型
- `prepare()` 用于做自身数据处理的准备
- `process()` 为处理数据的逻辑。
- `outClass` 用于告知 SlotHub 输出的类型，用于输出数据的再次处理。
