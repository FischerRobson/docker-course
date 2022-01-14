# BAIXAR IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)
docker pull [IMAGEM]:[TAG]

# ENVIAR A IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)
docker image push [IMAGEM]:[TAG]

# LISTAR CONTAINERS (-a EXIBE OS CONTAINERS PARADOS TAMBEM)
docker container ls -a
docker ps 

# CRIAR CONTAINER
docker run [IMAGEM]
docker run --name [NOME_CONTAINER] [IMAGEM] 

# INICIAR CONTAINER
docker container start [CONTAINER] # nome:tag ou id

# PARAR CONTAINER
docker container stop [CONTAINER] # nome:tag ou id
 
# INSPECIONAR CONTAINER
docker inspect [CONTAINER] # nome:tag ou id

# LISTAR IMAGENS
docker image ls

# REMOVER IMAGEM
docker image rm [IMAGEM] -f # nome:tag ou id

# REMOVER CONTAINER
docker rm [CONTAINER] -f # nome:tag ou id

# MAPEAMENTO DE PORTAS
docker run -d -p [PORTA_LOCAL]:[PORTA_CONTAINER] [IMAGEM] # -d executar em background
docker run -d -p 8080:80 nginx:1.19.4-alpine # executa o nginx e faz o espelhamento da porta 80 (container) para a 8080 (máquina)

# ENTRAR NO SHELL DO CONTAINER
docker exec -it [CONTAINER] sh

# REDES
docker network ls

# LIMPAR CONTAINERS PARADOS, VOLUMES E REDES INUTILIZADOS
docker system prune
