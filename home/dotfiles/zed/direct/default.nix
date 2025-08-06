{ config, lib, pkgs, ... }:

{
  imports = [
    ./settings.json.nix
    ./extensions.json.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "direct") {

    home.packages = with pkgs; [ zed-editor ];

    # 配置文件
    home.file.".config/zed/settings.json" = {
      text = zedConfig.zedSettings;
      force = false;
    };

    home.file.".config/zed/keymap.json" = {
      text = zedConfig.zedKeymap;
      force = false;
    };
  };
}
