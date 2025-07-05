{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors.zed.enable = lib.mkEnableOption "Zed 编辑器配置";

  config = lib.mkIf config.myHome.apps.editors.zed.enable {
  # Zed 编辑器配置
  home.packages = with pkgs; [
    zed-editor
  ];
  };
}