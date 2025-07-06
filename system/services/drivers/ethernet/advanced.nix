{ config, lib, pkgs, ... }:

{
  # 以太网高级功能实现
  config = lib.mkMerge [
    # 网络唤醒功能
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.advanced.wakeonlan) {
      environment.systemPackages = with pkgs; [
        ethtool           # WOL 配置
        wakeonlan         # WOL 发送工具
      ];
      
      # WOL 配置脚本
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "setup-wol" ''
          #!/bin/bash
          echo "配置网络唤醒..."
          
          for iface in $(ls /sys/class/net/ | grep -E '^(eth|eno|enp)'); do
            if [ -d "/sys/class/net/$iface" ]; then
              echo "为 $iface 启用 WOL..."
              ethtool -s "$iface" wol g 2>/dev/null || true
            fi
          done
          
          echo "WOL 配置完成"
        '')
      ];
    })
    
    # 网卡绑定支持
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.advanced.bonding) {
      boot.kernelModules = [ "bonding" ];
      
      environment.systemPackages = with pkgs; [
        ifenslave         # 绑定工具
      ];
      
      # 绑定配置示例
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "setup-bonding" ''
          #!/bin/bash
          echo "网卡绑定配置示例:"
          echo "请手动编辑 NixOS 配置文件添加以下内容:"
          echo ""
          echo "networking.bonds.bond0 = {"
          echo "  interfaces = [ \"eth0\" \"eth1\" ];"
          echo "  driverOptions = {"
          echo "    mode = \"802.3ad\";"
          echo "    xmit_hash_policy = \"layer3+4\";"
          echo "  };"
          echo "};"
        '')
      ];
    })
    
    # VLAN 支持
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.advanced.vlan) {
      boot.kernelModules = [ "8021q" ];
      
      environment.systemPackages = with pkgs; [
        vlan              # VLAN 工具
      ];
      
      # VLAN 配置脚本
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "setup-vlan" ''
          #!/bin/bash
          if [ $# -lt 3 ]; then
            echo "用法: setup-vlan <接口> <VLAN ID> <IP地址>"
            echo "示例: setup-vlan eth0 100 192.168.100.10/24"
            exit 1
          fi
          
          INTERFACE="$1"
          VLAN_ID="$2"
          IP_ADDR="$3"
          VLAN_IF="$INTERFACE.$VLAN_ID"
          
          echo "创建 VLAN 接口: $VLAN_IF"
          ip link add link "$INTERFACE" name "$VLAN_IF" type vlan id "$VLAN_ID"
          ip addr add "$IP_ADDR" dev "$VLAN_IF"
          ip link set dev "$VLAN_IF" up
          
          echo "VLAN 接口 $VLAN_IF 已创建"
        '')
      ];
    })
  ];
}
