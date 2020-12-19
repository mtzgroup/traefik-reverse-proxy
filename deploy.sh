# Script that automates the recommended pre-deploy steps outlined at
# https://dockerswarm.rocks/traefik/
# to run: bash pre_deploy.sh mytraefik.domain.com path/to/traefik.yaml

docker network create --driver=overlay traefik-public
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID
export DOMAIN=$1
docker stack deploy -c $2 traefik