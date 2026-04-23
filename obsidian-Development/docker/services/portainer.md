# Portainer

## Service

```yaml
  portainer:
    container_name: portainer
    image: portainer/portainer-ce:2.38.1-alpine
    ports:
      - "9443:9443"
    volumes:
      - portainer-data:/data
      - /var/run/docker.sock:/var/run/docker.sock
    restart: on-failure
    networks:
      - [[NETWORK NAME]]


volumes:
  portainer-data:
    external: true
```