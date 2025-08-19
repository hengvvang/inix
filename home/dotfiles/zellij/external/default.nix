{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "external") {

    home.packages = lib.optionals config.myHome.dotfiles.zellij.packageEnable (with pkgs; [
      zellij
      wl-clipboard
    ]);

    # 配置文件 - 主配置
    home.file.".config/zellij/config.kdl".source = ./configs/config.kdl;

    # 布局文件目录
    home.file.".config/zellij/layouts".source = ./configs/layouts;

    # 主题文件目录
    home.file.".config/zellij/themes".source = ./configs/themes;

    # Fish Shell 集成
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
    '';

    # Bash 集成
    programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
    '';
  };
}
