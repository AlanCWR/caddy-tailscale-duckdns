FROM caddy:2.11.4-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/tailscale/caddy-tailscale \
    --with github.com/caddy-dns/duckdns


# FROM caddy:<version>

# COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# From https://github.com/caddyserver/caddy-docker/blob/master/2.10/alpine/Dockerfile
FROM alpine:3.21

RUN mkdir -p \
  /config/caddy \
  /data/caddy \
  /etc/caddy \
  /usr/share/caddy

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY examples/simple.caddyfile /etc/caddy/Caddyfile

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

EXPOSE 80
EXPOSE 443
EXPOSE 443/udp
EXPOSE 2019

WORKDIR /srv

CMD ["run", "--config", "/etc/caddy/Caddyfile"]
ENTRYPOINT ["caddy"]
