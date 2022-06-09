---
layout: default
title: Custom Language
parent: Custom
nav_order: 10
permalink: /custom/language
---

添加新语言的步骤：

**1. 在 Chapi 中添加语言支持**

ArchGuard 的语言 AST 解析是在 [Chapi](https://github.com/modernizing/chapi) 中提供的，可以参考 Chapi 的 README 添加语言支持。

建议采用 TDD 的方式进行。

**2. 添加新的 ArchGuard 语言插件**

在 `analyser_sourcecode` 目录下创建新的模块，以 `lang_` 开头，如 `lang_java`，并在对应的 `settings.gradle.kts` 中添加模块。

**3. 为语言添加 features 支持（如 apicalls、datamap）**

在 ArchGuard 中的 [analyser_sourcecode](https://github.com/archguard/archguard/tree/master/analyser_sourcecode) 模块中，添加对应的 features 支持。

- apicalls，参考文档：[/modules/scanner/sourcecode-api](/modules/scanner/sourcecode-api)
- datamap，参考文档：[/modules/scanner/sourcecode-database](/modules/scanner/sourcecode-database)

**4. 添加构建脚本（可选）**

如果对应语言没有自动 release，需要在 `Dockerfile` 和 `.github/workflows/cd.yaml`

**测试**

测试新语言时，可以直接通过 Scanner CLI + JSON 的方式，输出验证。对应的命令示例如下：

```
java -jar scanner_cli.jar --language=kotlin --output=json --path=. --features=datamap --features=apimap
```

注意需要更新 `dependencies/analysers` 下对应的语言包。
