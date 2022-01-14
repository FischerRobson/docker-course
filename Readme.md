# Docker

## Sobre Docker

### IMAGEM

### CONTAINER

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
