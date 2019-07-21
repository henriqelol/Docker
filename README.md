# Docker
Aprendendo Docker

Máquina utilizada `uname -a`: Linux Ubuntu 16.04 X86_64

#### Atualizando o sistema
~~~sudo su
apt -y update
apt list --upgradable
apt list upgrade
~~~

### Instalando o Docker
~~~
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt -y update
apt-cache policy docker-engine
apt install -y docker-engine
~~~

Verificando se está inicializado
~~~
/etc/init.d/docker status
~~~

Caso não esteja
~~~
/etc/init.d/docker start
/etc/init.d/docker status
~~~

#### Executando o Comando Docker sem Sudo
`sudo usermod -aG docker $(whoami)`

Verificando informações da versão do **Docker**
`docker info`

#### Trabalhando com Imagens do Docker
~~~
docker run hello-world
docker search ubuntu
docker pull ubuntu
docker run ubuntu
docker run --ti --name teste debian
docker images
~~~

#### Executando um Contêiner Docker
`docker run -it ubuntu`

**Dentro do Container**
`apt-get update`

### Comandos **Docker**
Segue a lista de comandos docker e sua utilidade:

`CTRL + P + Q`  – Sai do container sem finalizar ele.
`docker attach` – Acessar dentro do container e trabalhar a partir dele.
`docker build`  – A partir de instruções de um arquivo Dockerfile eu possa criar uma imagem.
`docker commit` – Cria uma imagem a partir de um container.
`docker cp`     – Copia arquivos ou diretórios do container para o host.
`docker create` – Cria um novo container.
`docker diff`   – Exibe as alterações feitas no filesystem do container.
`docker events` – Exibe os eventos do container em tempo real.
`docker exec`   – Executa uma instrução dentro do container que está rodando sem precisar atachar nele.
`docker export` – Exporta um container para um arquivo .tar.
`docker history`– Exibe o histórico de comandos que foram executados dentro do container.
`docker images` – Lista as imagens disponíveis no host.
`docker import` – Importa uma imagem .tar para o host.
`docker info`   – Exibe as informações sobre o host.
`docker inspect`– Exibe r o json com todas as configurações do container.
`docker kill`   – Da Poweroff no container.
`docker load`   – Carrega a imagem de um arquivo .tar.
`docker login`  – Registra ou faz o login em um servidor de registry.
`docker logout` – Faz o logout de um servidor de registry.
`docker logs`   – Exibe os logs de um container.
`docker port`   – Abre uma porta do host e do container.
`docker network`– Gerenciamento das redes do Docker.
`docker node`   – Gerenciamento dos nodes do Docker Swarm.
`docker pause`  – Pausa o container.
`docker port`   – Lista as portas mapeadas de um container.
`docker ps`     – Lista todos os containers.
`docker pull`   – Faz o pull de uma imagem a partir de um servidor de registry.
`docker push`   – Faz o push de uma imagem a partir de um servidor de registry.
`docker rename` – Renomeia um container existente.
`docker restart`– Restarta um container que está rodando ou parado.
`docker rm`     – Remove um ou mais containeres.
`docker rmi`    – Remove uma ou mais imagens.
`docker run`    – Executa um comando em um novo container.
`docker save`   – Salva a imagem em um arquivo .tar.
`docker search` – Procura por uma imagem no Docker Hub.
`docker service`– Gernciamento dos serviços do Docker.
`docker start`  – Inicia um container que esteja parado.
`docker stats`  – Exibe informações de uso de CPU, memória e rede.
`docker stop`   – Para um container que esteja rodando.
`docker swarm`  – Clusterização das aplicações em uma orquestração de várias containers, aplicações junto.
`docker tag`    – Coloca tag em uma imagem para o repositorio.
`docker top`    – Exibe os processos rodando em um container.
`docker unpause`– Inicia um container que está em pause.
`docker update` – Atualiza a configuração de um ou mais containers.
`docker version`– Exibe as versões de API, Client e Server do host.
`docker volume` – Gerenciamento dos volumes no Docker.
`docker wait`   – Aguarda o retorno da execução de um container para iniciar esse container.
`docker ps -a`  – Mostra todos os containers.
`docker ps -q`  – Mostra todos os ids dos containers em execução.
`docker ps -aq` – Mostra todos os ids dos containers. 
`docker stop $(docker ps -a -q)`– Para todas os containers rodando. 
`docker rm $(docker ps -a -q)`– Remove todas as instâncias.
`docker image rm $(docker image ls -a -q)`– Para todas as imagens.

### Exportando Imagens Docker
<!-- Comentarios -->

`docker commit -m "What did you do to the image" -a "Author Name" id-do-contêiner repositório/nome_da_nova_imagem`

Verificando Imagens e Containers:
~~~
docker images
docker ps
~~~
Verificando apenas containers ativos e os ultimos containers utilizados:
~~~
docker ps -a #active
docker ps -l #last
~~~

### Docker Hub
O repositorio para do Docker é o **Docker Hub**, o processo de Export Image é semelhante ao do GitHub:
Docker login:
`docker login` ou `docker login --username=UsernameHub --email=youremail@company.com`

<!--
docker run --rm -p 8787:8787 rocker/verse
docker pull rocker/verse
-->
Subindo uma imagem para o Docker Hub:
~~~
docker images
docker tag Image_ID UsernameHub/nome-da-imagem-docker:TagHub
docker push UsernameHub/nome-da-imagem-docker
~~~
Salvar imagem do Docker após ter sido puxada, confirmada ou construída:
`docker save nome-da-imagem-docker > nome-da-imagem-docker.tar`

Carregar contêiner do Docker a partir do arquivo tar arquivado:
`docker load --input nome-da-imagem-docker.tar`

Remover todos containers
`docker rm $(docker ps -qa)`

#
docker stats
docker top

#Limitando Mem e CPU
#free -m = memmoria do rost
docker run -ti --memoryy 512m --name NOME debian
docker run -ti --cpu-shares 1024 --name container1 debian

docker inspect ID | grep -i mem
docker inspection container1

docker update 
docker update --cpu-shares 502 container1
docker update -m 256m ID or name

#volume e container data-only
docker run -ti -v /volume ubuntu /bin/bash
df -h
cd volume/
docker inspect -f {{.Mounts}} ubuntu


docker run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql

docker run -d -p 5433:5432 --name pgsql2 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql

-p porta do host
--volumes-from importar volume de outro container
-e variavel de ambiente

#Dockerfile1
FROM debian
RUN /bin/echo "Teste gooo"

#Dockerfile2
FROM debian
MAINTAINER Eduardo Henrique henriqelol@gmail.com

RUN apt-get -y update && apt-get -y install apache2 && apt-get clean
ADD opa.txt /diretorio/
CMD ["sh","-c", "echo", "$HOME"]
LABEL Description="bla bla bla bla bla"
COPY opa.txt /diretorio/
ENTRYPOINT ["/usr/bin/apache2ctl", "-D", "FOREGROUND"]
ENV meunome="Eduardo Henrique"
EXPOSE 80
USER henrique
WORKDIR /dir_trabalho

#docker build -t nome:versao .
docker build -t primeira_imagem:0.1 .

#Dockerfile
FROM debian

RUN apt-get update && apt-get -y install apache2 && apt -y install net-tools && apt -y install wget && apt-get clean
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"

CMD /etc/init.d/apache2 start && /bin/bash

LABEL Description="Webserver"

VOLUME /var/www/html

EXPOSE 80
#-----
docker run -ti --name testwebserver webserver:3.0

#Imagens
docker images
#name_image in docker hub
docker tag ID_IMAGE USER/name_image:version
docker push USER/name_image:version
docker search USER
docker pull USER/name_image:version

#Docker registry (docker hub local)
-d demon 
-p linkar porta host com container
--restart

docker run -d -p 5000:5000 --restart=always --name registry registry:2.0
#tag para localhost
docker tag 7bd4cbca1518 localhost:5000/webserver:3.0
docker push localhost:5000/webserver:3.0
#verificando
curl localhost:5000/webserver:3.0
curl localhost:5000/v2/_catalog


#Configuração de rede dos containers
docker run -ti --dns 8.8.8.8 debian 
docker run -ti --hostname henrique debian
docker run -ti --name container1 debian
docker run -ti --name containerX debian
docker inspect henriqelol/webserver:3.0

docker run -ti --name tapoha henriqelol/webserver:3.0 
docker ps | grep -i tapo
docker run -ti --link tapoha --name tapoha2 henriqelol/webserver:3.0 
docker run -ti --expose 80 debian
docker run -ti --publish 8080:80 debian
docker run -ti -p 8080:80 --name webserver debian

docker attach webserver
ifconfig
sudo iptables -L -n
sudo iptables -L -n | grep 80
sudo iptables -t nat -L -n
#Mesmo confg host network
docker run -ti --net=host debian

https://www.youtube.com/watch?v=pKJgQmXXryg&list=PLf-O3X2-mxDkiUH0r_BadgtELJ_qyrFJ_&index=16


#Docker Machine 
#Instalação e docker host
base=https://github.com/docker/machine/releases/download/v0.16.0 && 
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
sudo install /tmp/docker-machine /usr/local/bin/docker-machine

base=https://github.com/docker/machine/releases/download/v0.16.0 &&  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine
docker-machine --version
docker-machine create --driver virtualbox testedockermachine
docker-machine ls

docker-machine env testedockermachine
eval $(docker-machine env testedockermachine)
docker ps 
docker-machine ls 

docker run busybox echo "Testando"
docker run -ti debian
docker ps

docker-machine ip testedockermachine
docker-machine ssh testedockermachine
docker-machine inspect testedockermachine
docker-machine stop testedockermachine
docker-machine ls 
docker-machine start testedockermachine
docker-machine rm testedockermachine

#Docker Compose
sudo apt -y install docker-compose
docker-compose --version
docker-compose --help
vim docker-compose.yml

#Comandos
#Build = indica o caminho do seu Dockerfile
build:

#command = Executa um comando
comando: bundle exec thin -p 3000

#container_name = Nome para o container
container_name: my-web-container

#dns = Indica o dns server
dns: 8.8.8.8

#dns_search = Especifica um search domain
dns_search: example.com

#dockerfile = Especifica um Dockerfile alternativo
dockerfile: Dockerfile-altenate

#env_file = Especifica um arquivo com variáveis de ambiente
env_file = .env

#environment = Adiciona variáveis de ambiente
environment:
	RACK_ENV: development

#expose = Expõe a porta do container
expose:
 - "3000"
 - "8000"

#external_links = "Linka" containers que não estão especificando no docker-compose atual
external_links:
 - redis_1
 - project_db_1:mysql

#extra_hosts = adiciona uma entrada no /etc/hosts do container
extra_hosts:
 - "somehost:123.456.478.15"
 - "otherhost:159.263.478.55"

#image = Indica uma imagem
image: ubuntu:14.04

#labels = Adiciona metadata ao container
labels:
  com.example.description:"XX"
  com.example.department: "Finance"

#links = linka containers dentro do mesmo docker-compose
links:
  -db
  - db.database

#log_driver = Indica o fomato do log a ser gerado, por ex: syslog, json-file, etc
log_driver: syslog

OU

logging:
  driver: syslog

#log_opt = Indica onde mandar os logs, pode ser local ou em um syslog remoto
log_opt:
	syslog-address: "tcp://192.168.88.45:123"

OU

logging:
  driver: syslog
  options:
	syslog-address: "tcp://192.168.88.45:123"

#net = Modo de uso da rede
net: "bridge"
net: "host"

#ports = Expõe as portas do container e do host
ports
  - "3000"
  - "8000:8000"

#volumes, volume_driver = Monta volumes no container
volumes:
  # Just specify a path and let the Engine create a volume
  - /var/lib/mysql

  #Specify an absolute path mapping
  - /opt/data:var/lib/mysql

  # Path on the host, relative to the Compose file
  - ./cache:tmp/cache

#volumes_from = Monta volumes através de outro container
volumes_from:
  - service_name
  - service_name: ro

#Docker compose na pratica
docker-compose ps
docker-compose scale db=2
docker-compose stop
docker-compose ps 
docker-compose logs

#Cluster e Orquestração
#Certificação TLS - SEGURANÇA

#Alta disponibilidade
cluster1: docker swarm join \
    --token SWMTKN-1-09s38y4killi0w33nitqc24des0xtunv1dnhnfbz4eikhqpxzg-7clppc0lbzbxz1faksw5a89jo \
    [2804:14d:8083:8b1c:a9d8:28ef:a30f:ad6]:2377

docker node ls

NODE1: 
NODE2:

