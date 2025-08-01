{ config, pkgs, lib, inputs, outputs, users, hosts, ... }:

{
  imports = [
    outputs.home  # ../../home
    # 导入不同主机配置
    ./host1.nix
    ./host2.nix
    ./host3.nix
  ];
  
  # 主机选项
  options.host = lib.mkOption {
    type = lib.types.enum [ hosts.host1 hosts.host2 hosts.host3 ];
    default = hosts.host1;
    description = "Host type";
  };
  
  config = {
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
    home.username = users.user1;
    home.homeDirectory = "/home/${users.user1}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    
    # Git 配置
    programs.git = {
      enable = true;
      userName = users.user1;
      userEmail = "${users.user1}@example.com";
    };
  };
}
