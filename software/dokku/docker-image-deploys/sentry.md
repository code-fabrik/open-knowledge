# Sentry

## Preparation

* Create a dokku app: `dokku apps:create sentry`
* Pull the Docker image: `docker pull getsentry/sentry:20.9.0`
* Retag the Docker image to match the app: `docker tag getsentry/sentry:20.9.0 dokku/sentry:20.9.0`


## Services

Most Docker images require additional services to be present. You will usually
find them in the [docker-compose.yml](https://github.com/getsentry/onpremise/blob/master/docker-compose.yml)
of the source repo.

For Sentry, the required services are the following:

* Redis for storing the events
* PostgreSQL for storing other data
* Memcached as a cache

Install the required plugins and create the services:

```bash
dokku postgres:create sentry-postgres
dokku postgres:link sentry-postgres sentry

dokku redis:create sentry-redis
dokku redis:link sentry-redis sentry

dokku memcached:create sentry-memcached
dokku memcached:link sentry-memcached sentry
```

To get a persistent storage volume, mount a folder:
`dokku storage:mount sentry /var/lib/dokku/data/storage/sentry:/var/lib/sentry/files/`

## Config

To continue, you need to check out the documentation of the image you want to
deploy to see what configuration or env variables need to be set. For Sentry,
the following env variables are required:

* SENTRY_SECRET_KEY, which you can generate with `docker run --rm sentry config generate-secret-key`
* SENTRY_REDIS_PASSWORD, which you can get from `dokku redis:info sentry-redis`

## Start

`docker run -it --rm -e SENTRY_SECRET_KEY='<secret-key>' --link dokku.postgres.sentry-postgres:postgres --link dokku.redis.sentry-redis:redis sentry upgrade`

## Add proxy settings

`dokku proxy:ports-add sentry http:80:9000`

## Deploy

`dokku tags:deploy sentry 9.1.2`
