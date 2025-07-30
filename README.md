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

- system
  - desktop
  - locale
  - pkgs
  - profiles
  - services
- home
  - desktop
  - develop
  - dotfiles
  - pkgs
  - profiles
  - services

```
---
```

- host
  - desktop
  - laptop
  - vps
  - macos
- users
  - user1
  - user2

```
---
```
- lib
- overlays
- pkgs
```
