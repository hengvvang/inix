{ config, pkgs, lib, inputs, outputs, userVars, ... }:

{
  imports = [
    outputs.home  # 通过 outputs 导入 home 模块
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
    home.username = userVars.userName.zlritsu;
    home.homeDirectory = "/home/${userVars.userName.zlritsu}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
