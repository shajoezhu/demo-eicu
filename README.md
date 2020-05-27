# demo-eicu

```
cd postgres
make initialize
make eicu-gz datadir=${PWD}/../data/
```



```bash
docker build . -f docker/Dockerfile -t shajoezhu/demo-eicu
```

```bash
docker run -d \
--name demo-eicu-container \
-p 5434:5432 \
-e BUILD_EICU=1 \
-e EICU_PASSWORD=eicu \
-e POSTGRES_PASSWORD=postgres \
shajoezhu/demo-eicu
```
