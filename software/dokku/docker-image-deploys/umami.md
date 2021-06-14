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

* Install postgres plugin: `sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres`
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

## Create database tables
* Expose your database to access it locally: `dokku postgres:expose umami-postgres`
* Note the port on which postgres service has exposed the database 5432 -> *PORT* 

Example message: `info -----> Service umami-postgres exposed on port(s) [container->host]: 5432->9750`

* Get information about your database from the `DATABASE_URL`: `dokku postgres:info umami-postgres`

Example message: `DSN: postgres://postgres:YOUR_DB_PASSWORD@dokku-postgres-umami-postgres:5432/umami_postgres`

* Clone umami repo locally and install its dependencies:
```
git clone https://github.com/mikecao/umami.git
cd umami
npm install
```

`HOSTNAME` = Your-Dokku-Host-URL (Ex. domain.com or IP of your dokku server)

`PORT` = The port you exposed the database on

`YOUR_DB_PASSWORD` = the password you'll see in your `DATABASE_URL`

* In umami repo that you cloned locally, construct and enter this command to create DB tables

`PGPASSWORD=YOUR_DB_PASSWORD psql -h HOSTNAME -p PORT -U postgres -d umami_postgres -f sql/schema.postgresql.sql`

The default username is `admin` and the default password is `umami`.

* Log in and make sure that you have access to your dashboard
* Unexpose your database: `dokku postgres:unexpose umami-postgres`

## Troubleshooting

* Debug proxy mapping: `dokku nginx:error-logs umami -t`
