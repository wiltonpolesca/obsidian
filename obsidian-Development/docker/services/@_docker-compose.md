# Docker compose

Docker compose helps to quickly create a local or production environment and starts to use it.

Each environment requires different kind of services (databases, brokers, ... others), the idea here is to document the services and have an example about how to have it working.

## docker-compose template

```yaml
version: "3.9"

networks:
  net_name: # name of the newtork
    extrenal: true # saves the storage into the docker/portainer main image instead of into the image, the data won't be deleted if the image is deleted

volumes:
  volume_name: # name of the volume

services:
  # add your services here...

configs:
  # add your config, if needed, here ...

```

You can compose your file using, as example, the following configurations:

- [[portainer|Portainer]]
- [[postgres|Postgres]]
- [[sql-server|MS SQL Server]]
- [[oracle|Oracle]]
- [[open-telemetry|Grafana]]