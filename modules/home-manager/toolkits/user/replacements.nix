{ config, lib, pkgs, ... }:

{
  # 现代化 Linux 工具配置模块 - 传统工具的现代替代
  home.packages = with pkgs; [
    # 现代文件工具
    lsd                # 现代 ls (彩色、图标)
    bat                # 现代 cat (语法高亮)
    fd                 # 现代 find (更快、更简单)
    ripgrep            # 现代 grep (更快)
    
    # 现代系统工具
    dust               # 现代 du (磁盘使用)
    duf                # 现代 df (磁盘信息)
    procs              # 现代 ps (进程信息)
    
    # 现代网络工具
    dog                # 现代 dig (DNS 查询)
    bandwhich          # 网络使用监控
    
    # 导航增强
    zoxide             # 智能 cd (记录常用目录)
    
    # 搜索增强
    fzf                # 模糊搜索工具
    
    # Git 增强
    delta              # 更好的 git diff
    
    # 终端增强
    starship           # 现代提示符
  ];
  
  # 配置现代工具
  programs = {
    # 现代 ls
    lsd.enable = true;
    
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
