{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "external") {
    # 外部文件引用 - 演示用简化配置
    home.file.".gitconfig".source = ./configs/gitconfig;
    # 注意：此方式需要手动维护 configs/ 目录下的配置文件
  };
}
