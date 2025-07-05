{ config, lib, pkgs, ... }:

{
  options.mySystem.localization.inputMethod = {
    fcitx5 = lib.mkEnableOption "Fcitx5 输入法框架";
    ibus = lib.mkEnableOption "IBus 输入法框架";
  };

  imports = [
    ./fcitx5.nix
    ./ibus.nix
  ];
}
