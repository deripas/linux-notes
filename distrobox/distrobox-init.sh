#!/usr/bin/env bash
# Записываем stdout и stderr в файл лога
exec > /tmp/distrobox-init.log 2>&1
set -x  # Включаем трассировку каждой выполняемой команды

# Создаем папку для шрифтов пользователя внутри Distrobox
mkdir -p ~/.local/share/fonts

# Проверяем, существует ли уже симлинк, чтобы не плодить дубликаты
if [ ! -L ~/.local/share/fonts/nixos-fonts ]; then
    ln -s /run/host/run/current-system/sw/share/X11/fonts ~/.local/share/fonts/nixos-fonts
fi

# Обновляем кэш шрифтов fontconfig
fc-cache -fv
