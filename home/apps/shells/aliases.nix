{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.aliases.enable = lib.mkEnableOption "Shell 别名配置";

  config = lib.mkIf config.myHome.apps.shells.aliases.enable {
  # 通用 Shell 别名配置 - 所有 Shell 共享的别名
  home.shellAliases = {
    # 现代化工具替代
    ls = "lsd";
    ll = "lsd -l";
    la = "lsd -la";
    tree = "lsd --tree";
    cat = "bat";
    grep = "rg";
    find = "fd";
    du = "dust";
    df = "duf";
    ps = "procs";
    top = "btop";
    htop = "btop";
    
    # 网络工具
    ping = "gping";
    dig = "dog";
    http = "xh";
    curl = "xh";
    
    # Git 快捷命令 (基础)
    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gl = "git pull";
    gd = "git diff";
    gb = "git branch";
    gco = "git checkout";
    
    # Git 增强命令
    gdiff = "git diff | delta";
    glog = "git log --oneline --graph --decorate";
    gstat = "git log --stat";
    
    # 目录导航
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    cd = "z";  # 使用 zoxide
    
    
    # 系统信息
    sysinfo = "neofetch";
    meminfo = "free -h";
    diskinfo = "duf";
    netinfo = "bandwhich";
    
    # 开发工具
    serve = "python3 -m http.server 8000";  # 快速启动 HTTP 服务器
    myip = "curl -s https://httpbin.org/ip | jq -r .origin";
    
    # 文件操作
    mkdir = "mkdir -pv";  # 自动创建父目录并显示过程
    cp = "cp -iv";        # 交互式复制
    mv = "mv -iv";        # 交互式移动
    rm = "rm -iv";        # 交互式删除
    
    # 压缩工具
    compress = "ouch compress";
    decompress = "ouch decompress";
    extract = "ouch decompress";
    
    # 文档查看
    md = "glow";
    help = "tldr";
    man = "batman";  # 如果安装了 bat-extras
    
    # 容器工具
    dps = "docker ps --format 'table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}'";
    dimg = "docker images --format 'table {{.Repository}}\\t{{.Tag}}\\t{{.Size}}'";
    dlog = "docker logs -f";
    
    # 开发环境
    dev = "dev-info";
    project = "create-project";
    
    # 快速编辑配置文件
    nixconfig = "cd ~/.config/nixos && $EDITOR .";
    homeconfig = "cd ~/.config/home-manager && $EDITOR .";
    
    # 系统管理
    nixos-rebuild = "sudo nixos-rebuild switch --flake .";
    home-rebuild = "home-manager switch --flake .";
    nix-clean = "nix-collect-garbage -d && nix store optimise";
    
    # 性能测试
    benchmark = "hyperfine";
    speedtest = "fast";  # 如果安装了 fast-cli
    
    # 安全工具
    genpass = "openssl rand -base64 32";
    
    # 时间和日期
    now = "date '+%Y-%m-%d %H:%M:%S'";
    timestamp = "date +%s";
    
    # 清理命令
    clear = "clear && echo '🚀 Ready for action!'";
    
    # 快速搜索
    search = "rg --hidden --follow --smart-case";
    
    # JSON 处理
    json = "jq .";
    yaml = "yq .";
  };
  };
}
