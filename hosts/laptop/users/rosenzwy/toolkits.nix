{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nh                    # NixOS/Home Manager 助手
    nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
    nix-tree             # 查看 Nix store 依赖关系
    nixos-rebuild        # NixOS 系统重建工具
    nvd                  # Nix 版本差异比较工具

    bat  # cat
    # ls
    eza
    lsd
    zoxide  # cd
    fd  # find
    ripgrep  # grep
    # diff
    difftastic
    delta
    # man
    tealdeer  #tldr
    tree
    broot
    navi
    dust  # du
    gping # ping
    # wget // curl
    httpie
    xh
    hurl
    fzf
    skim
    # top
    htop
    btop
    bottom
    trippy
    unzip
    zip
    p7zip
    # neofetch
    fastfetch
    onefetch
    hyperfine         # 基准测试工具
    procs   # ps
    pstree            # 进程树
    duf
    ncdu
    # 开发辅助
    watchexec         # 文件监控执行
    tokei             # 代码统计
    dog               # 现代 dig (DNS 查询)
    nmap              # 网络扫描
    tcpdump           # 网络包分析
    iperf3            # 网络性能测试
    bandwhich         # 网络带宽监控
    sniffnet          # 网络流量监控
    # 数据处理
    visidata          # 表格数据查看器
    # 系统工具
    killall           # 批量结束进程
    choose            # 更好的 cut
    sd                # 现代 sed
    jq                # JSON 处理
    yq                # YAML 处理
    rsync             # 文件同步
    hexyl             # 十六进制查看器
    viu
    iotop             # IO 监控
    nethogs           # 网络监控
    lshw              # 硬件信息
    usbutils          # USB 工具
    pciutils          # PCI 工具
  ];
}
