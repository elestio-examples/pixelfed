#set env vars
set -o allexport; source .env; set +o allexport;

echo "Waiting for software to be ready ..."
sleep 30s;

docker-compose exec -T app php artisan key:generate
docker-compose restart app
docker-compose exec -T app php artisan config:cache
yes |docker-compose exec -T app php artisan migrate
docker-compose exec -T app php artisan passport:install
docker-compose restart app

echo -e "admin\nadmin\n${ADMIN_EMAIL}\n${ADMIN_PASSWORD}\n${ADMIN_PASSWORD}\ny\ny\ny" | docker-compose exec -T app php artisan user:create

sleep 30s;
docker-compose down;
docker-compose up -d;