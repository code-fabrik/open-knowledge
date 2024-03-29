# Umami

To get started with Umami, read the
[docker-compose.yml](https://github.com/mikecao/umami/blob/master/docker-compose.yml).

It states the following:

* Umami has a Docker image at docker.umami.dev/umami-software/umami:postgresql-latest
* It listens on port 3000
* It depends on PostgreSQL
* It reads the PostgreSQL config from DATABASE_URL
* It requires the env variables DATABASE_URL, DATABASE_TYPE and HASH_SALT

## Preparing dokku and the image

* Create a dokku app: `dokku apps:create umami`
* Pull the Docker image: `docker pull docker.umami.dev/umami-software/umami:postgresql-latest`

## Create services

* Install postgres plugin: `sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres`
* Create a postgres service: `dokku postgres:create umami-postgres`
* Link the database to the application: `dokku postgres:link umami-postgres umami`

## Set the env variables

* `dokku config:set umami HASH_SALT=4ZdrPd7vWmgloyupUsgaHysUZoa0SE8ZNULKLFcz`
* `dokku config:set umami DATABASE_TYPE=postgresql`

Notes:
- The environment variable `DATABASE_URL` must not be set manually since it was automatically set when linking the database to the application.
- Create a random value for `HASH_SALT`, e.g. with `openssl rand -hex 32`

## Change port mapping

* `dokku proxy:ports-remove umami http:80:5000`
* `dokku proxy:ports-add umami http:80:3000`

## Create database tables

* Open the Umami [Github repository](https://github.com/mikecao/umami)
* Copy the content of the file `sql/schema.postgresql.sql`
* Open a connection to your dokku PostgreSQL instance: `dokku postgres:connect umami-postgres`
* Paste the content of the file that you previously copied

## Add domain name (optional)

* Run `dokku domains:add umami sub.domain.com`

## Deploy the image

* Run `dokku git:from-image umami docker.umami.dev/umami-software/umami:postgresql-latest`

The default username is `admin` and the default password is `umami`.

## Updating

* Pull the latest image: `docker pull docker.umami.dev/umami-software/umami:postgresql-latest`
* Run `dokku git:from-image umami docker.umami.dev/umami-software/umami:postgresql-latest`
* Rebuild the application: `dokku ps:rebuild umami`

## Troubleshooting

* Debug proxy mapping: `dokku nginx:error-logs umami -t`
