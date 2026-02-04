
```bash
podman build -t ubuntu-dev:24.04 .

distrobox create --name ubuntu --image localhost/ubuntu-dev:24.04 --home ~/.distrobox/ubuntu --nvidia

```
