{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.toolkits.system.monitor.enable {
    home.packages = with pkgs; [
    htop               # 进程监控
    btop               # 现代系统监控
    iotop              # IO 监控
    nethogs            # 网络监控
    procs              # 现代 ps (进程信息)
    killall            # 批量结束进程
    pstree             # 进程树
    ];
  };
}
