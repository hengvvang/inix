{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "external") {
    # 外部文件引用方式配置 Bash
    
    home.file.".bashrc".source = ./configs/bashrc;
    home.file.".bash_profile".source = ./configs/bash_profile;
    
    # 可选：创建符号链接到配置目录
    home.file.".bash_aliases".source = ./configs/bash_aliases;
    home.file.".bash_functions".source = ./configs/bash_functions;
    
    # 确保相关包可用
    home.packages = with pkgs; [
      bash
      bash-completion
      
      # 现代化工具
      bat
      eza
      fd
      ripgrep
      htop
      
      # 基础工具
      coreutils
      findutils
      gnugrep        # 修正：使用 gnugrep 而不是 grep
      gnused         # 修正：使用 gnused 而不是 sed
      gawk
      
      # 压缩工具
      unzip
      p7zip
      
      # 网络工具
      curl
      wget
      
      # 开发工具
      git
      
      # 系统信息
      neofetch
      
      # Starship 提示符
      starship
    ];
  };
}
