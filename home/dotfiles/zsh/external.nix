{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "external") {
    # 方式3: 外部文件引用
    home.file.".zshrc".source = ./configs/zshrc;
  };
}
