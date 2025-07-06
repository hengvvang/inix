{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "external") {
    # 方式3: 外部文件引用
    home.file.".gitconfig".source = ./configs/gitconfig;
    home.file.".gitignore_global".source = ./configs/gitignore_global;
  };
}
