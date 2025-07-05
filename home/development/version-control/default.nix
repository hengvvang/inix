{ config, lib, pkgs, ... }:

{
  options.myHome.development.versionControl.enable = lib.mkEnableOption "版本控制工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.versionControl.enable {
    # 设置版本控制工具的默认值
    myHome.development.versionControl = {
      git.enable = lib.mkDefault true;
      lazygit.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./git.nix
    ./lazygit.nix
  ];
}