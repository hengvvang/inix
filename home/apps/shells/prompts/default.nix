{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.prompts.enable = lib.mkEnableOption "提示符配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.apps.shells.prompts.enable {
    # 直接配置而不设置过深的层次结构
  };

  # 提示符模块入口
  imports = [
    ./starship.nix    # Starship 现代化提示符
    # 可以在这里添加其他提示符配置
  ];
}
