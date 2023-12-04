#!/usr/bin/env bash
set -o allexport; source .env; set +o allexport;
docker-compose up -d;
sleep 30s;

yes |docker-compose exec -T app php artisan migrate

set -o allexport; source .env; set +o allexport;

docker-compose exec -T app php artisan key:generate
docker-compose restart app
docker-compose exec -T app php artisan config:cache
yes | docker-compose exec -T app php artisan migrate
docker-compose exec -T app php artisan passport:install
docker-compose exec -T app php artisan instance:actor
docker-compose restart app

echo -e "admin\nadmin\n${ADMIN_EMAIL}\n${ADMIN_PASSWORD}\n${ADMIN_PASSWORD}\ny\ny\ny" | docker-compose exec -T app php artisan user:create

sleep 30s;
docker-compose down;
docker-compose up -d;