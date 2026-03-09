---

---
## Dremio (data lake)

[https://medium.com/data-hackers/o-que-%C3%A9-e-como-funciona-o-dremio-4ff2c7a6d119](https://medium.com/data-hackers/o-que-%C3%A9-e-como-funciona-o-dremio-4ff2c7a6d119)

Site oficial

https://docs.dremio.com/

## Portainer

docker run -d -p 9000:9000 -v portainer_data:/data portainer/portainer-ce -H tcp://10.0.75.1:2375

docker run -d -p 9000:9000 -v portainer_data:/data portainer/portainer-ce -H tcp://[host.docker.in](http://host.docker.in/)ternal:2375

//NÃO FUNCIONA

docker run -d -p 9000:9000 --name portainer --restart always -v \\.\pipe\docker_engine:\\.\pipe\docker_engine -v C:\ProgramData\Portainer:C:\data portainer/portainer-ce

---

[https://www.andreagrandi.it/2015/02/21/how-to-create-a-docker-image-for-postgresql-and-persist-data/](https://www.andreagrandi.it/2015/02/21/how-to-create-a-docker-image-for-postgresql-and-persist-data/)

[https://www.andreagrandi.it/2015/02/21/how-to-create-a-docker-image-for-postgresql-and-persist-data/](https://www.andreagrandi.it/2015/02/21/how-to-create-a-docker-image-for-postgresql-and-persist-data/)

Iniciar um container a partir de um Dockerfile

docker build -t <<nome>> .

Executar um container

`docker run --rm -P --name pg_test eg_postgresql`

`docker run --rm -P --name pg postgres9-6-x]`

### Building Docker image

Once the Dockerfile is ready, we need to build the image before running it in a container. Please customize the tag name using your own docker.io hub account (or you won't be able to push it to the hub):

docker build --rm=true -t andreagrandi/postgresql:9.3 .

### Running the PostgreSQL Docker container

To run the container, once the image is built, you just need to use this command:

docker run -i -t -p 5432:5432 andreagrandi/postgresql:9.3

### Testing the running PostgreSQL

To test the running container we can use any client, even the commandline one:

psql -h localhost -p 5432 -U pguser -W pgdb

When you are prompted for password, type: **pguser**

Please note that **localhost** is only valid if you are running Docker on Ubuntu. If you are an OSX user, you need to discover the correct ip using: **boot2docker ip**

### Persisting data

You may have noticed that once you stop the container, if you previously wrote some data on the DB, that data is lost. This is because by default Docker containers are not persistent. We can resolve this problem using a data container. My only suggestion is not to do it manually and use a tool like [**fig**](http://www.fig.sh/) to orchestrate this. Fig is a tool to orchestrate containers and its features are being rewritten in Go language and integrated into Docker itself. So if you prepare a **fig.yml** configuration file now, you will be able, hopefully, to reuse it once this feature will be integrated into Docker. Please refer to fig website for the instructions to install it (briefly: under Ubuntu you can use **pip install fig** and under OSX you can use **brew install fig**).

dbdata:

image: andreagrandi/postgresql:9.3

volumes:

- /var/lib/postgresql

command: true

db:

image: andreagrandi/postgresql:9.3

volumes_from:

- dbdata

ports:

- "5432:5432"

Save this file as **fig.yml** in the same folder of the Dockerfile and spin up the container using this command: **fig up**

andreas-air:postgresql-docker andrea [master] $ fig up

Recreating postgresqldocker_dbdata_1...

Recreating postgresqldocker_db_1...

Attaching to postgresqldocker_db_1

db_1 | 2015-02-21 19:01:07 UTC [6-1] LOG:  database system was interrupted; last known up at 2015-02-21 17:46:10 UTC

db_1 | 2015-02-21 19:01:07 UTC [6-2] LOG:  database system was not properly shut down; automatic recovery in progress

db_1 | 2015-02-21 19:01:07 UTC [6-3] LOG:  redo starts at 0/1782F68

db_1 | 2015-02-21 19:01:07 UTC [6-4] LOG:  record with zero length at 0/1782FA8

db_1 | 2015-02-21 19:01:07 UTC [6-5] LOG:  redo done at 0/1782F68

db_1 | 2015-02-21 19:01:07 UTC [6-6] LOG:  last completed transaction was at log time 2015-02-21 17:46:10.61746+00

db_1 | 2015-02-21 19:01:07 UTC [1-1] LOG:  database system is ready to accept connections

db_1 | 2015-02-21 19:01:07 UTC [10-1] LOG:  autovacuum launcher started

If you try to write some data on the database and then you stop (CTRL+C) the running containers and spin up them again, you will see that your data is still there.

### Conclusion

This is just an example of how to prepare a Docker container for a specific service. The difficoult part is when you have to spin up multiple services (for example a Django web application using PostgreSQL, RabbitMQ, MongoDB etc...), connect them all together and orchestrate the solution. I will maybe talk about this in one of the next posts. You can find the full source code of my PostgreSQL Docker image, including the fig.yml file in this repository [https://github.com/andreagrandi/postgresql-docker](https://github.com/andreagrandi/postgresql-docker)