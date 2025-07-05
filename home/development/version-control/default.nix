{ config, lib, pkgs, ... }:

{
  options.myHome.development.versionControl.enable = lib.mkEnableOption "版本控制工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.versionControl.enable {
    # 版本控制层默认值：git必需，lazygit推荐
    myHome.development.versionControl = {
      git.enable = lib.mkDefault true;       # Git - 必需
      lazygit.enable = lib.mkDefault true;   # LazyGit - 推荐的图形界面
    };
  };

  imports = [
    ./git.nix
    ./lazygit.nix
  ];
}