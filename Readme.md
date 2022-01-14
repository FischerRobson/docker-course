# Docker
![image](.github/docker.png)

## Sobre Docker
É uma ferramenta que se apoia em recursos existentes no kernel, inicialmente Linux, para isolar
a execução de processos. As ferramentas que o Docker traz são basicamente uma camada de
administração de containers, baseado originalmente no LXC.

Alguns isolamentos possíveis: 
* Limites de uso de memória
* Limites de uso de CPU
* Limites de uso de I/O
* Limites de uso de rede
* Isolamento da rede (que redes e portas são acessíveis)
* Isolamento do file system
* Permissões e Políticas
* Capacidades do kernel

### DOCKER *vs* VMs
O Docker tende a utilizar menos recursos que uma VM tradicional, um dos motivos é não precisar de
uma pilha completa como vemos em Comparação VMs × Containers. O Docker utiliza o mesmo
kernel do host, e ainda pode compartilhar bibliotecas.
Mesmo utilizando o mesmo kernel é possível utilizar outra distribuição com versões diferentes das
bibliotecas e aplicativos.

![image](.github/container_vs_virtual-machine.png)

Todas as imagens são linux, apesar do host poder ser qualquer SO que use ou emule um kernel
linux, as imagens em si serão baseadas em linux.
Não é possível usar um kernel diferente do host, o Docker Engine estará executando sob
uma determinada versão (ou emulação) do kernel linux, e não é possível executar uma versão
diferente, pois as imagens não possuem kernel.



### IMAGEM
Uma imagem Docker é a materialização de um modelo de um sistema de arquivos, modelo este
produzido através de um processo chamado build.
Esta imagem é representada por um ou mais arquivos e pode ser armazenada em um repositório

### CONTAINER
Container é o nome dado para a segregação de processos no mesmo kernel, de forma que o processo
seja isolado o máximo possível de todo o resto do ambiente.
Em termos práticos são File Systems, criados a partir de uma "imagem" e que podem possuir
também algumas características próprias.


## Comandos

### IMAGEM

#### BAIXAR IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)

```
docker pull [IMAGEM]:[TAG]
```

#### ENVIAR A IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)

```
docker image push [IMAGEM]:[TAG]
```

#### LISTAR IMAGENS

```
docker image ls
```

#### REMOVER IMAGEM

```
docker image rm [IMAGEM] -f # nome:tag ou id
```

### CONTAINER

#### LISTAR CONTAINERS ( -a EXIBE OS CONTAINERS PARADOS TAMBEM )

```
docker container ls -a
docker ps
```

#### CRIAR CONTAINER

```
docker run [IMAGEM]
docker run [IMAGEM] --name [NOME_CONTAINER]
docker run [IMAGEM] -d # modo daemon (background)
```

#### INICIAR CONTAINER

```
docker container start [CONTAINER] # nome:tag ou id
```

#### ENTRAR NO SHELL DO CONTAINER

```
docker exec -it [CONTAINER] sh
```

#### PARAR CONTAINER

```
docker container stop [CONTAINER] # nome:tag ou id
```

#### INSPECIONAR CONTAINER

```
docker inspect [CONTAINER] # nome:tag ou id
```

#### REMOVER CONTAINER

```
docker rm [CONTAINER] -f # nome:tag ou id
```

### REDES

> A rede padrão do docker é a **bridge**

#### LISTAR REDES

```
docker network ls
```

#### MAPEAMENTO DE PORTAS

```
docker run -d -p [PORTA_LOCAL]:[PORTA_CONTAINER] [IMAGEM]
docker run -d -p 8080:80 nginx:1.19.4-alpine # executa o nginx e faz o espelhamento da porta 80 (container)
para a 8080 (máquina)
```

#### CRIAR CONTAINER COM REDE DO HOST

```
docker run --net host [IMAGEM]
```

#### INSPECIONAR REDE

```
docker inspect network bridge
docker inspect network host
docker inspect network none
```

#### CRIAR REDE

```
docker network create --driver bridge [REDE]
```

#### CONECTAR SUBREDES

```
docker network connect bridge [CONTAINER] # considerando que o container esta em outra rede
```

#### DESCONECTAR SUBREDES

```
docker network disconnect bridge [CONTAINER]
```

### VOLUMES

#### MAPEAR VOLUME

```
docker run -v "[VOLUME_LOCAL]:[VOLUMOE_CONTAINER]"
```

#### MAPEANDO O _index.html_ PARA O NGINX

```
docker run --name nginx_alpine -d -p 8080:80 -e NGINX_ENTRYPOINT_QUIET_LOGS=1 -v "/home/fischer/Dev/docker/commands:/usr/share/nginx/html" nginx:1.19.4-alpine
```
