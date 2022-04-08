---
layout: default
parent: Modules
title:  "SourceCode Scanner API"
permalink: /modules/scanner/sourcecode-api
---

## API 分析

规范化是建立这个 API 分析的基础。

在 ArchGuard 中是根据消费者-生产者这一基本的模式，来对 API 进行建模的。生产者在代码者以 resource 命名，消费者则是 Demand。对于一个前端应用来说，它是一个 demand，包含了一系列 API 调用。对于一个后端应用来说，它可能即是 resource，又或者是 demand，即它即会提供 API，又要消费 API。

API 分析主要是在 Scanner（<https://github.com/archguard/scanner>）的 `scan_sourcecode` 模块中，主要代码文件：

* CSharpApiAnalyser
* JavaApiAnalyser。支持 Java/Kotlin
* FrontendApiAnalyser。支持 TypeScript/JavaScript

从名称中就能知道它们的用途了。

##  Resource：从一个 Spring 的 Controller 说起

对于一个 Java/Kotlin 的 Web 应用来说，它的 HTTP 声明如下：

```java
@RestController
@RequestMapping("/api/systems/{systemId}/methods")
class MethodController(val methodService: MethodService) {

    @GetMapping("/callees")
    fun getMethodCallees(@PathVariable("systemId") systemId: Long,
                         @RequestParam("name") methodName: String,
                         @RequestParam(value = "clazz") clazzName: String,
                         @RequestParam(value = "deep", required = false, defaultValue = "3") deep: Int,
                         @RequestParam(value = "needIncludeImpl", required = false, defaultValue = "true") needIncludeImpl: Boolean,
                         @RequestParam(value = "module") moduleName: String): ResponseEntity<List<JMethod>> {
        val jMethod = methodService.findMethodCallees(systemId, moduleName, clazzName, methodName, deep, needIncludeImpl)
        return ResponseEntity.ok(jMethod)
    }
}
```

Spring 采用的是注解的方式来声明 API 的，所以只需要分析注解，我们就能分析出他们的 API。只需要将 `RequestMapping` 和 `GetMapping` 的值拼到一起，就是一个 resource。

从使用上来说，Resource  的分析并没有什么难度，随便找个工具都是能使用的。

## Demand：多种多样的消费端

### Demand：消费一个 API

API 的消费就是一个比较复杂的工程，需要更规范的 API 模式。如下是一个使用 REST Template 调用 GET 请求的示例：

```javascript
@Component
class QualityGateClientImpl(@Value("\${client.host}") val baseUrl: String) : QualityGateClient {
    override fun getQualityGate(qualityGateName: String): CouplingQualityGate {
        val couplingQualityGate = RestTemplate().getForObject("$baseUrl/api/quality-gate-profile/$qualityGateName", CouplingQualityGate::class.java)
        return couplingQualityGate ?: CouplingQualityGate(null, qualityGateName, emptyList(), null, null)
    }
}
```

对于分析来说，代码里的模式也比较简单，在 AST 在查看匹配 `RestTemplate().getForObject`的情况，即调用的类是 RestTemplate，方法是 get（getForObject ）开头则说明是一个 Get 请求：

```javascript
if (call.NodeName == "RestTemplate" && call.FunctionName != "<init>") {
    var method = ""
    val lowercase = functionName.lowercase()
    when {
        lowercase.startsWith("get") -> {
            method = "Get"
        }
        lowercase.startsWith("post") -> {
            method = "Post"
        }
        lowercase.startsWith("delete") -> {
            method = "Delete"
        }
        lowercase.startsWith("put") -> {
            method = "Put"
        }
    }
   ...
}
```

唯一麻烦的地方是 `"$baseUrl/api/quality-gate-profile/$qualityGateName"` 的形式，对于这样的形式，我们只需要做一些特殊的规则处理就行了。但是，如果不是类似于这样的方式，那么我们就需要修改代码中的逻辑了。

### Demand：消费一个 API（Axios）

对于前端来说，这种方式也是类似的：

```javascript
export function querySystemInfo() {
  return axios<SystemInfo[]>({
    url: "/api/system-info",
    method: "GET",
  });
}
```

同样的，也是解析 URL，还有对应的 method，进而生成一个消费端的内容

## 拉线：匹配消费者-生产者

对于匹配 URL 来说，充满了各种不确定性，或者说是不准确性。每个 URL 都是千差万别的，需要通过一些规则来进行特殊处理，即将参数转换为 `@uri@` 的形式，方便我们进行匹配。

诸如于：`$baseUrl/api/quality-gate-profile/$qualityGateName` -> `@uri@/api/quality-gate-profile/@uri@`

如此一来，才能将生产者与消费者进行匹配。


