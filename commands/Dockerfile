FROM nginx:1.19.4-alpine
LABEL maintainer="FischerNZ <fischerrobson@gmail.com>"
COPY . /usr/nginx/share/html
EXPOSE 80

# EXECUTAR
# docker build -f Dockerfile -t fischernz/webserver:v1 .
## caso o arquivo se chame Dockerfile, o -f Dockerfile nao e necessario
## -t [DOCKER_USER]/[NOME_IMAGEM]:[TAG]