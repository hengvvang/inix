{ config, lib, pkgs, ... }:

{
  # Zed 编辑器配置
  home.packages = with pkgs; [
    zed-editor
  ];
}