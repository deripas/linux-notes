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

```bash
distrobox create \                                             
  --name ubuntu \
  --image localhost/ubuntu:latest \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --additional-flags "--env DOCKER_HOST=unix:///var/run/docker.sock --gpus all --env VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json --env __NV_PRIME_RENDER_OFFLOAD=1 --env __GLX_VENDOR_LIBRARY_NAME=nvidia" --nvidia
```
