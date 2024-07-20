docker-compose up -d;
echo "first sleep"
sleep 60s;
# docker-compose exec -T app php artisan key:generate
# docker-compose down;
# docker-compose up -d;
# sleep 60s;
# docker-compose restart app
echo "starting configs"
echo "starting php artisan config:cache"
docker-compose exec -T app php artisan config:cache 
echo "starting php artisan migrate"
docker-compose exec -T app php artisan migrate --force
echo "starting php artisan passport:install"
docker-compose exec -T app php artisan passport:install --force
echo "starting php artisan instance:actor"
docker-compose exec -T app php artisan instance:actor
# docker-compose restart app

echo "restarting"
docker-compose down
docker-compose up -d;

echo "second sleep"
sleep 60s;
echo "check response 200"