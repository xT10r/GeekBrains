#!/bin/bash

image_name="py-app"
image_tag="v1"

echo "=============> Stop container"
docker stop $(docker ps -aq -f ancestor=$image_name:$image_tag)

echo "=============> Clear container"
docker rm -f $(docker ps -aq -f ancestor=$image_name:$image_tag)

echo "=============> Clear images (1) ..."
docker rmi -f $(docker images $image_name:$image_tag)

echo "=============> Clear images (2) ..."
docker rmi -f $(docker images -f dangling=true)
