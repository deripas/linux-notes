
### CPU governor + scheduler
```bash
sudo zypper install cpupower
sudo systemctl enable --now cpupower
```

/etc/sysconfig/cpupower:
```ini
CPUPOWER_START_OPTS="frequency-set -g performance"
```

### udev rules для CPU latency

```bash
sudo zypper install tuned
sudo systemctl enable --now tuned
sudo tuned-adm profile latency-performance
```

### Vulkan
Для DXVK (DX9/10/11)
```
DXVK_ASYNC=1
DXVK_FRAME_RATE=0
DXVK_STATE_CACHE=1
```

Для vkd3d (DX12)
```
VKD3D_CONFIG=force_static_cbv
```

### Transparent Huge Pages (THP)
Для игр лучше:
```bash
echo always | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
```
Улучшает DXVK cache locality
