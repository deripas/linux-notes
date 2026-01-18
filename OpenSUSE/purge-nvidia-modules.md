# Purge NVIDIA modules (workaround)
На openSUSE замечена проблема с удалением неиспользуемых модулей, например команда:
```bash
find /lib/modules/*/updates/nvidia.ko
```
 выдвет список 
 ```
 /lib/modules/6.15.0-1-default/updates/nvidia.ko 
 /lib/modules/6.15.1-1-default/updates/nvidia.ko 
 /lib/modules/6.15.3-1-default/updates/nvidia.ko 
 /lib/modules/6.15.3-2-default/updates/nvidia.ko 
 /lib/modules/6.15.4-1-default/updates/nvidia.ko 
 /lib/modules/6.15.5-1-default/updates/nvidia.ko 
 /lib/modules/6.15.7-1-default/updates/nvidia.ko 
 /lib/modules/6.15.8-1-default/updates/nvidia.ko 
 /lib/modules/6.16.1-1-default/updates/nvidia.ko 
 /lib/modules/6.16.3-1-default/updates/nvidia.ko
```
При этом в системе только две версии ядра `6.16.1-1` и `6.16.3-1`. 

### purge-nvidia-modules.sh
```bash
nano ~/.local/bin/purge-nvidia-modules.sh
```

```bash
#!/bin/bash
set -e

MODULES_DIR="/lib/modules"

# Получаем список установленных версий ядер из /boot
installed_kernels=$(ls /boot/vmlinuz-* | sed -E 's/.*vmlinuz-//')

# Список директорий на удаление
to_delete=()

current=$(uname -r)

echo "Resolving NVIDIA modules..."
for nvidia_ko in $(find "$MODULES_DIR" -type f -path "*/updates/nvidia*.ko" -printf '%h\n' | sort -u); do
    kver=$(echo "$nvidia_ko" | sed -E "s|$MODULES_DIR/([^/]+)/.*|\1|")

    if [[ "$kver" == "$current" ]]; then
        echo "$kver - (running, skip)"
        continue
    fi

    if ! grep -qx "$kver" <<< "$installed_kernels"; then
        to_delete+=("$MODULES_DIR/$kver")
        echo "$kver - (removed)"
    else
        echo "$kver - (installed)"
    fi
done

if [ ${#to_delete[@]} -eq 0 ]; then
    echo "Nothing to do."
    exit 0
fi

echo
echo "Directories to delete:"
for dir in "${to_delete[@]}"; do
    echo "$dir"
done

read -rp "Delete these directories? (y/N): " ans
if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
    for dir in "${to_delete[@]}"; do
        echo "Removing $dir"
        sudo rm -rf "$dir"
    done
    echo "Done."
else
    echo "Canceled."
fi

```
