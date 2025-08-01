{ config, lib, pkgs, ... }:

{
    config = lib.mkIf config.mySystem.pkgs.toolkits.enable {
        environment.systemPackages = with pkgs; [
        
        bat  # cat
        
        dysk # df
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
        tealdeer
        tldr

        tree
        broot
        navi

        dust  # du

        gping # ping

        wget
        curl
        httpie
        xh 


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
        iotop             # IO 监控
        nethogs           # 网络监控
        
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
        
        
        # 硬件信息
        lshw              # 硬件信息
        usbutils          # USB 工具
        pciutils          # PCI 工具
        
        # 系统工具
        killall           # 批量结束进程

        
        choose            # 更好的 cut
        sd                # 现代 sed
        jq                # JSON 处理
        yq                # YAML 处理

        
        rsync             # 文件同步
        hexyl             # 十六进制查看器
        
        viu

        ];
    };
}