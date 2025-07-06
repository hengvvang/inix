{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.dotfiles.fish.enable {
    # 方式3: 外部文件引用
    home.file.".config/fish/config.fish".source = ./configs/config.fish;
    home.file.".config/fish/functions/mkcd.fish".source = ./configs/functions/mkcd.fish;
    home.file.".config/fish/functions/extract.fish".source = ./configs/functions/extract.fish;
  };
}
