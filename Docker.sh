#Instalando o Docker
unema -m
apt -y update
apt list --upgradable
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt -y update
apt-cache policy docker-engine
apt install -y docker-engine
/etc/init.d/docker status
#Executando o Comando Docker sem Sudo
sudo usermod -aG docker $(whoami)

docker info
#Trabalhando com Imagens do Docker
docker run hello-world
docker search ubuntu
docker pull ubuntu
docker run ubuntu
docker run --ti --name teste debian
docker images
#Executando um Contêiner Docker
docker run -it ubuntu
apt-get update

#Para todas as instâncias
docker stop $(docker ps -a -q)
#Remove todas as instâncias
docker rm $(docker ps -a -q)
#Para todas as imagens
docker image rm $(docker image ls -a -q)
#Export Image
#docker commit -m "What did you do to the image" -a "Author Name" id-do-contêiner repositório/nome_da_nova_imagem

docker images
docker ps 
docker ps -a #active
docker ps -l #last
docker stop id-do-contêiner #stop

#Docker Hub
docker login
docker push username-do-registro-docker/nome-da-imagem-docker
docker rm $(docker ps -qa) #remvoer todos

#CTRL+P + Q
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