{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.system.enable = lib.mkEnableOption "系统工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.system.enable {
    # 系统工具层默认值：基础工具开启，其他按需
    myHome.toolkits.system = {
      utilities.enable = lib.mkDefault true;   # 系统实用工具 - 基础
      hardware.enable = lib.mkDefault false;   # 硬件监控 - 可选
      network.enable = lib.mkDefault true;     # 网络工具 - 常用
      monitor.enable = lib.mkDefault false;    # 监控工具 - 可选
    };
  };

  imports = [
    ./utilities.nix
    ./hardware.nix
    ./network.nix
    ./monitor.nix
  ];
}