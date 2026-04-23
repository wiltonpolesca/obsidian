# Postgres

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
      - -c
      - wal_level=logical
      - -c
      - shared_preload_libraries=timescaledb,wal2json # Requires Dockerfile
```

## Configurations

### .env file

```env
POSTGRES_USER=
POSTGRES_PWD=
POSTGRES_DB=
```

### postgres initdb

```sh
# init.sh file

#!/bin/bash

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE [[DATABASE-NAME]];
EOSQL

```

### Dockefile

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
