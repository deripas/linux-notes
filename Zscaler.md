# VPN Gateway через виртуальную машину (Zscaler → Host)
## Цель

Настроить VPN (на примере Zscaler) внутри виртуальной машины так, чтобы:

VPN работал только в VM

Хостовая система (NixOS) имела доступ к корпоративным ресурсам

Весь обычный интернет на хосте оставался без изменений

Рабочая среда оставалась на хосте

```
[NixOS host]
     |
  10.10.10.0/24 (host-only)
     |
[VM Ubuntu + Zscaler]
     |
  zcctun0
     |
  Corporate Network

```

## Требования

* Виртуальная машина (например Ubuntu)
* Установленный и подключённый Zscaler внутри VM
* Host-only сеть между хостом и VM (пример: 10.10.10.0/24)
* IP VM (пример): 10.10.10.195
* Интерфейс host-only в VM (пример): enp8s0
* VPN-интерфейс (пример): zcctun0

```
ip link show
ip route

```

## Настройка виртуальной машины (VPN-шлюз)
### Включить IP forwarding
```
sudo sysctl -w net.ipv4.ip_forward=1

```
или
```
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-forward.conf
sudo sysctl --system

```

### Настроить NAT через VPN-интерфейс
```
sudo iptables -t nat -A POSTROUTING -o zcctun0 -j MASQUERADE
sudo iptables -A FORWARD -i enp8s0 -o zcctun0 -j ACCEPT
sudo iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
```
Где:
* enp8s0 — host-only интерфейс
* zcctun0 — VPN туннель

### (Опционально) Сохранить iptables
```
sudo apt install iptables-persistent
sudo netfilter-persistent save

```

## Настройка маршрутов на хосте (NixOS)
Добавить маршруты к корпоративным сетям через VM:
```
sudo ip route add 10.0.0.0/8 via 10.10.10.195
sudo ip route add 172.16.0.0/12 via 10.10.10.195

```
Проверить:
```
ip route get 10.61.1.10
```

Ожидаемый результат:
```
10.61.1.10 via 10.10.10.195 dev virbr1
```

## Последовательность после перезагрузки

* Запустить VM
* Подключить Zscaler внутри VM
* Убедиться, что появился zcctun0
* Убедиться, что включён ip_forward
* Проверить/применить iptables
* Убедиться, что маршруты на хосте активны

# Настройка сети
## для NAT (DHCP)
```
sudo nmcli connection add type ethernet ifname enp2s0 con-name nat ipv4.method auto
sudo nmcli connection modify nat connection.autoconnect yes
sudo nmcli connection up nat
```
## host-only через DHCP
```
sudo nmcli connection add type ethernet ifname enp8s0 con-name hostonly ipv4.method auto
sudo nmcli connection modify hostonly connection.autoconnect yes
sudo nmcli connection up hostonly

```
## host-only со статикой
```
sudo nmcli connection add type ethernet ifname enp8s0 con-name hostonly \
  ipv4.method manual \
  ipv4.addresses 10.10.10.195/24
sudo nmcli connection modify hostonly ipv4.gateway ""
sudo nmcli connection modify hostonly connection.autoconnect yes
sudo nmcli connection up hostonly

```
