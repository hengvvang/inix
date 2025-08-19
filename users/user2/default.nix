{ config, pkgs, lib,    home.username = userMapping.user2;
    home.homeDirectory = "/home/${userMapping.user2}";
    home.stateVersion = "24.05";puts, outputs, userMapping, hostMapping, hostInstance, ... }:

{
  imports = [
    outputs.home  # 通过 outputs 导入 home 模块
    # 导入不同主机配置
    ./host1.nix
    ./host2.nix
    ./host3.nix
  ];

  # 主机选项
  options.hostInstance = lib.mkOption {
    type = lib.types.enum [ hostMapping.host1 hostMapping.host2 hostMapping.host3 ];
    default = hostMapping.host1;
    description = "Host instance type";
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    home.username = users.user2;
    home.homeDirectory = "/home/${users.user2}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
