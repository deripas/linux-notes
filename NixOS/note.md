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


###zsh
```bash
nano ~/.zshrc
```

```
# Powerlevel10k
source /run/current-system/sw/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# basic
export EDITOR=vim
```

```bash
p10k configure
```
