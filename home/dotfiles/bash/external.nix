{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "external") {
    # 外部文件引用方式配置 Bash
    
    home.file.".bashrc".source = ./configs/bashrc;
    home.file.".bash_profile".source = ./configs/bash_profile;
    
    # 可选：创建符号链接到配置目录
    home.file.".bash_aliases".source = ./configs/bash_aliases;
    home.file.".bash_functions".source = ./configs/bash_functions;
    
  };
}
