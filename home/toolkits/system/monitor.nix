{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.toolkits.system.monitor {
    home.packages = with pkgs; [
    htop               # 进程监控
    btop               # 现代系统监控
    iotop              # IO 监控
    nethogs            # 网络监控
    procs              # 现代 ps (进程信息)
    killall            # 批量结束进程
    pstree             # 进程树
  ];
  
  # 系统管理别名
  home.shellAliases = {
    # 进程管理
    psa = "ps aux";
    psg = "ps aux | grep";
    
    # 文件操作
    ll = lib.mkDefault "ls -la";
    la = lib.mkDefault "ls -la";
    tree = lib.mkDefault "tree -C";
  
    # 系统服务
    systat = "systemctl status";
    systart = "systemctl start";
    systop = "systemctl stop";
    syrestart = "systemctl restart";
    syenable = "systemctl enable";
    sydisable = "systemctl disable";
    
    # 日志查看
    log = "journalctl -xe";
    logf = "journalctl -f";
    
    # 权限和用户
    chownme = "sudo chown $USER:$USER";
    
    # 快速编辑重要文件
    hosts = "sudo $EDITOR /etc/hosts";
    
    # 清理
    cleanup = "sudo journalctl --vacuum-time=3d && nix-collect-garbage -d";
  };
  };
}
