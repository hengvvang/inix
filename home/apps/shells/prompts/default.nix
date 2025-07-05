{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.prompts.enable = lib.mkEnableOption "提示符配置";

  config = lib.mkIf config.myHome.apps.shells.prompts.enable {
    # 提示符层默认配置：starship作为现代提示符默认开启
    myHome.apps.shells.prompts = {
      starship.enable = lib.mkDefault true;
    };
  };

  # 提示符模块入口
  imports = [
    ./starship.nix    # Starship 现代化提示符
    # 可以在这里添加其他提示符配置
  ];
}
