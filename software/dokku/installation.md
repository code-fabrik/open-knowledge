# Dokku - Installation

At many hosters, images containing a full Ubuntu installation including Docker
and Dokku can be installed with a single click. This method is very easy and
saves a lot of time.

Sometimes the image of the one click install contains and old version of Dokku
or is not available at all. The following instructions describe how to install
the latest version of Dokku on an Ubuntu (and possibly Debian) host.

## Preparation

Install lazydocker: `curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash`

Download the Dokku installer: `wget https://raw.githubusercontent.com/dokku/dokku/v0.21.4/bootstrap.sh`

Install Dokku: `sudo DOKKU_TAG=v0.21.4 bash bootstrap.sh`

Update Dokku: `sudo apt install -qq -y dokku herokuish sshcommand plugn gliderlabs-sigil`

Update the operating system: `sudo apt upgrade`

Reboot the host: `sudo reboot`

## Installation

Open the IP or domain name of your host in your browser, change the hostname
and enable the `virtualhost naming` option. Save the form and you're ready to
go.

## Plugins

There are a few convenient plugins that can be installed and are used most of
the time:

```bash
sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
sudo dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
sudo dokku plugin:install https://github.com/dokku/dokku-redis.git redis
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
```
