{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    outputs.home  # ../../home
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
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
    home.username = "hengvvang";
    home.homeDirectory = "/home/hengvvang";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
