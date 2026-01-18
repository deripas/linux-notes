
В OpenSUSE по умолчанию функция переадресации пакетов не активирована из соображений безопасности.

Включить с помощью yast:
```bash
sudo yast routing ip-forwarding on
```
Для проверки выполнить
```bash
 cat /etc/sysctl.d/70-yast.conf
```
```
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.all.disable_ipv6 = 1
```

Или включить вручную
```bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
```
