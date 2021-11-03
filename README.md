# nixos config

# prepare

- clone this repo to your path

- change `/etc/nixos/configuration.nix`
```
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /your/path/nixos-config/configuration.nix
    ];
}
```

- link the `user` to your user `~/.config/nixpkgs`
```
cd nixos-config
ln -sf `pwd`/user /yout/user/path/.config/nixpkgs
```

# add channel
```
sudo nix-channel --add https://github.com/Mic92/envfs/archive/main.tar.gz envfs
sudo nix-channel --add https://nixos.org/channels/nixos-21.05
sudo nix-channel --add https://mirrors.bfsu.edu.cn/nix-channels/nixpkgs-unstable
sudo nix-channel --add https://github.com/luhuaei/touchctrl-go/archive/master.tar.gz touchctrl-go
sudo nix-channel --update
```

# system
```
sudo nixos-rebuild test -j16
```

If working, you can `sudo nixos-rebuild switch` use latest generation for your system.

# user
```
nix-env -iA nixpkgs.myEnv
```
