[![Travis](https://shields.beevelop.com/travis/beevelop/docker-directus.svg?style=flat-square)](https://travis-ci.org/beevelop/docker-directus)
[![Docker Pulls](https://shields.beevelop.com/docker/pulls/beevelop/directus.svg?style=flat-square)](https://links.beevelop.com/d-directus)
[![ImageLayers Layers](https://shields.beevelop.com/imagelayers/layers/beevelop/directus/latest.svg?style=flat-square)](https://links.beevelop.com/d-directus)
[![ImageLayers Size](https://shields.beevelop.com/imagelayers/image-size/beevelop/directus/latest.svg?style=flat-square)](https://links.beevelop.com/d-directus)
[![GitHub release](https://shields.beevelop.com/github/release/beevelop/docker-directus.svg?style=flat-square)](https://github.com/beevelop/docker-directus/releases)
![Badges](https://shields.beevelop.com/badge/badges-7-brightgreen.svg?style=flat-square)
[![Beevelop](https://links.beevelop.com/honey-badge)](https://beevelop.com)

# [Directus](https://github.com/directus/directus) containerized

> Directus is an awesome database GUI that provides a feature-rich environment for rapid development and management of custom database schemas.

## Quickstart (recommended)
1. `git clone https://github.com/beevelop/docker-directus && cd docker-directus`
2. Adapt `docker-compose.yml` to your needs
3. Run using `docker-compose up`

----

### Pull from Docker Hub
```
docker pull beevelop/directus:latest
```

### Or build from GitHub
```
docker build -t beevelop/directus github.com/beevelop/docker-directus
```

### Then run image
```bash
# Start the mysql database
docker run -e MYSQL_ROOT_PASSWORD=Un1c0rns_4r3_4w3s0m3 \
          -e MYSQL_DATABASE=directus -e MYSQL_USER=directus \
          -e MYSQL_PASSWORD=Un1c0rn \
          -v `pwd`/db/:/var/lib/mysql/ \
          --name mysql -d mysql:5.5

# Start directus
docker run -e ADMIN_EMAIL=directus@example.com \
           -e SITE_NAME=Dockerectus \
           -e ADMIN_PASSWORD=Un1c0rn \
           -v `pwd`/logs/:/var/www/html/api/logs \
           -v `pwd`/media/:/var/www/html/media \
           --link mysql:mysql \
           -p 8080:80 \
           --name directus -d beevelop/directus
```

You should the be able to access your Directus installation at **http://YOUR_HOST:8080** (login with `directus@example.com:Un1c0rn`).

### Use as base image
```Dockerfile
FROM beevelop/directus:latest
```

----

![One does not simply use latest](https://i.imgflip.com/1fgwxr.jpg)
