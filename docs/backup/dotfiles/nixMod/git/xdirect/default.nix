{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "xdirect") {
    home.packages = lib.optionals config.myHome.dotfiles.git.packageEnable (with pkgs; [ git ]);

    home.file.".gitconfig" = {
      text = builtins.readFile ./configs/gitconfig;
      force = false;  # 不强制覆盖已存在的文件
    };

    home.file.".gitignore" = {
      text = builtins.readFile ./configs/gitignore;
      force = false;
    };
  };
}
