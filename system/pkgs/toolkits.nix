{ config, lib, pkgs, ... }:

{
    config = lib.mkIf config.mySystem.pkgs.toolkits.enable {
        environment.systemPackages = with pkgs; [
        
        bat               # 更好的 cat (语法高亮)
        eza               # 更好的 ls (彩色、图标)
        fd                # 现代 find (快速文件查找)
        ripgrep           # 现代 grep (rg - 更快搜索)
        
        # 基础文件工具
        tree              # 目录树显示
        fzf               # 模糊查找
        zoxide            # 智能 cd (z - 记录常用目录)
        
        # 基础压缩工具
        unzip             # 解压缩
        zip               # 压缩
        p7zip             # 7zip 支持
        
        # 系统信息
        # neofetch          # 项目停止维护，使用 fastfetch 替代
        fastfetch

        hyperfine         # 基准测试工具
        
        
        # 系统监控
        htop              # 进程监控
        btop              # 现代系统监控
        bottom            # 系统资源监控
        procs             # 现代 ps (进程信息)
        pstree            # 进程树
        iotop             # IO 监控
        nethogs           # 网络监控
        
        dust              # 现代 du (磁盘使用)
        duf               # 现代 df (磁盘信息)
        ncdu              # 磁盘使用分析
        
        # 开发辅助
        watchexec         # 文件监控执行
        tokei             # 代码统计
        
        # 高级网络工具
        dog               # 现代 dig (DNS 查询)
        nmap              # 网络扫描
        tcpdump           # 网络包分析
        iperf3            # 网络性能测试
        bandwhich         # 网络带宽监控
        
        # 数据处理
        visidata          # 表格数据查看器
        
        
        # 硬件信息
        lshw              # 硬件信息
        usbutils          # USB 工具
        pciutils          # PCI 工具
        
        # 系统工具
        killall           # 批量结束进程

        delta             # 更好的 git diff
        
        choose            # 更好的 cut
        sd                # 现代 sed
        jq                # JSON 处理
        yq                # YAML 处理
        tealdeer          # 快速 man 页面 (tldr)
        
        # 网络工具
        wget              # 文件下载
        curl              # HTTP 客户端
        httpie            # 现代 curl
        gping             # 现代 ping
        
        # 文件操作
        rsync             # 文件同步
        hexyl             # 十六进制查看器
        
        ];
    };
}