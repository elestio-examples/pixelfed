sleep 60s;

docker-compose up -d;
docker-compose exec -T app php artisan key:generate
# docker-compose restart app
docker-compose exec -T app php artisan config:cache --force
docker-compose exec -T app php artisan migrate --force
docker-compose exec -T app php artisan passport:install --force
docker-compose exec -T app php artisan instance:actor
# docker-compose restart app

docker-compose down
docker-compose up -d;

sleep 60s;