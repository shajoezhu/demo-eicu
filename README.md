# demo-eicu

This repo is a git-sparse-checkout from https://github.com/MIT-LCP/eicu-code

## Repo文件结构 (Repo structure)

```
  /   # Root
  |-- data     # eicu-demo data
  |-- postgres # scripts for SQL database
  |-- docker   # Dockerfile etc
```

## SQL数据库构建 (Build the database with postgres)

### 构建数据库 (Build)

```
cd postgres
make initialize
make eicu-gz datadir=${PWD}/../data/
```

## 用docker构建数据库 (Build the database with docker)

### 构建数据库


```bash
docker build . -f docker/Dockerfile -t shajoezhu/demo-eicu
```

或者直接从docker库下载 (Or you can pull it from docker repository via)

```bash
docker pull shajoezhu/demo-eicu
```


### Docker部署 (Deployment)

首次运行,需要组建数据库 (For the first time, we need to build the database)

```bash
docker run -d \
--name demo-eicu-container \
-p 5434:5432 \
-e BUILD_EICU=1 \
-e EICU_PASSWORD=eicu \
-e POSTGRES_PASSWORD=postgres \
shajoezhu/demo-eicu
```

#### 停止Docker部署 (Stop deployment)

```bash
docker stop demo-eicu-container
```

#### 重启Docker部署 (Restart deployment)

```bash
docker start demo-eicu-container
```
