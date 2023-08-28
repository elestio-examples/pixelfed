#set env vars
set -o allexport; source .env; set +o allexport;

echo "Waiting for software to be ready ..."
sleep 30s;

NEW_KEY=$(docker-compose exec app php artisan key:generate --show)
echo "================================================================"
echo $NEW_KEY
echo "================================================================"

docker-compose exec app php artisan key:generate
docker-compose restart app
docker-compose exec app php artisan config:cache
yes |docker-compose exec -T app php artisan migrate
docker-compose restart app

echo -e "admin\nadmin\n${ADMIN_EMAIL}\n${ADMIN_PASSWORD}\n${ADMIN_PASSWORD}\ny\nn\ny" | docker-compose exec -T app php artisan user:create