{ config, lib, pkgs, ... }:

{
  options.mySystem.localization.inputMethod = {
    fcitx5.enable = lib.mkEnableOption "Fcitx5 输入法框架";
    ibus.enable = lib.mkEnableOption "IBus 输入法框架";
  };

  imports = [
    ./fcitx5.nix
    ./ibus.nix
  ];
}
