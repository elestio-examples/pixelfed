#set env vars
#set -o allexport; source .env; set +o allexport;

mkdir -p ./data
mkdir -p ./redis-data
mkdir -p ./db-data
mkdir -p ./app-storage
mkdir -p ./app-bootstrap
chown -R 1000:1000 ./data
