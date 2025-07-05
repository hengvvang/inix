{ config, lib, pkgs, ... }:

{
  # Linux 系统工具配置模块 - 日常使用和管理
  home.packages = with pkgs; [
    # 系统监控
    htop               # 进程监控
    btop               # 现代系统监控
    iotop              # IO 监控
    nethogs            # 网络监控
    neofetch           # 系统信息显示
    lshw               # 硬件信息
    usbutils           # USB 工具
    pciutils           # PCI 工具
    dust               # 现代 du (磁盘使用)
    duf                # 现代 df (磁盘信息)
    procs              # 现代 ps (进程信息)
    ncdu               # 磁盘使用分析
    killall            # 批量结束进程
    pstree             # 进程树
    # 网络工具
    wget               # 文件下载
    curl               # HTTP 客户端
    nmap               # 网络扫描
    iperf3             # 网络性能测试
    tcpdump            # 网络包分析
    dog                # 现代 dig (DNS 查询)
    bandwhich          # 网络使用监控
    # 安全工具
    gnupg              # GPG 加密
    openssh            # SSH 客户端
  ];
  
  # 系统管理别名
  home.shellAliases = {
    # 系统信息
    sysinfo = "neofetch";
    hardware = "lshw -short";
    cpu = "lscpu";
    mem = "free -h";
    disk = "df -h";
    
    # 进程管理
    psa = "ps aux";
    psg = "ps aux | grep";
    
    # 网络
    ports = "netstat -tuln";
    listen = "netstat -tuln | grep LISTEN";
    myip = "curl -s https://httpbin.org/ip | jq -r .origin";
    
    # 文件操作
    ll = lib.mkDefault "ls -la";
    la = lib.mkDefault "ls -la";
    tree = lib.mkDefault "tree -C";
    
    # 磁盘使用
    du1 = "du -h --max-depth=1";
    dush = "du -sh";
    
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
}
