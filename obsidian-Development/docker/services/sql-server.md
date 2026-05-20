# MS Sql Server docker service

## Service

```yaml
  sqlserver:
    container_name: sqlserver
    image: mcr.microsoft.com/mssql/server:2022-latest
    user: root
    restart: on-failure
    ports:
      - "1433:1433"
    environment:
      ACCEPT_EULA: "Y"
      MSSQL_SA_PASSWORD: ${SQLSERVER_SA_PWD}
    volumes:
      - sqlserver-data:/var/opt/mssql
    networks:
      - [[NETWORK NAME]]


volumes:
  sqlserver-data: # Important, oracle does not work well with NTFS volumes, that's the reason to use internal volume
    external: true

```
## Configurations

### .env file

```env
SQLSERVER_SA_PWD=
```
