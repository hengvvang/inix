{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home
    # 导入不同主机配置
    ./laptop.nix
    ./daily.nix
    ./work.nix
  ];
  
  # 主机选项
  options.host = lib.mkOption {
    type = lib.types.enum [ "laptop" "daily" "work" ];
    default = "laptop";
    description = "Host type";
  };
  
  config = {
    nixpkgs.config.allowUnfree = true;
    home.username = "zlritsu";
    home.homeDirectory = "/home/zlritsu";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
