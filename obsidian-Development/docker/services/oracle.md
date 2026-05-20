# Oracle docker service

## Service

```yaml
  oracle-26ai:
    container_name: oracle-26ai
    image: container-registry.oracle.com/database/free:latest
    restart: unless-stopped
    shm_size: "8gb"
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_PWD: ${ORACLE_PWD}
      ORACLE_CHARACTERSET: AL32UTF8
      DISABLE_OOB: "ON"
    volumes:
      - oracle-26ai-data:/opt/oracle/oradata
	networks:
      - [[NETWORK NAME]]


volumes:
  oracle-26ai-data: # Important, oracle does not work well with NTFS volumes, that's the reason to use internal volume
    external: true

```

## Configurations

### .env file

```env
# sys admin password, must have 8 characters, 1 uppercase, 1 lowercase and 1 number.
ORACLE_PWD=
```
