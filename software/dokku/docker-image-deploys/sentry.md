# Sentry

## Preparation

* Create a dokku app: `dokku apps:create sentry`
* Pull the Docker image: `docker pull codefabrikgmbh/sentry:latest`
* Retag the Docker image to match the app: `docker tag codefabrikgmbh/sentry:latest dokku/sentry:latest`

Note: The original sentry/latest image can be run on Dokku. It is not possible
to run worker or cron processes though. In order to run multiple processes per
image, Dokku requires a Procfile to be present. The image mentioned above does
add this Procfile. The source can be found
[here](https://github.com/code-fabrik/dockerfiles/tree/master/sentry).

## Services

Most Docker images require additional services to be present. You will usually
find them in the documentation. The documentation for Sentry is backed up in
[sentry-original-docs.md](sentry-original-docs.md).

For Sentry, the required services are the following:

* Redis for storing the events
* PostgreSQL for storing other data

Install the required plugins and create the services:

```bash
dokku postgres:create sentry-postgres
dokku postgres:link sentry-postgres sentry

dokku redis:create sentry-redis
dokku redis:link sentry-redis sentry
```

To get a persistent storage volume, mount a folder:

`dokku storage:mount sentry /var/lib/dokku/data/storage/sentry:/var/lib/sentry/files/`

## Config

To continue, you need to check out the documentation of the image you want to
deploy to see what configuration or env variables need to be set. For Sentry,
the following env variables are required:

* SENTRY_SECRET_KEY, which you can generate with `docker run --rm sentry config generate-secret-key`
* SENTRY_REDIS_PASSWORD, which you can get from `dokku redis:info sentry-redis`

## Add proxy settings

`dokku proxy:ports-add sentry http:80:9000`

## Deploy

`dokku tags:deploy sentry latest`

## After first run

Sentrys README mentions that the `upgrade` command needs to be run in the
container to migrate the database and create an admin user. In Dokku, this can
be achieved by entering the running container and running the following
command:

`/entrypoint.sh upgrade`
