#!/usr/bin/env bash
cp -rf ./contrib/docker/Dockerfile.apache
mv Dockerfile.apache Dockerfile
docker buildx build . --output type=docker,name=elestio4test/pixelfed:latest | docker load
