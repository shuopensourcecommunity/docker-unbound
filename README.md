# docker-unbound
Unbound + Dnscrypt Dockerlize

## Features
- Unbound + dnscrypt multiple anti-pollution
- Provide China Site CDN domain name resolution
- Provide custom domain name resolution

## Usage
- Install
```bash
docker-compose up -d
```

- Custom domain
    - change the content in `1.bd.lab.conf` or make a new conf file.
    - custom domain conf filename must be sorted in the front of  `accelerated-domains.china.unbound.conf`, or `unbound` will think the conf error.
    - If you have change the content in `1.bd.lab.conf`, you have to restart the container to enable the change.

- Screenshot

![dig result](https://vgy.me/eiW22s.png)