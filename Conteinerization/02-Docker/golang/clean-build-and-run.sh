#!/bin/bash

image_name="go-app"
image_tag="v1"

echo "=============> Stop container"
docker stop $(docker ps -aq -f ancestor=$image_name:$image_tag)

echo "=============> Clear container"
docker rm -f $(docker ps -aq -f ancestor=$image_name:$image_tag)

echo "=============> Clear images (1) ..."
docker rmi -f $(docker images $image_name:$image_tag)

echo "=============> Clear images (2) ..."
docker rmi -f $(docker images -f dangling=true)

echo "=============> Build image"
docker build . -t $image_name:$image_tag

echo "=============> Run image"
docker run -d -p 8080:8080 $image_name:$image_tag

sleep 2
echo "=============> Curl App"
result=$(curl --silent -k http://localhost:8080)
echo $result
sleep 2
