# Docker Image Deploys - Troubleshooting

This page lists errors that may occur and their solution when doing e Docker
image deploy.

## Nginx connection refused

The following error message might appear in the Nginx error log
(`dokku nginx:error-logs umami -t`):

    2020/10/07 12:58:05 [error] 73951#73951: *1 connect() failed (111: Connection refused) while connecting to upstream, client: 51.154.113.216, server: umami.code-fabrik.ch, request: "GET / HTTP/1.1", upstream: "http://172.17.0.3:5000/", host: "umami.code-fabrik.ch"

This means that either the app hasn't started, or Nginx is directing the
traffic towards the wrong container port. You can fix this by modifying the
proxy mapping with `dokku proxy:ports-add umami http:80:3000` and changing
the container port number.
