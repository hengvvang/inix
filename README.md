##
| Desktop  Environment  |  Description                |                       |                             |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Kde                   |                             |                       |                             |
| Gnome                 |                             |                       |                             |
| Comsic                |                             |                       |                             |

| WM (Compositer)       |  Description                |                       |                             |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Hyprland              |                             |                       |                             |
| Niri                  |                             |                       |                             |

## dotfiles
> ` See everything at home/dotfiles/*`
- direct
  > `For lightweight configurations, I have provided some templates`
- external
  > `The easiest way to configure without having to look at the 'home manager' configuration document`
- homemanager
  > `More in line with the nix philosophy, but relying on community support`

```
                   |---------------------------------------------|
                   | Since I only use a few of these tools,      |
                   | I can't guarantee that they all work        |
                   |_____________________________________________|
```

| Shell                 | direct                      | external              | homemanager                 |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Bash                  |                             |                       |                             |
| Zsh                   |                             |                       |                             |
| Fish                  |                             |                       |                             |
| Nushell               |                             |                       |                             |

| Terminal              | direct                      | external              | homemanager                 |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Alacritty             |                             |                       |                             |
| ghostty               |                             |                       |                             |
| Rio                   |                             |                       |                             |

| Terminal Multiplexer  | direct                      | external              | homemanager                 |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Tmux                  |                             |                       |                             |
| Zellij                |                             |                       |                             |

| Terminal File Manager | direct                      | external              | homemanager                 |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| yazi                  |                             |                       |                             |

| Editor                | direct                      | external              | homemanager                 |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Vim                   |                             |                       |                             |
| Vscode                |                             |                       |                             |
| Zed                   |                             |                       |                             |

| Others                | direct                      | external              | homemanager                 |
|-----------------------|-----------------------------|-----------------------|-----------------------------|
| Rmpc                  |                             |                       |                             |
| Starship              |                             |                       |                             |
| And more ...          |                             |                       |                             |

## Struture

```
                   |---------------------------------------------|
                   |    I use home-manager standalone            |
                   |_____________________________________________|
```
---
`/etc/nixos/configuration.nix`   ==>  `host/<hostName>/defaul.nix`  +  `host/<hostName>/ system.nix`

---
`/etc/nixos/hardware-configuration.nix`  ==>  `host/<hostName>/hardware.nix`  +  `(if you use disko, you will have disk.nix)  -->  host<hostName>/disk.nix`

---
```
------
system/*   --> system configuration options
home/*     --> user configuration options
------
user/*     --> user configurations, each host uses its corresponding configuration file , enable features defined under the home/* directory.
host/*     --> host configurations, hardware information and enable features defined under the system/* directory.
------
pkgs/*            --> custom packages
overlays/*        -->
------
lib               --> my lib
------
```
## How it works ?
```
---
|-------------|      <----      | host/*  `enable features` |    <---       | system/*  `define features`|
|  flake.nix  |      <----      | user/*  `enable features` |    <---       | home/*    `define features`|
|-------------|
---
```

- system
  - desktop
    - cosmic
    - gnome
    - kde
    - hyprland
    - niri
  - locale
    - inputMethod
    - timeZone
  - pkgs
    - apps
    - toolkits
    - workflows
  - profiles
    - fonts
    - stylix
  - services
    - containers
    - drivers
    - media
    - network
- home
  - desktop
    - cosmic
    - gnome
    - kde
    - hyprland
    - niri
  - develop
    - devenv
    - cpp
    - python
    - rust
    - javascript
    - typescript
  dotfiles
    - alacritty
    - bash
    - fish
    - ghostty
    - git
    - lazygit
    - nushell
    - obs-studio
    - qutebrowser
    - rio
    - rmpc
    - rofi
    - starship
    - tmux
    - vim
    - vscode
    - yazi
    - zed
    - zellij
    - zsh
  pkgs
    - apps
    - toolkits
    - workflows
  - profiles
    - fonts
    - stylix
  - services
    - media
- overlays

- pkgs
```
