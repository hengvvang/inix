{ config, lib, pkgs, ... }:

{
  # 虚拟网络接口模块 - 选项定义
  options.mySystem.services.network.virtualInterface = {
    enable = lib.mkEnableOption "虚拟网络接口支持 (TUN/TAP)";
    
    # TUN/TAP 接口配置
    tun = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "启用 TUN 接口支持";
    };
    
    tap = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "启用 TAP 接口支持";
    };
    
    # 网络转发配置
    forwarding = {
      ipv4 = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "启用 IPv4 转发";
      };
      
      ipv6 = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "启用 IPv6 转发";
      };
    };
    
    # 网络工具配置
    tools = {
      basic = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "安装基础网络工具 (iproute2, iptables)";
      };
      
      bridge = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "安装网桥工具 (bridge-utils)";
      };
    };
  };

  imports = [
    ./virtualInterface.nix
  ];
}
