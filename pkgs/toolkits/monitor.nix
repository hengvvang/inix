{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.toolkits.monitor.enable {
    home.packages = with pkgs; [
      # 进程监控
      htop            # 进程监控
      btop            # 现代系统监控
      procs           # 现代 ps (进程信息)
      pstree          # 进程树
      
      # 系统监控
      iotop           # IO 监控
      nethogs         # 网络监控
      killall         # 批量结束进程
    ];
  };
}
