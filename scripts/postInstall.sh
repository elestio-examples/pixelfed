#set env vars
set -o allexport; source .env; set +o allexport;

echo "Waiting for software to be ready ..."
sleep 120s;

# docker-compose exec -T app php artisan key:generate
# docker-compose restart app
docker-compose exec -T app php artisan config:cache 
docker-compose exec -T app php artisan migrate --force
yes | docker-compose exec -T app php artisan passport:install --force
docker-compose exec -T app php artisan instance:actor
docker-compose restart app

echo -e "admin\nadmin\n${ADMIN_EMAIL}\n${ADMIN_PASSWORD}\n${ADMIN_PASSWORD}\ny\ny\ny" | docker-compose exec -T app php artisan user:create

chmod 777 ./storage/app-storage/oauth-private.key 
chmod 777 ./storage/app-storage/oauth-public.key 

sleep 30s;
docker-compose down;
docker-compose up -d;