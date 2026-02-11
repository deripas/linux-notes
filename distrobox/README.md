Build image:
```bash
podman build -t ubuntu-dev:24.04 .
```

Create distrobox:
```bash
distrobox create \
  --name ubuntu \
  --image localhost/ubuntu-dev:24.04 \
  --home ~/.distrobox/ubuntu \
  --nvidia \
  --volume /run/user/1000/podman:/run/user/1000/podman \
  --additional-flags "--env DOCKER_HOST=unix:///run/user/1000/podman/podman.sock"
```
