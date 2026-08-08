# caddy-tailsclae-duckdns

A build of the [caddy-tailscale](https://github.com/tailscale/caddy-tailscale) docker image
 also adding the [caddy-dns/duckdns](https://github.com/caddy-dns/duckdns) module
 to allow completing ACME DNS challenges and getting TLS certs from Duck DNS.

The docker file is adapted from the caddy-tailscale repository,
 although I elected not to keep all of the go code around
 and am instead hoping that xcaddy will result in a working build.

## Config examples

### Duck DNS

The duckdns module should allow adding configuration like this to your Caddyfile:
```
<subdomain>.duckdns.org {
    tls {
        dns duckdns {env.DUCKDNS_TOKEN}
    }
    handle {
        respond "Duck DNS appears to be working!"
    }
}
```
resulting in a static site with working tls at your subdomain.
(This assumes you've already dealt with keeping the DDNS record at Duck DNS up to date,
 and any necessary port forwarding or other hosting concerns)

### Tailscale

The tailscale modules should allow adding configuration like this to your Caddyfile:
```
<subdomain>.<tailnet>.ts.net {
    bind tailscale/<subdomain>
    reverse_proxy localhost:8080
}
```
resulting in whatever you're serving on port 8080 being made available within your tailnet under a new subdomain.
