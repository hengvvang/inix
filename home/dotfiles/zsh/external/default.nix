{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "external") {

    home.packages = with pkgs; [ zsh ];

    # Zsh 官方配置文件结构
    # 环境变量文件（所有 shell 都会读取）
    home.file.".config/zsh/.zshenv".source = ./configs/.zshenv;

    # 登录 shell 配置（在 .zshrc 之前）
    home.file.".config/zsh/.zprofile".source = ./configs/.zprofile;

    # 交互式 shell 配置
    home.file.".config/zsh/.zshrc".source = ./configs/.zshrc;

    # 登录 shell 配置（在 .zshrc 之后）
    home.file.".config/zsh/.zlogin".source = ./configs/.zlogin;

    # 退出时配置
    home.file.".config/zsh/.zlogout".source = ./configs/.zlogout;
  };
}
