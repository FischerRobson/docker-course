# Docker

<p align="center">
  <img src=".github/docker.png" />
</p>

## Sobre Docker

É uma ferramenta que se apoia em recursos existentes no kernel, inicialmente Linux, para isolar
a execução de processos. As ferramentas que o Docker traz são basicamente uma camada de
administração de containers, baseado originalmente no LXC.

<p align="center">
  <img src=".github/docker-engine.png" />
</p>

Alguns isolamentos possíveis:

- Limites de uso de memória
- Limites de uso de CPU
- Limites de uso de I/O
- Limites de uso de rede
- Isolamento da rede (que redes e portas são acessíveis)
- Isolamento do file system
- Permissões e Políticas
- Capacidades do kernel

### DOCKER _vs_ VMs

O Docker tende a utilizar menos recursos que uma VM tradicional, um dos motivos é não precisar de
uma pilha completa como vemos em Comparação VMs × Containers. O Docker utiliza o mesmo
kernel do host, e ainda pode compartilhar bibliotecas.
Mesmo utilizando o mesmo kernel é possível utilizar outra distribuição com versões diferentes das
bibliotecas e aplicativos.
Enquanto máquinas virtuais levam minutos para iniciar, os container podem ser inicializados em segundos, consumindo
muito menos recursos.

<p align="center">
  <img src=".github/container_vs_virtual-machine.png" />
</p>

Todas as imagens são linux, apesar do host poder ser qualquer SO que use ou emule um kernel
linux, as imagens em si serão baseadas em linux.
Não é possível usar um kernel diferente do host, o Docker Engine estará executando sob
uma determinada versão (ou emulação) do kernel linux, e não é possível executar uma versão
diferente, pois as imagens não possuem kernel.

### IMAGEM

Uma imagem Docker é a materialização de um modelo de um sistema de arquivos, modelo este
produzido através de um processo chamado build.
Esta imagem é representada por um ou mais arquivos e pode ser armazenada em um repositório.
A tecnologia por trás das imagens é a Overlay filesystem do Linux, permitindo combinar camadas de somente leitura,
dessa forma uma mesma camada pode ser utilizada em diversos containers, poupando processamento. No topo dela,
há uma camada de leitura/escrita.

### CONTAINER

Container é o nome dado para a segregação de processos no mesmo kernel, de forma que o processo
seja isolado o máximo possível de todo o resto do ambiente.
Em termos práticos são File Systems, criados a partir de uma "imagem" e que podem possuir
também algumas características próprias.

#### ENTENDENDO MELHOR

Utilizando uma analogia com OOP, podemos comparar um container a um objeto (instância),
enquanto a imagem seria uma classe (modelo).

Toda imagem (bem como os containers) possuem um identificador único em formato hash usando
sha256. Porém seu uso não é muito prático, então para simplificar isto o docker utiliza uma tag para
identificar imagens.
A tag normalmente é formada por um nome, seguido de : dois pontos e depois uma versão. É
extremamente comum utilizar uma versão chamada latest para representar a versão mais atual.

## Comandos

### IMAGEM

#### BAIXAR IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)

```sh
docker pull [IMAGEM]:[TAG]
```

#### ENVIAR A IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)

```sh
docker image push [IMAGEM]:[TAG]
```

#### LISTAR IMAGENS

```sh
docker image ls
```

#### REMOVER IMAGEM

```sh
docker image rm [IMAGEM] -f # nome:tag ou id
```

#### INSPECIONAR IMAGEM

```sh
docker image inspect [IMAGEM]
```

#### ELIMINAR IMAGENS SEM REFERÊNCIA

```sh
docker image prune
```

### CONTAINER

#### LISTAR CONTAINERS ( -a EXIBE OS CONTAINERS PARADOS TAMBEM )

```sh
docker container ls -a
docker ps # antiga sintaxe
```

#### CRIAR CONTAINER

```sh
docker run [IMAGEM]
docker run --name [NOME_CONTAINER] [IMAGEM] 
docker run [IMAGEM] -d # modo daemon (background)
docker run [IMAGEM] -it [BASH/SH] # modo interativo
```

#### INICIAR CONTAINER

```sh
docker container start [CONTAINER] # nome:tag ou id
```

#### ENTRAR NO SHELL DO CONTAINER

```sh
docker exec -it [CONTAINER] sh
```

#### PARAR CONTAINER

```sh
docker container stop [CONTAINER] # nome:tag ou id
```

#### INSPECIONAR CONTAINER

```sh
docker container inspect [CONTAINER] # nome:tag ou id
```

#### REMOVER CONTAINER

```sh
docker container rm [CONTAINER] -f # nome:tag ou id
```

#### VERIFICAR LOGS

```sh
docker container logs [CONTAINER]
docker container logs -n 5 [CONTAINER] # apenas 5 linhas de logs
docker container logs -t [CONTAINER] # data e hora
```

### REDES

> A rede padrão do docker é a **bridge**

#### LISTAR REDES

```sh
docker network ls
```

#### MAPEAMENTO DE PORTAS

> É possível mapear tanto portas TCP como UDP diretamente para o host, permitindo acesso através de
> toda a rede, não necessitando ser a mesma porta do container. O método mais comum para este fim
> é o parâmetro -p no comando docker container run, o -p recebe um parâmetro que normalmente é
> composto por dois números separados por : (dois pontos). O primeiro é no host e o segundo é no
> container.

```sh
docker run -d -p [PORTA_LOCAL]:[PORTA_CONTAINER] [IMAGEM]
docker run -d -p 8080:80 nginx:1.19.4-alpine # executa o nginx e faz o espelhamento da porta 80 (container)
para a 8080 (máquina)
```

#### CRIAR CONTAINER COM REDE DO HOST

```sh
docker run --net host [IMAGEM]
```

#### INSPECIONAR REDE

```sh
docker inspect network bridge
docker inspect network host
docker inspect network none
```

#### CRIAR REDE

```sh
docker network create --driver bridge [REDE]
```

#### CONECTAR SUBREDES

```sh
docker network connect bridge [CONTAINER] # considerando que o container esta em outra rede
```

#### DESCONECTAR SUBREDES

```sh
docker network disconnect bridge [CONTAINER]
```

### VOLUMES

#### MAPEAR VOLUME

> É possível mapear tanto diretórios no host como entidades especiais conhecidas como volumes
> para diretórios no container. Por enquanto vamos nos concentrar no mapeamento mais simples,
> uma diretório no host para um diretório no container. O método mais comum para este fim é o
> parâmetro -v no comando docker container run, o -v recebe um parâmetro que normalmente é
> 12
> composto por dois caminhos absolutos separados por : (dois pontos). Assim como diversos outros
> parâmetros, o primeiro é no host e o segundo é no container.

```sh
docker run -v "[VOLUME_LOCAL]:[VOLUME_CONTAINER]"
```

#### MAPEANDO O _index.html_ PARA O NGINX

```sh
docker run --name nginx_alpine -d -p 8080:80 -e NGINX_ENTRYPOINT_QUIET_LOGS=1 -v "/home/fischer/Dev/docker/commands:/usr/share/nginx/html" nginx:1.19.4-alpine
```

### DOCKERFILE

> Processo para gerar uma nova imagem a partir de um arquivo de instruções. O comando docker
> build é o responsável por ler um Dockerfile e produzir uma nova imagem Docker.
> Cada linha do Dockerfile cria uma camada na imagem, as camadas mais propensas a mudanças devem estar
> no final do arquivo. Tudo que não for alterado, será usado do cache.

#### BOAS PRÁTICAS

- Padrão de nomenclatura: [DOCKER_USER]/[REPOSITÓRIO]:[TAG]
- Prefira usar imagens oficiais.
- Especificar a tag de versão das imagens.
- Usar somente um processo por container.
- Fazer uso consciente das camadas, para facilitar a construção dos conteiners.
- Usar .dockerignore.
- Prefira usar COPY ao ADD.
- CMD pode é mutável, já o ENTRYPOINT (para inicialização imutável) não. É possível combina-los!
- Usar arumentos para construção de imagens.
- Multistage build (para linguagens compiladas ou JIT).

```yml
FROM nginx:1.19.4-alpine
LABEL maintainer="FischerNZ <fischerrobson@gmail.com>"
COPY . /usr/nginx/share/html
EXPOSE 80
```

Para buildar a imagem, execute:

```sh
docker build -t [DOCKER_USER]/[NOME_IMAGEM]:[TAG] .
```

Caso o nome do seu arquivo seja diferente de "Dockerfile", você deverá executar:

```sh
docker build -f [ARQUIVO] -t [DOCKER_USER]/[NOME_IMAGEM]:[TAG] .
```

Passando parâmetros:

```sh
docker build -t [DOCKER_USER]/[NOME_IMAGEM]:[TAG] --build-arg [ARGUMENTO]="[VALOR]"
```

| INSTRUÇÃO  |                                                                                                                                                                             FUNCIONALIDADE                                                                                                                                                                              |
| ---------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| FROM       |                                                                                                                                                        Especifica a imagem base a ser utilizada pela nova imagem                                                                                                                                                        |
| LABEL      |                                                                                             Especifica vários metadados para a imagem como o mantenedor. A especificação do mantenedor era feita usando a instrução específica, MAINTAINER que foi substituída pelo LABEL.                                                                                              |
| ENV        |                                                                                                                                                   Especifica variáveis de ambiente a serem utilizadas durante o build                                                                                                                                                   |
| ARG        |                                                                                                                                         Define argumentos que poderão ser informados ao build através do parâmetro --build-arg.                                                                                                                                         |
| COPY       |                                                                                                                                                           Copia arquivos e diretórios para dentro da imagem.                                                                                                                                                            |
| ADD        |                                                                                                                        Similar ao anterior, mas com suporte extendido a URLs. Somente deve ser usado nos casos que a instrução COPY não atenda.                                                                                                                         |
| RUN        |                                                                                                                                                        Executa ações/comandos durante o build dentro da imagem.                                                                                                                                                         |
| EXPOSE     | Informa ao Docker que a imagem expõe determinadas portas remapeadas no container. A exposição da porta não é obrigatória a partir do uso do recurso de redes internas do Docker. Recurso que veremos em Coordenando múltiplos containers. Porém a exposição não só ajuda a documentar como permite o mapeamento rápido através do parâmetro -P do docker container run. |
| WORKDIR    |                                                                                                                                                     Indica o diretório em que o processo principal será executado.                                                                                                                                                      |
| ENTRYPOINT |                                                                                                                                                               Especifica o processo inicial do container                                                                                                                                                                |
| CMD        |                                                                                                                                                                   Indica parâmetros para o ENTRYPOINT                                                                                                                                                                   |
| USER       |                                                                                                                  Especifica qual o usuário que será usado para execução do processo no container (ENTRYPOINT e CMD) e instruções RUN durante o build.                                                                                                                   |
| VOLUME     |                                                           Instrui a execução do container a criar um volume para um diretório indicado e copia todo o conteúdo do diretório na imagem para o volume criado. Isto simplificará no futuro, processos de compartilhamento destes dados para backup por exemplo.                                                            |
