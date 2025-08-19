{ config, pkgs, lib, inputs, outputs, userMapping, hostMapping, hostInstance, ... }:

{
  imports = [
    outputs.home  # ../../home
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
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
    home.username = userMapping.user1;
    home.homeDirectory = "/home/${userMapping.user1}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
