#BAIXAR IMAGEM (SEMPRE PASSAR A TAG DE VERSAO)
docker pull [IMAGEM]:[TAG]

#LISTAR CONTAINERS (-a EXIBE OS CONTAINERS PARADOS TAMBEM)
docker container ls -a
docker ps 

#LISTAR IMAGENS
docker image ls

#REMOVER IMAGEM
docker image rm [IMAGEM] -f #nome:tag ou id

#REMOVER CONTAINER
docker rm [CONTAINER] -f #nome:tag ou id

#MAPEAMENTO DE PORTAS
docker run -d -p [PORTA_LOCAL]:[PORTA_CONTAINER] [IMAGEM]
docker run -d -p 8080:80 nginx:1.19.4-alpine #executa o nginx e faz o espelhamento da porta 80 (container) para a 8080 (máquina)