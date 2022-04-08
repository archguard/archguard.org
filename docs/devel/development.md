---
layout: default
title: Development
nav_order: 8
has_children: true
permalink: /development
---

requirements:

- JDK 12+
- InfluxDB 1.8.x

Others:

- languages：Kotlin
- frameworks：Spring Boot，JDBI
- test frameworks：Junit5，Spring Boot Test，Flyway，H2
- build tool：Gradle
- data storage：MySQL, InfluxDB

Components：

- [x] [ArchGuard backend](https://github.com/archguard/archguard-backend) - connect scanner and show data.
- [x] [ArchGuard scanner](https://github.com/archguard/scanner/)  - scan source code, binary date and othes, and feed to database.
- [x] [ArchGuard frontend](https://github.com/archguard/archguard-frontend) - visualization results & dashboard
- [x] [Chapi](https://github.com/modernizing/chapi) - Chapi is A common language meta information convertor, convert different languages to same meta-data model.

## Setup

### Database setup

1. Local mysql, or docker created
- `docker pull mysql:8`
- `docker run --name=mysql -it -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql`
2. Create archguard database
- `create database archguard default character set utf8mb4 collate utf8mb4_unicode_ci;`
- `./gradlew -Dflyway.configFiles=flyway.conf flywayMigrate` (probably not needed)

### Backend setup

clone:

```bash
git clone https://github.com/archguard/archguard
```

run

```
./gradlew bootrun
```

Spring default port：8080

### Frontend setup

**important!**: start backend before frontend.

```bash
git clone https://github.com/archguard/archguard-frontend
```

run 

```bash
cd archguard
yarn install
yarn start
```

After start, visit：[http://localhost:8081/](http://localhost:8081/)

## 独立启动其它组件（可选，用于替换本地环境）

InfluxDB

```
docker run -d -p 8186:8086 --name influxdb \
      -v ~/ArchGuard/data/influxdb:/var/lib/influxdb \
      -e INFLUXDB_INIT_USERNAME=admin \
      -e INFLUXDB_INIT_PASSWORD=admin \
      -e INFLUXDB_DB=db0 \
      influxdb:1.8
```

MySQL

```
docker run -d -p 13308:3306 --name archguard-mysql \
      -v ~/ArchGuard/data/mysql:/var/lib/mysql:rw \
      -e MYSQL_ROOT_PASSWORD=prisma \
      -e MYSQL_DATABASE=archguard \
      -e TZ=Asia/Shanghai \
      mysql --default-authentication-plugin=mysql_native_password
```
