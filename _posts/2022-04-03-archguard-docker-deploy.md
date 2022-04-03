---
layout: single
title:  "ArchGuard Docker 部署"
categories:
- Blog
- ArchGuard
---

ArchGuard 在 Docker Compose 配置放置在 [https://github.com/archguard/archguard](https://github.com/archguard/archguard) 项目中：

主要由以下四个服务组成：

```
services:
  archguard-frontend:
  archguard-backend:
  archguard_mysql:
  archguard_influxdb:
```

Clone 完 [https://github.com/archguard/archguard](https://github.com/archguard/archguard) 之后，需要执行：

```
docker-compose up
```

发生版本变更时，需要先手动执行：

```
docker-compose pull
```

再执行 `docker-compose up`

### 使用 ArchGuard 项目作为示例：

新建 Backend：https://github.com/archguard/archguard

新建 Frontend：https://github.com/archguard/archguard

需要在系统配置中添加**源码路径**：archguard
g
### 已知问题

已知问题，Scanner 在扫描时，会花费比较多的内存，使用 Docker Desktop/Colima 默认的配置时，可能会造成 OOM，需要配置更大的内存。

以 Coliama 作为示例：

```
colima start --cpu 4 --memory 8
```

