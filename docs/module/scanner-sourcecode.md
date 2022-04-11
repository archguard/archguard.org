---
layout: default
parent: Modules
title:  "源码分析"
permalink: /modules/scanner/sourcecode
nav_order: 2
---

## 模型

源码分析基于 [Chapi](https://github.com/modernizing/chapi)

Chapi 通过 [Antlr](https://www.antlr.org) 来进行语法分析，以构建统一的代码模型。 在构建时，会去**忽略不必要的内容：诸如表达式、条件语句等**。

模型示例（详细见 Chapi 的 README）：

```json
{
    "Imports": [],
    "Implements": [
        "PersistenceObject<Blog>"
    ],
    "NodeName": "BlogPO",
    "Extend": "",
    "Type": "CLASS",
    "FilePath": "",
    "InOutProperties": [],
    "Functions": [
        {
            "IsConstructor": false,
            "InnerFunctions": [],
            "Position": {
                "StartLine": 6,
                "StartLinePosition": 133,
                "StopLine": 8,
                "StopLinePosition": 145
            },
            "Package": "",
            "Name": "toDomainModel",
            "MultipleReturns": [],
            "Annotations": [
                {
                    "Name": "Override",
                    "KeyValues": []
                }
            ],
            "Extension": {},
            "Override": false,
            "extensionMap": {},
            "Parameters": [],
            "InnerStructures": [],
            "ReturnType": "Blog",
            "Modifiers": [],
            "FunctionCalls": []
        }
    ],
    "Annotations": [],
    "Extension": {},
    "Parameters": [],
    "Fields": [],
    "MultipleExtend": [],
    "InnerStructures": [],
    "Package": "adapters.outbound.persistence.blog",
    "FunctionCalls": []
}
```
