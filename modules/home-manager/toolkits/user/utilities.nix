{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    unzip
    zip
    p7zip
    jq            # JSON 处理
    yq            # YAML 处理
    bat           # 更好的 cat
    eza           # 更好的 ls
    lsd                # 现代 ls (彩色、图标)
    bat                # 现代 cat (语法高亮)
    ripgrep            # 现代 grep (更快)
    tree          # 目录树显示
    fd            # 快速文件查找
    rsync         # 文件同步
    zoxide             # 智能 cd (记录常用目录)
    fzf                # 模糊搜索工具
    delta              # 更好的 git diff
    starship           # 现代提示符
  ];
  
  # 配置现代工具
  programs = {
    # 现代 ls
    lsd = {
      enable = true;
      enableBashIntegration = false;  # 禁用 bash 别名
      enableZshIntegration = false;   # 禁用 zsh 别名
      enableFishIntegration = false;  # 禁用 fish 别名
    };
    
    # 现代 cat
    bat.enable = true;
    
    # 智能 cd
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    
    # 现代提示符
    starship.enable = true;
    
    # 模糊搜索
    fzf = {
      enable = true;
      defaultCommand = "fd --type f";
    };
  };
  
  # 现代工具别名 (覆盖传统命令)
  home.shellAliases = {
    # 文件操作现代化
    ls = "lsd";
    ll = "lsd -l";
    la = "lsd -la";
    cat = "bat";
    find = "fd";
    grep = "rg";
    
    # 系统信息现代化
    du = "dust";
    df = "duf";
    ps = "procs";
    
    # 网络工具现代化
    dig = "dog";
    
    # 导航增强
    cd = "z";  # 使用 zoxide
    
    # Git 增强
    diff = "delta";
  };
}
