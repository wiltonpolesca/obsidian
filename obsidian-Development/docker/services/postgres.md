# Postgres docker service

## Service

```yaml
  postgres:
    container_name: postgres
    image: postgres:18.3-alpine3.23
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PWD} # POSTGRES_PWD on old versions
      POSTGRES_DB: ${POSTGRES_DB}
    ports:
      - "5432:5432"
    volumes:
      - postgresql-pgdata:/home/postgres/pgdata
      - postgresql-backup:/backup
      - ./settings/postgres/init.sh:/docker-entrypoint-initdb.d/init.sh
    restart: always
    networks:
      - [[NETWORK NAME]]


volumes:
  postgresql-pgdata:
    external: true
  postgresql-backup:
    external: true

```

### Commands (optional)

```yaml
    command:
      - postgres

      # MEMORY
      - -c
      - shared_buffers=8GB
      - -c
      - work_mem=32MB
      - -c
      - maintenance_work_mem=2GB
      - -c
      - effective_cache_size=24GB

      # CONNECTIONS
      - -c
      - max_connections=100

      # WAL / CHECKPOINTS
      - -c
      - wal_buffers=16MB
      - -c
      - checkpoint_completion_target=0.9
      - -c
      - max_wal_size=8GB
      - -c
      - min_wal_size=2GB
        
      # PLANNER
      - -c
      - default_statistics_target=200

      # PARALLELISM
      - -c
      - max_worker_processes=8
      - -c
      - max_parallel_workers=8
      - -c
      - max_parallel_workers_per_gather=4


      # AUTOVACUUM
      - -c
      - autovacuum=on
      - -c
      - autovacuum_max_workers=5
      - -c
      - autovacuum_naptime=10s
      - -c
      - autovacuum_vacuum_scale_factor=0.05
      - -c
      - autovacuum_analyze_scale_factor=0.02
      - -c
      - autovacuum_vacuum_cost_limit=2000

      # IO (SSD / NVMe)
      - -c
      - random_page_cost=1.1
      - -c
      - effective_io_concurrency=200

      # LOGGING
      - -c
      - log_min_duration_statement=500ms
      - -c
      - log_checkpoints=on
      - -c
      - log_autovacuum_min_duration=1s

      # NETWORK
      - -c
      - listen_addresses=*        
```

## Configurations

### .env file

```env
POSTGRES_USER=
POSTGRES_PWD=
POSTGRES_DB=
```

### Postgres initdb

Allows you create users, databases you need when the image is being created.

```sh
# init.sh file

#!/bin/bash

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE [[DATABASE-NAME]];
EOSQL

```

### Dockefile

Example of how a Dokerfile file can be used to create the image, in this example, the Postgres image is being created with wal2json installed.

```yaml
# docker-compose build
    build:
      context: .
      dockerfile: ./settings/postgres/Dockerfile
```

```yaml
FROM timescale/timescaledb-ha:pg16.4-ts2.17.0
USER root
RUN apt update
RUN apt install -y postgresql-15-wal2json

USER postgres
```

## Commands to check the current configuration

```sql
SELECT name, setting, unit, source
FROM pg_settings
WHERE source <> 'default'
ORDER BY name;
```

```sql
SHOW shared_buffers;
SHOW work_mem;
SHOW maintenance_work_mem;
SHOW effective_cache_size;
SHOW max_connections;
SHOW wal_buffers;
SHOW max_wal_size;
SHOW min_wal_size;
SHOW random_page_cost;
SHOW listen_addresses;
```

```sql
SHOW config_file;
SHOW hba_file;
```