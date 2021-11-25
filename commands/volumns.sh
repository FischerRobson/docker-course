# MAPEAR VOLUME
docker run -v "[VOLUME_LOCAL]:[VOLUMOE_CONTAINER]"

# MAPEANDO O index.html PARA O NGINX
docker run --name nginx_alpine -d -p 8080:80 -e NGINX_ENTRYPOINT_QUIET_LOGS=1 -v "/home/fischer/Dev/docker/commands:/usr/share/nginx/html" nginx:1.19.4-alpine