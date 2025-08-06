# Sherlock Launcher - XDirect Configuration Mode
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "xdirect") {

    # 使用 builtins.readFile 读取配置文件
    home.file = {
      ".config/sherlock/config.toml" = {
        text = builtins.readFile ./configs/config.toml;
        force = false;
      };

      ".config/sherlock/style.css" = {
        text = builtins.readFile ./configs/themes/style.css;
        force = false;
      };

      ".config/sherlock/sherlock_alias.json" = {
        text = builtins.readFile ./configs/sherlock_alias.json;
        force = false;
      };

      ".config/sherlock/sherlockignore" = {
        text = builtins.readFile ./configs/sherlockignore;
        force = false;
      };

      ".config/sherlock/fallback.json" = {
        text = builtins.readFile ./configs/fallback.json;
        force = false;
      };

      ".config/sherlock/sherlock_actions.json" = {
        text = builtins.readFile ./configs/sherlock_actions.json;
        force = false;
      };
    };

    # 包和环境变量
    home.packages = with pkgs; [
      sherlock-launcher
    ];

    home.sessionVariables = {
      LAUNCHER = "sherlock";
    };
  };
}
