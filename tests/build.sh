#!/usr/bin/env bash

sed -i 's~PHP_VERSION="8.1"~PHP_VERSION="8.3"~g' ./Dockerfile
sed -i 's~PHP_BASE_TYPE="apache"~PHP_BASE_TYPE="fpm"~g' ./Dockerfile

rm -rf ./.dockerignore
sed -i "s~libwebp7~libwebp6~g" ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/pixelfed:latest | docker load
