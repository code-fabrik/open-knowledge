# Updating images

* Pull the latest image: `docker pull ghcr.io/mikecao/umami:postgresql-latest`
* Retag the image: `docker tag ghcr.io/mikecao/umami:postgresql-latest dokku/umami:postgresql-latest`
* Deploy: `dokku tags:deploy umami postgresql-latest`
