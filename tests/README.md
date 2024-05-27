<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Pixelfed, verified and packaged by Elestio

[Pixelfed](https://pixelfed.org) is an open source, decentralized alternative to Instagram that recently added a tool for importing all your Instagram photos. This means you can automatically give all of the photos and videos you uploaded to Instagram a new home.

<img src="https://github.com/elestio-examples/pixelfed/raw/main/pixelfed.jpeg" alt="pixelfed" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/pixelfed">fully managed Pixelfed</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/pixelfed/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/pixelfed)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/pixelfed.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    ./scripts/presInstall.sh
    docker-compose up -d
    ./scripts/postInstall.sh

You can access the Web UI at: `http://your-domain:8686`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"

    services:
      app:
      image: elestio4test/pixelfed:latest
      restart: always
      env_file:
        - ./.env
      volumes:
        - ./app-storage:/var/www/storage - "./.env:/var/www/.env"
      ports:
        - "172.17.0.1:8686:80"
      depends_on:
        - db
        - redis

      worker:
        image: elestio4test/pixelfed:latest
        restart: always
        env_file:
          - ./.env
        volumes:
          - ./app-storage:/var/www/storage
          - "./.env:/var/www/.env"
        command: gosu www-data php artisan horizon
        depends_on:
          - db
          - redis

      db:
        image: mariadb:jammy
        restart: always
        command: --default-authentication-plugin=mysql_native_password
        env_file:
          - ./.env
        volumes:
          - "./db-data:/var/lib/mysql"
        ports:
          - 172.17.0.1:4406:3306

      redis:
        image: elestio/redis:7.0
        restart: always
        env_file:
          - ./.env
        volumes:
          - "./redis-data:/data"
        command: ["redis-server", "--requirepass", "${REDIS_PASSWORD}"]

### Environment variables

|            Variable            |     Value (example)     |
| :----------------------------: | :---------------------: |
|          ADMIN_EMAIL           |     your@email.com      |
|         ADMIN_PASSWORD         |      your-password      |
|            APP_NAME            |      Pixelfed Prod      |
|            APP_ENV             |       production        |
|           APP_DEBUG            |          false          |
|            APP_URL             | https://your.domain.com |
|           APP_DOMAIN           |     your.domain.com     |
|          ADMIN_DOMAIN          |     your.domain.com     |
|         SESSION_DOMAIN         |     your.domain.com     |
|       OPEN_REGISTRATION        |          true           |
|   ENFORCE_EMAIL_VERIFICATION   |          false          |
|          PF_MAX_USERS          |          2000           |
|         OAUTH_ENABLED          |          true           |
|          APP_TIMEZONE          |           UTC           |
|           APP_LOCALE           |           en            |
|       LIMIT_ACCOUNT_SIZE       |          true           |
|        MAX_ACCOUNT_SIZE        |         2000000         |
|         MAX_PHOTO_SIZE         |          15000          |
|        MAX_AVATAR_SIZE         |          2000           |
|       MAX_CAPTION_LENGTH       |           500           |
|         MAX_BIO_LENGTH         |           125           |
|        MAX_NAME_LENGTH         |           30            |
|        MAX_ALBUM_LENGTH        |            4            |
|         IMAGE_QUALITY          |           80            |
|       PF_OPTIMIZE_IMAGES       |          true           |
|       PF_OPTIMIZE_VIDEOS       |          true           |
|        ADMIN_ENV_EDITOR        |          false          |
|        ACCOUNT_DELETION        |          true           |
|      ACCOUNT_DELETE_AFTER      |          false          |
|       MAX_LINKS_PER_POST       |            0            |
|    INSTANCE_PUBLIC_HASHTAGS    |          false          |
| INSTANCE_PUBLIC_LOCAL_TIMELINE |          false          |
|        STORIES_ENABLED         |          false          |
|      RESTRICTED_INSTANCE       |          false          |
|          MAIL_DRIVER           |          smtp           |
|           MAIL_HOST            |       172.17.0.1        |
|           MAIL_PORT            |           25            |
|       MAIL_FROM_ADDRESS        |    sender@email.com     |
|         MAIL_FROM_NAME         |        Pixelfed         |
|        MAIL_ENCRYPTION         |          null           |
|         DB_CONNECTION          |          mysql          |
|          DB_DATABASE           |      pixelfed_prod      |
|            DB_HOST             |           db            |
|          DB_PASSWORD           |      your-password      |
|            DB_PORT             |          3306           |
|          DB_USERNAME           |        pixelfed         |
|         MYSQL_DATABASE         |      pixelfed_prod      |
|         MYSQL_PASSWORD         |      your-password      |
|   MYSQL_RANDOM_ROOT_PASSWORD   |          true           |
|           MYSQL_USER           |        pixelfed         |
|          REDIS_CLIENT          |        phpredis         |
|          REDIS_SCHEME          |           tcp           |
|           REDIS_HOST           |          redis          |
|         REDIS_PASSWORD         |     redis_password      |
|           REDIS_PORT           |          6379           |
|         REDIS_DATABASE         |            0            |
|         HORIZON_PREFIX         |        horizon-         |
|             EXP_LC             |          false          |
|            EXP_REC             |          false          |
|           EXP_LOOPS            |          false          |
|          ACTIVITY_PUB          |          false          |
|        AP_REMOTE_FOLLOW        |          false          |
|         AP_SHAREDINBOX         |          false          |
|            AP_INBOX            |          false          |
|           AP_OUTBOX            |          false          |
|           ATOM_FEEDS           |          true           |
|            NODEINFO            |          true           |
|           WEBFINGER            |          true           |
|       FILESYSTEM_DRIVER        |          local          |
|        FILESYSTEM_CLOUD        |           s3            |
|        PF_ENABLE_CLOUD         |          false          |
|        HORIZON_DARKMODE        |          false          |
|       PF_COSTAR_ENABLED        |          false          |
|      MEDIA_EXIF_DATABASE       |          false          |
|          LOG_CHANNEL           |         stderr          |
|          IMAGE_DRIVER          |         imagick         |
|        BROADCAST_DRIVER        |           log           |
|          CACHE_DRIVER          |          redis          |
|      RESTRICT_HTML_TYPES       |          true           |
|          QUEUE_DRIVER          |          redis          |
|         SESSION_DRIVER         |          redis          |
|         TRUST_PROXIES          |           \*            |
|      DOCKER_DB_HOST_PORT       |          3306           |
|         OAUTH_ENABLED          |          false          |

# Maintenance

## Logging

The Elestio Pixelfed Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://docs.pixelfed.org/">Pixelfed documentation</a>

- <a target="_blank" href="https://github.com/pixelfed/pixelfed">Pixelfed Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/pixelfed">Elestio/Pixelfed Github repository</a>
