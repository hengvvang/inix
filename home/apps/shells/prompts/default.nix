{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.prompts = {
    starship.enable = lib.mkEnableOption "Starship 现代化提示符";
  };

  # 提示符模块入口
  imports = [
    ./starship.nix    # Starship 现代化提示符
    # 可以在这里添加其他提示符配置
  ];
}
