# REDES
docker network ls

# CRIAR CONTAINER COM REDE DO HOST
docker run --net host [IMAGEM]

# INSPECIONAR REDE
docker inspect network bridge
docker inspect network host
docker inspect network none

# CRIAR REDE
docker network create --driver bridge [REDE]

# CONECTAR SUBREDES
docker network connect bridge [CONTAINER] # considerando que o container esta em outra rede

# DESCONECTAR SUBREDES
docker network disconnect bridge [CONTAINER] 

# REDE PADRÃO BRIDGE