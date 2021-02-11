# Renovate

To get started with Umami, read the
[instructions on Github](https://github.com/renovatebot/renovate/blob/master/docs/usage/self-hosting.md#docker).

It states the following:

* Renovate has a docker image at https://hub.docker.com/r/renovate/renovate/
* It reads the Bitbucket App-Passwort from RENOVATE_PASSWORD
* It reads the Bitbucket username from RENOVATE_USERNAME
* It reads the platform from RENOVATE_PLATFORM
* It reads the repo list from RENOVATE_REPOSITORIES

## Create a renovate user and an app password

* Create a new user on Bitbucket named something like `renovate`
* Create an app password. The required permissions are: pull_request:write, issue:write and repository:write

## Preparing dokku and the image

* Create a dokku app: `dokku apps:create renovate`
* Pull the Docker image: `docker pull renovate/renovate:latest`
* Retag the Docker image to match the app: `docker tag renovate/renovate:latest dokku/renovate:latest`

## Set the env variables

* `dokku config:set renovate [...]` an use the values above as described in [the documentation](https://docs.renovatebot.com/self-hosted-configuration)

## Deploy the image

`dokku tags:deploy renovate latest`
