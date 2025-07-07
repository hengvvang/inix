{ config, lib, pkgs, ... }:

{
  options.mySystem.localization.inputMethod = {
    enable = lib.mkEnableOption "输入法配置支持";
    fcitx5.enable = lib.mkEnableOption "Fcitx5 输入法框架";
    ibus.enable = lib.mkEnableOption "IBus 输入法框架";
  };

  imports = [
    ./fcitx5.nix
    ./ibus.nix
  ];
}
