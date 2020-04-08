---
layout: tool
---

# 分析工具
## Java代码依赖分析工具
源自：ThoughtWorks

状态：已集成ArchGuard

工具适用场景：

- 设置逻辑模块，可视化分析逻辑模块间的依赖关系，帮助拆分
- 查看各个方法的调用链，帮助迅速理解方法含义
- 查看各个类的调用链，帮助迅速理解类的作用范围

步骤：

- 安装ArchGuard: [https://archguard.org/operationManual](https://archguard.org/operationManual)
- 输入要扫描的项目的仓库地址
- 点击"调用依赖工具"，进入工具
- 点击"扫描代码"按钮，待扫描结束后，进行分析

## PL/SQL依赖分析工具
源自：ThoughtWorks

状态：已集成ArchGuard

工具适用场景：

步骤：

- 先干啥
- 再干啥
- 最终干啥

## Tequlia工具
源自：李新（前ThoughtWorks咨询师）

GitHub：[https://github.com/newlee/tequila](https://github.com/newlee/tequila)

状态：未集成ArchGuard

工具适用场景：

- Cpp/Java依赖关系可视化

步骤：

- 安装golang，设置GOPATH，安装[graphviz](http://graphviz.org/)，安装[doxygen](http://www.stack.nl/~dimitri/doxygen/)
- 配置[Doxyfile](https://github.com/newlee/tequila/blob/master/examples/step2-code/Doxyfile),生成doxygen文件
```
doxygen examples/step2-code/Doxyfile
```
- 扫描
```
go build && ./tequila
```

# 改造工具
## PL/SQL 转 Kotlin工具
源自：ThoughtWorks

工具适用场景：

步骤：

- 先干啥
- 再干啥
- 最终干啥

# 测试工具
## A/B 测试套件工具
源自：ThoughtWorks

工具适用场景：

步骤：

- 先干啥
- 再干啥
- 最终干啥