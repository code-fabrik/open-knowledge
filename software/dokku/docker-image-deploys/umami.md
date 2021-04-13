# Umami

To get started with Umami, read the
[docker-compose.yml](https://github.com/mikecao/umami/blob/master/docker-compose.yml).

It states the following:

* Umami has a Docker image at ghcr.io/mikecao/umami:postgresql-latest
* It listens on port 3000
* It depends on PostgreSQL
* It reads the PostgreSQL config from DATABASE_URL
* It requires the env variables DATABASE_URL, DATABASE_TYPE and HASH_SALT

## Preparing dokku and the image

* Create a dokku app: `dokku apps:create umami`
* Pull the Docker image: `docker pull ghcr.io/mikecao/umami:postgresql-latest`
* Retag the Docker image to match the app: `docker tag ghcr.io/mikecao/umami:postgresql-latest dokku/umami:postgresql-latest`

## Create services

* Create a postgres service: `dokku postgres:create umami-postgres`
* Link the service: `dokku postgres:link umami-postgres umami`

## Set the env variables

* `dokku config:set umami HASH_SALT=4ZdrPd7vWmgloyupUsgaHysUZoa0SE8ZNULKLFcz`
* `dokku config:set umami DATABASE_TYPE=postgresql`

## Change port mapping

* `dokku proxy:ports-remove umami http:80:5000`
* `dokku proxy:ports-add umami http:80:3000`

## Deploy the image

`dokku tags:deploy umami postgresql-latest`

The default username is `admin` and the default password is `umami`.

## Troubleshooting

* Debug proxy mapping: `dokku nginx:error-logs umami -t`
