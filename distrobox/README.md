Build image:
```bash
podman build -t localhost/ubuntu:latest .
```

Create distrobox:
```bash
distrobox create \
  --name ubuntu \
  --image localhost/ubuntu:latest \
  --init-hooks "$PWD/distrobox-init.sh" \
  --nvidia \
  --volume /run/user/1000/podman:/run/user/1000/podman \
  --additional-flags "--gpus all --env DOCKER_HOST=unix:///run/user/1000/podman/podman.sock --env VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json --env __NV_PRIME_RENDER_OFFLOAD=1 --env __GLX_VENDOR_LIBRARY_NAME=nvidia"
```

```bash
distrobox create \
  --name ubuntu \
  --image localhost/ubuntu:latest \
  --init-hooks "$PWD/distrobox-init.sh" \
  --nvidia \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --additional-flags "--gpus all --env DOCKER_HOST=unix:///var/run/docker.sock --env VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json --env __NV_PRIME_RENDER_OFFLOAD=1 --env __GLX_VENDOR_LIBRARY_NAME=nvidia"
```
