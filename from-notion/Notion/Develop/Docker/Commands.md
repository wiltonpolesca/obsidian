---

---
host.docker.internal

## Portainer

docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer-ce

| Command | Description |
| --- | --- |
| docker stop $(docker ps -a -q) | Stop   all instances |
| docker rm $(docker ps -a -q) | Remove   all instances |
| docker image rm $(docker image ls -a -q) | remove   all images |
| docker volume prune | Clean volumes |
| docker builder prune | Clean bulder cache |
| docker network rm $(docker network ls -a) |   |
| docker system df | Exibe o uso de disco das imagens docker[Docker Tips: Clean Up Your Local Machine | by Luc Juggery | Better Programming](https://betterprogramming.pub/docker-tips-clean-up-your-local-machine-35f370a01a78) |
| docker login [registry.gitlab.com](http://registry.gitlab.com/) -u wpolesca@newtrax.com -p glpat-rRaqgFZUFPzkmQPbPjLy | Login newtrax registry |
| docker-credential-desktop list | Ver os logins ativos |
| docker cp <arquivo a copiar>  [container]:[pasta de destino] | Copiar arquivo para docker |
| docker build -t <image-name> . | Compilar um Dockerfile |
| docker build --network host -t <<image name> . | --network host evit erro ao tentar fazer download do alpine (muito estranho isso) |
| docker tag <image-name> <dockerhub-user/image-name> | Criar uma tag na imagem (importante fazer isso antes de enviar para o docker hub) |
| docker push <dockerhub-user/image-name> | Enviar uma imagem para o dockerhub |
| docker run -e PORT=8080 -p 2345:8080 <image-name> | Executar uma imagem já criada (disponibilizando o recurso na porta 2345 do host)PORT=8080 -> Define o valor 8080 para a variável de ambiente PORT esperada pela imagem |