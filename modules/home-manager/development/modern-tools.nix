{ config, lib, pkgs, ... }:

{
  # 现代化 Linux 开发工具
  home.packages = with pkgs; [
    # 现代化系统监控工具
    btop                    # 现代化的 top/htop 替代品
    bottom                  # 另一个现代系统监控工具
    dust                    # 现代化的 du 替代品
    duf                     # 现代化的 df 替代品
    procs                   # 现代化的 ps 替代品
    
    # 网络工具
    bandwhich               # 网络使用监控
    dog                     # 现代化的 dig 替代品
    gping                   # 图形化 ping 工具
    httpie                  # 现代化的 curl 替代品
    xh                      # 更快的 httpie 替代品
    
    # 文件和目录工具
    lsd                     # 现代化的 ls 替代品 (LSDeluxe)
    zoxide                  # 智能 cd 替代品
    broot                   # 交互式目录导航
    ranger                  # 终端文件管理器
    nnn                     # 轻量级文件管理器
    
    # 文本处理工具
    sd                      # 现代化的 sed 替代品
    choose                  # 现代化的 cut 替代品
    jq                      # JSON 处理工具
    yq                      # YAML 处理工具
    htmlq                   # HTML 处理工具
    
    # 开发辅助工具
    hyperfine               # 命令行基准测试工具
    tokei                   # 代码统计工具
    cloc                    # 经典代码统计工具
    
    # 版本控制增强
    delta                   # 更好的 git diff 查看器
    gh                      # GitHub CLI
    git-absorb              # 自动修复 git commits
    git-interactive-rebase-tool # 交互式 rebase 工具
    
    # 终端增强工具
    starship                # 现代化提示符
    zellij                  # 现代化终端复用器
    tmux                    # 经典终端复用器
    
    # 搜索和导航
    fzf                     # 模糊搜索
    skim                    # Rust 实现的 fzf 替代品
    mcfly                   # 智能命令历史搜索
    
    # 进程管理
    pueue                   # 任务队列管理器
    
    # 安全工具
    age                     # 现代文件加密工具
    sops                    # 密钥管理工具
    
    # 容器和虚拟化工具
    dive                    # Docker 镜像分析工具
    ctop                    # 容器监控工具
    lazydocker              # Docker 终端界面
    
    # 数据库工具
    usql                    # 通用 SQL 客户端
    
    # API 和 Web 开发
    grpcurl                 # gRPC 测试工具
    evans                   # gRPC 客户端
    
    # 系统分析工具
    strace                  # 系统调用跟踪
    ltrace                  # 库调用跟踪
    lsof                    # 查看打开文件
    
    # 性能分析
    perf-tools              # 性能分析工具集
    flamegraph              # 火焰图生成工具
    
    # 现代化编辑器和 IDE
    neovim                  # 现代化 Vim
    
    # 密码管理
    pass                    # Unix 密码管理器
    
    # 系统信息
    neofetch                # 系统信息显示
    pfetch                  # 轻量级系统信息
    
    # 磁盘和文件分析
    ncdu                    # 磁盘使用分析
    
    # 网络扫描和分析
    nmap                    # 网络扫描工具
    masscan                 # 高速端口扫描器
    
    # 调试工具
    gdb                     # GNU 调试器
    lldb                    # LLVM 调试器
    rr                      # 记录和重放调试器
    
    # 内存分析
    valgrind                # 内存分析工具
    
    # 现代化 shell 工具
    nushell                 # 现代化 shell
    
    # 图像和媒体工具
    imagemagick             # 图像处理工具
    ffmpeg                  # 多媒体处理工具
    
    # 文档工具
    mdcat                   # Markdown 查看器
    glow                    # Markdown 渲染器
    
    # 压缩工具
    ouch                    # 现代化压缩工具
    
    # 时间和日程
    calcurse                # 终端日历
    
    # 其他实用工具
    tealdeer                # tldr 的 Rust 实现
    
    # 字体 (开发必备)
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.sauce-code-pro
  ];

  # 现代化工具配置
  programs = {
    # Starship 提示符配置
    starship = {
      enable = true;
      settings = {
        # 提示符格式
        format = "$all$character";
        
        # 字符配置
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        
        # Git 状态
        git_status = {
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
        };
        
        # 目录显示
        directory = {
          truncation_length = 3;
          fish_style_pwd_dir_length = 1;
        };
        
        # 语言版本显示
        rust.symbol = "🦀 ";
        python.symbol = "🐍 ";
        nodejs.symbol = "⬢ ";
        c.symbol = "C ";
        cpp.symbol = "C++ ";
      };
    };

    # Zoxide 智能 cd
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    # 现代化 ls 配置
    lsd = {
      enable = true;
      enableFishIntegration = false;  # 禁用 Fish 集成别名
      enableZshIntegration = false;   # 禁用 Zsh 集成别名  
      enableBashIntegration = false;  # 禁用 Bash 集成别名
      settings = {
        color = {
          when = "auto";
        };
        date = "+%Y-%m-%d %H:%M";
        dereference = false;
        display = {
          show_hidden = false;
          show_symlink_target = true;
        };
        icons = {
          when = "auto";
          theme = "fancy";
        };
        layout = "grid";
        recursion = {
          enabled = false;
          depth = 3;
        };
        size = "default";
        sorting = {
          column = "name";
          reverse = false;
          dir_grouping = "first";
        };
        no_symlink = false;
        total_size = false;
        symlink_arrow = "⇒";
      };
    };

    # 现代化 cat 配置
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        style = "numbers,changes,header";
        pager = "less -FR";
        map-syntax = [
          "*.jenkinsfile:Groovy"
          "*.props:Java Properties"
        ];
      };
    };
  };

  # 现代化工具别名
  home.shellAliases = {
    # 现代化替代工具
    ls = "lsd";
    ll = "lsd -l";
    la = "lsd -la";
    tree = "lsd --tree";
    du = "dust";
    df = "duf";
    ps = "procs";
    top = "btop";
    htop = "btop";
    
    # 网络工具
    ping = "gping";
    dig = "dog";
    http = "xh";
    
    # 文本处理
    sed = "sd";
    
    # Git 增强
    gdiff = "git diff | delta";
    glog = "git log --oneline --graph --decorate";
    
    # 容器工具
    dps = "docker ps --format 'table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}'";
    
    # 开发工具
    benchmark = "hyperfine";
    count = "tokei";
    
    # 系统监控
    net = "bandwhich";
    
    # 文件管理
    cd = "z";  # 使用 zoxide
    
    # 压缩工具
    compress = "ouch compress";
    decompress = "ouch decompress";
    
    # 文档查看
    md = "glow";
    
    # 帮助工具
    help = "tldr";
    
    # 密码管理
    pwgen = "openssl rand -base64 32";
    
    # 系统信息
    sysinfo = "neofetch";
    
    # 进程管理
    pgrep = "procs";
    
    # 内存使用
    free = "free -h";
    
    # 磁盘使用
    disk = "ncdu";
  };

  # 环境变量
  home.sessionVariables = {
    # 现代化工具配置
    BAT_THEME = "TwoDark";
    FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
    FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
    
    # Delta (git diff) 配置
    DELTA_PAGER = "less -R";
    
    # 其他工具配置
    PAGER = "bat";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  # 创建开发环境信息脚本
  home.file.".local/bin/dev-info".text = ''
    #!/bin/bash
    # 开发环境信息查看脚本
    
    echo "🚀 开发环境信息"
    echo "================="
    
    echo "📊 系统信息:"
    neofetch --off
    
    echo "💾 磁盘使用:"
    duf
    
    echo "🏃 运行中的容器:"
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" 2>/dev/null || echo "Docker 未运行"
    
    echo "🦀 Rust 工具链:"
    rustc --version
    cargo --version
    
    echo "🐍 Python 版本:"
    python3 --version
    
    echo "⬢ Node.js 版本:"
    node --version
    npm --version
    
    echo "🔧 C/C++ 工具链:"
    gcc --version | head -1
    g++ --version | head -1
    
    echo "✅ 开发环境检查完成!"
  '';
}
