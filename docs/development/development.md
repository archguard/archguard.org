---
layout: default
title: Development
nav_order: 8
has_children: true
permalink: /development
---

requirements:

- JDK 12+
- docker engine
- docker compose V1

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

### Backend setup

clone:

```bash
git clone https://github.com/archguard/archguard
```

run

```bash
./gradlew bootrun
```

- Spring default port：8080
- MySQL default port: 3306
- InfluxBD default port: 8086

如果需要修改端口，请同步更新docker compose配置`config/infrastructure/docker-compose.local.yml` 和 后端配置`application-local.properties`

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

## 其他

### Mac(M1)中如何运行

1. 下载ArchGuard相关文件
   git仓库：<https://github.com/archguard/archguard>

   下载方式(两种方式均可)：

   1. git clone <https://github.com/archguard/archguard.git>
   2. <https://github.com/archguard/archguard/archive/refs/heads/master.zip>

2. 本地启动后端（ArchGuard backend）

   进入上面下载文件中的主目录

   ```
   ./gradlew bootrun
   ```

   启动成功标识：

  <img width="1439" alt="image-20220410121806261" src="https://user-images.githubusercontent.com/41335230/162601532-e99a965d-9cc0-4975-965f-1f10173e52ff.png">

3. 修改docker-compose文件

   ```
   version: '3.8'
   services:
     archguard-frontend:
       image: "archguard/archguard-frontend:latest"
       container_name: archguard-frontend
       depends_on:
         - archguard-backend
       ports:
         - "11080:80"
       networks:
         - dependence_network
   
     archguard-backend:
       image: "archguard/archguard-backend:latest"
       container_name: archguard-backend
       environment:
         app_env: debug
       volumes:
         - "~/.m2:/root/.m2"
         - "~/.gradle:/root/.gradle"
       healthcheck:
         test: curl -f http://localhost:8080/api/actuator/health || exit 1
         timeout: 10s
         retries: 5
       networks:
         - dependence_network
       restart: on-failure:10
   
     archguard_influxdb:
       image: "influxdb:1.8"
       container_name: archguard_influxdb
       ports:
         - '8086:8086'
       networks:
         - dependence_network
       healthcheck:
         test: curl -f http://localhost:8086/ping || exit 1
         timeout: 10s
         retries: 5
       volumes:
         - ./archguard_influxdb:/var/lib/influxdb
       environment:
         - INFLUXDB_DB=db0
         - INFLUXDB_ADMIN_USER=admin
         - INFLUXDB_ADMIN_PASSWORD=admin
   
   networks:
     dependence_network:
   
   ```

4. 启动docker-compose

   ```
   docker-compose up
   ```

5. 进入archguard-frontend运行容器中，修改nginx的配置

   - 进入容器，其中<CONTAINER ID>，为archguard-frontend运行时的容器ID，可通过docker ps查看到

   ```
   docker exec -it <CONTAINER ID>
   ```

   - 修改nginx配置

   ```shell
   vi /etc/nginx/conf.d/default.conf
   ```

   这里的ip调整为宿主机的ip

<img width="585" alt="image-20220410122533914" src="https://user-images.githubusercontent.com/41335230/162601549-830cc155-a7bb-4a8a-b048-97775f0af0db.png">

- 重新nginx配置

     ```
     /usr/sbin/nginx -s reload
     ```

6. 最后即可在浏览器中正常访问

   ```
   http://127.0.0.1:11080/home
   ```

![image](https://user-images.githubusercontent.com/41335230/162601557-b7f678f9-6032-4f41-8a90-d656d3d66f2e.png)
