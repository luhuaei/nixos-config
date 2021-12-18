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
ln -sf `pwd`/direnv /yout/user/path/.config/
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

# nodejs/npm
link `npm link` or `npm install -g` will default create node_modules on
npm bin directory(on `/nix/store`), but on nixos it is a read-only file-system
so must set npm prefix.

see also https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally

```sh
npm config set prefix '~/.npm-global'
```

You all npm global application will store on this directory. You can use `npx prettier`
