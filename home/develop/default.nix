{ config, lib, pkgs, ... }:

{
  options.myHome.develop = {
    enable = lib.mkEnableOption "开发环境支持";
  };

  imports = [
    ./rust
    ./python
    ./javascript
    ./typescript
    ./cpp
    ./devenv
  ];
}
