{ config, lib, pkgs, ... }:

{
  options.myHome.development.embedded = {
    enable = lib.mkEnableOption "嵌入式开发环境支持";
    toolchain.enable = lib.mkEnableOption "嵌入式开发工具链";
  };

  # 嵌入式开发模块入口
  imports = [
    ./toolchain.nix
  ];
}
