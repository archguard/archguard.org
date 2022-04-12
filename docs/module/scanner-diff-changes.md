---
layout: default
parent: Modules
title:  "变更影响分析"
permalink: /modules/scanner/diff-changes
nav_order: 5
---

## 版本 0.1 核心逻辑

变更分析影响的主要步骤为四步，当前版本完成了（1 ~ 3）：

1. 构建**基线版本**（基于 since）的 AST 调用模型
2. 获取提交（since ~ until）之间的所有变更文件，将这些文件更新到 AST 调用模型。
   1. 在 `compareWithBaseline` 中，对比新旧的 AST，获取变更的文件、函数等。
3. 生成函数、函数调用关系的映射，计算变化影响的调用。
4. （未实现）更新到最新的文件路径，以实现增量的计算 

分析步骤代码如下所示：

```kotlin
fun countBetween(sinceRev: String, untilRev: String): List<ChangedCall> {
    val repository = FileRepositoryBuilder().findGitDir(File(path)).build()
    val git = Git(repository).specifyBranch(branch)

    val since: ObjectId = git.repository.resolve(sinceRev)
    val until: ObjectId = git.repository.resolve(untilRev)

    // 1. create based ast model from since revision commit
    this.baseLineDataTree = createBaselineAstTree(repository, since)

    // 2. calculate changed files to utils file
    for (commit in git.log().addRange(since, until).call()) {
        getChangedFiles(repository, commit)
    }

    // 3. count changed items reverse-call function
    this.genFunctionMap()
    this.genFunctionCallMap()
    val changedCalls = this.calculateChange()

    // add path map to projects

    // 4. align to the latest file path (maybe), like: increment for path changes
    return changedCalls
}
```

核心的代码在 `compareWithBaseline` 方法中：

```kotlin
newDataStructs = diffFileFromBlob(repository, blobId, filePath, JavaAnalyserApp())

val oldDataStructs = this.differFileMap[filePath]!!.dataStructs

// 1. 如果一个文件内类数量不一致，则判定整个文件变了。
if (newDataStructs.size != oldDataStructs.size) {
    val difference = newDataStructs.filterNot { oldDataStructs.contains(it) }
    difference.forEach {
        this.changedFiles[filePath] = ChangedEntry(filePath, filePath, it.Package, it.NodeName)
    }
} else {
    newDataStructs.forEachIndexed { index, ds ->
        // in first version, if field changed, just make data structure change will be simple
        // 2. 如果一个类的成员变量数量不一样，同样判定整个类变了。
        if (ds.Fields.size != oldDataStructs[index].Fields.size) {
            this.changedClasses[filePath] = ChangedEntry(filePath, filePath, ds.Package, ds.NodeName)
        } else if (!ds.Fields.contentEquals(oldDataStructs[index].Fields)) {
            this.changedClasses[filePath] = ChangedEntry(filePath, filePath, ds.Package, ds.NodeName)
        }

        // 3. 如果函数的不相等，就对函数进行比对，寻找出变化的函数
        // compare for function sizes
        if (!ds.Functions.contentEquals(oldDataStructs[index].Functions)) {
            val difference = ds.Functions.filterNot { oldDataStructs[index].Functions.contains(it) }
            difference.forEach {
                this.changedFunctions[filePath] =
                    ChangedEntry(filePath, filePath, ds.Package, ds.NodeName, it.Name)
            }
        }
    }
}
```

