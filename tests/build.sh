#!/usr/bin/env bash
cp ./contrib/docker/Dockerfile.apache ./
mv Dockerfile.apache Dockerfile
sed -i "s~libwebp7~libwebp6~g" ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/pixelfed:latest | docker load
