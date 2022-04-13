---
layout: default
parent: Modules
title:  "源码分析：数据库依赖"
permalink: /modules/scanner/sourcecode-database
nav_order: 4
---


主要处理逻辑：

1. 从代码中解析出 SQL 代码
2. 对 SQL 代码进行处理
3. 通过 jsqlparser 得到数据库表
4. 构建映射关系

## parse SQL 

### MyBatis(XML)

常见的处理方式是，直接解析 XML，如下的两个代码库：

- Golang: [https://github.com/actiontech/mybatis-mapper-2-sql](https://github.com/actiontech/mybatis-mapper-2-sql)
- Python: [https://github.com/hhyo/mybatis-mapper2sql](https://github.com/hhyo/mybatis-mapper2sql)

在 ArchGuard 中采用的是另外一种方式，采用的是 mock 的方式，，即如何正确处理 `#{item.orderId}`。解析 MyBatis 的流程中，最麻烦的部分是：生成相对 "正确" 的 mock 参数。

不过，在不包含 Runtime 类的情况下，MyBatis XML 的 SQL 代码生成比较复杂。MyBatis XML 由两部分组成，即 MyBatis 的 XML，如（<insert>）等，另外一个部分是基于 Ognl 的参数部分，即：`#{item.orderId}`。

对应的处理流程：

1. 准备 CRUD `（select|insert|update|delete）` 所需要的环境。
    - 处理 `<sql>` 语句，构建映射
2. 获取 CRUD `（"select|insert|update|delete"）` 相关的节点，并进行处理。
    - 使用 MyBatis 的 `XMLIncludeTransformer` 来处理 `<include>` 语句
    - 处理 `<selectKey>` 语句，然后将这些语句从节点中删除。
    - 调用 `parseDynamicTags` 来解析动态的 tag，生成 rootNode。
    - 转换为对应的 SQL 语句。

对应的参数处理流程：

1. 针对于 `foreach` 语句，获取 `collection` 和 `item` 属性，并添加到参数列表中。
2. 针对于 `if` 语句，通过 `Ognl.parseExpression` 去解析 `test` 属性，并简单处理表达式，以构建出应对的参数。

解析 If 语句的代码如下所示：

```kotlin
val condition = child.getStringAttribute("test")
val parseExpression = Ognl.parseExpression(condition)
val items = mutableListOf(Any())

when (parseExpression.javaClass.simpleName) {
    "ASTEq", "ASTGreater", "ASTGreaterEq", "ASTLess", "ASTLessEq", "ASTNotEq" -> {
        val ast = parseExpression as ComparisonExpression
        for (i in 0 until ast.jjtGetNumChildren()) {
            val jjtGetChild = ast.jjtGetChild(i).toString()
            if (jjtGetChild != "null") {
                if (jjtGetChild.contains(".")) {
                    // todo: check need to support for multiple parents if exists
                    val split = jjtGetChild.split(".")
                    val parent = split[0]
                    params[parent] = mutableListOf(mutableMapOf<String, Any>())
                }

                params[jjtGetChild] = items
            }
        }
    }
}
```


### JDBI JPA

代码见：[MysqlAnalyser.kt](https://github.com/archguard/scanner/blob/master/scan_sourcecode/src/main/kotlin/org/archguard/scanner/sourcecode/database/MysqlAnalyser.kt)

#### JDBI 注解方式

JDBI 示例代码：

```kotlin
import org.jdbi.v3.sqlobject.statement.SqlQuery

interface GitChangeDao {
@SqlQuery("select * from scm_git_hot_file where system_id = :systemId")
fun findBySystemId(systemId: Long) : List<GitHotFile>

    @SqlQuery("select system_id as systemId, line_count as lineCount, path, changes" +
            " from scm_path_change_count where system_id = :systemId")
    fun findCountBySystemId(systemId: Long) : List<GitPathChangeCount>
}
```

JDBI 使用的是 JDBI，所以只需要从 Annotation 中过滤出这些注解即可，示例如下：

```kotlin
function.Annotations.forEach {
    // jpa use `@Query`, jdbi use `SqlQuery`
    if ((it.Name == "Query" || it.Name == "SqlQuery")&& it.KeyValues.isNotEmpty()) {
    }
}
```

#### JDBI 代码方式

JDBI，可以直接在代码中创建 Query，如下所示：

```kotlin
override fun getMethodById(methodId: String): JMethodVO {
    val sql = "select module as moduleName, clzname as className, name from code_method where id = '$methodId'"

    return jdbi.withHandle<JMethodVO, Nothing> {
        it.registerRowMapper(ConstructorMapper.factory(JMethodVO::class.java))
        it.createQuery(sql)
                .mapTo(JMethodVO::class.java)
                .first()
    }
}
```

所以，需要从函数中过滤，查找方法是 `createQuery` 的方法 ：

```kotlin
function.FunctionCalls.forEach {
        val callMethodName = it.FunctionName.split(".").last()
        if (callMethodName == "createQuery" && it.Parameters.isNotEmpty()) {
            val originSql = it.Parameters[0].TypeValue
            val pureValue = sqlify(originSql)
            if (MysqlIdentApp.analysis(pureValue) != null) {
                tables += MysqlIdentApp.analysis(pureValue)!!.tableNames
            } else {
                logger.warn("error for ${node.NodeName}.${function.Name} origin:$originSql\nnew:$pureValue")
            }

            sqls += pureValue
        }
    }
    ...
}
```

#### Spring DATA JPA

对于使用注解的 JPA 代码来说，也相当的简单：

```
@Query(value = "select * from person  where name = ?1",nativeQuery = true)
Person findPersonByName(String Name);
```

## 处理包含代码的 SQL

过滤出来的的 SQL 包含一系列的相关语义，所以要构建一定的 Context，去掉一些无关的因素。如下是过滤和替换代码：

```kotlin
fun sqlify(value: String): String {
    var text = handleRawString(value)
    text = removeBeginEndQuotes(text)

    // handle for variable
    text = removeVariableInLine(text)
    text = removeKotlinVariable(text)
    text = removeJdbiValueBind(text)
    text = removeEndWithMultipleSingleQuote(text)

    text = removeNextLine(text)
    // " " + module
    text = removePlusWithVariable(text)
    // " " + " "
    text = removePlusSymbol(text)
    text = processIn(text)

    // sql fixed
    text = fillLimitEmpty(text)
    text = fillOffsetEmpty(text)
    return text
}
```

一些替换示例：


```kotlin
@Test
fun should_wrapper_in_list_in_values() {
    val sqlify =
        MysqlAnalyser().sqlify("select id, system_name as systemName, language from system_info where id in (<ids>)")

    assertEquals("select id, system_name as systemName, language from system_info where id in (:ids)", sqlify)
}

@Test
fun should_wrapper_raw_string_in_values() {
    val sqlify =
        MysqlAnalyser().sqlify("\"\"\"\n" +
                "                select count(m.id) from method_access m inner join code_method c where m.method_id = c.id  \n" +
                "                and m.system_id = :systemId and m.is_static=1 and m.is_private=0 \n" +
                "                and c.name not in ('<clinit>', 'main') and c.name not like '%\$%'\n" +
                "            \"\"\".trimIndent()")

    assertEquals(false, sqlify.contains("trimIndent"))
    assertEquals(false, sqlify.contains("\"\"\""))
}

@Test
fun should_handle_variable_in_sql() {
    val sqlify = MysqlAnalyser().sqlify("select id, module_name from \"\\\"+orderSqlPiece+\"\\\"")
    assertEquals("select id, module_name from *", sqlify)
}
```

## 调用 jsqlparser

最后，再调用 JSQLParser 来分析 SQL 中包含了哪些表。 

相关代码库：

- Golang: [https://github.com/actiontech/mybatis-mapper-2-sql](https://github.com/actiontech/mybatis-mapper-2-sql)
- Python: [https://github.com/hhyo/mybatis-mapper2sql](https://github.com/hhyo/mybatis-mapper2sql)

相关资源文档：

[AST实现代码审计工具之SQL注入](https://xz.aliyun.com/t/10312)


