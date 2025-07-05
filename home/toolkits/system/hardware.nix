{ config, lib, pkgs, ... }:

{
  options = {
    myHome.toolkits.system.hardware.enable = lib.mkEnableOption "系统硬件工具";
  };

  config = lib.mkIf config.myHome.toolkits.system.hardware.enable {
    home.packages = with pkgs; [
    neofetch           # 系统信息显示
    lshw               # 硬件信息
    usbutils           # USB 工具
    pciutils           # PCI 工具
    dust               # 现代 du (磁盘使用)
    duf                # 现代 df (磁盘信息)
    ncdu               # 磁盘使用分析
  ];
  
  # 系统管理别名
  home.shellAliases = {
    # 系统信息
    sysinfo = "neofetch";
    hardware = "lshw -short";
    cpu = "lscpu";
    mem = "free -h";
    disk = "df -h";
    
    # 磁盘使用
    du1 = "du -h --max-depth=1";
    dush = "du -sh";
  };
  };
}
