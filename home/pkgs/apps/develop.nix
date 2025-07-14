{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.develop.enable {
    home.packages = with pkgs; [
      vscode          # Visual Studio Code
      #zed-editor      # Zed 编辑器
      git             # Git 版本控制
    ];
  };
}
