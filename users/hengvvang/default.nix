{ config, pkgs, lib, inputs, outputs, userVars, ... }:

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
    home.username = userVars.userName.hengvvang;
    home.homeDirectory = "/home/${userVars.userName.hengvvang}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    
    # Git 配置
    programs.git = {
      enable = true;
      userName = userVars.userName.hengvvang;
      userEmail = "${userVars.userName.hengvvang}@example.com";
    };
  };
}
