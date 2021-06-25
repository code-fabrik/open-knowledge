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

## Set the env variables

* `dokku config:set renovate [...]` an use the values above as described in [the documentation](https://docs.renovatebot.com/self-hosted-configuration)

## Deploy the image

Run `dokku git:from-image renovate renovate/renovate:latest`

## Run at specific interval

To run Renovate at a specific interval, add a cron task to the hosts crontab, for example every 10 minutes:

```cron
*/10 * * * * dokku dokku ps:restart renovate
```
