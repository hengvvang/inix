{ config, pkgs, lib, inputs, outputs, users, hosts, ... }:

{
  imports = [
    outputs.home  # 通过 outputs 导入 home 模块
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
    nixpkgs.config.allowUnfree = true;
    home.username = users.user2;
    home.homeDirectory = "/home/${users.user2}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
