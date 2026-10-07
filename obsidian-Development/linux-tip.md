Create many folders at the same time
```
$ mkdir -p ~/zitadel/{letsencrypt,postgres,zitadel-bootstrap}
```

Generating X-character random alphanumeric string
```
tr -dc A-Za-z0-9 </dev/urandom | head -c 32 <<32 -> THE OUTPUT SIZE>>
```