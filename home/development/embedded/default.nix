{ config, lib, pkgs, ... }:

{
  options.myHome.development.embedded.enable = lib.mkEnableOption "嵌入式开发" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.embedded.enable {
    # 直接配置而不设置过深的层次结构
  };

  # 嵌入式开发模块入口
  imports = [
    ./toolchain.nix
  ];
}
