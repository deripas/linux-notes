### Config

```bash
sudo chown -R anton:users /etc/nixos
sudo chmod -R u+rwX /etc/nixos

cd /etc/nixos
git clone git@github.com:you/nixos-config.git tmp

mv hardware-configuration.nix tmp/
rm -rf /etc/nixos/*
mv tmp/* /etc/nixos/
```



