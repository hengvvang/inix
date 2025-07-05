{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.editors.zed {
  # Zed 编辑器配置
  home.packages = with pkgs; [
    zed-editor
  ];
  };
}