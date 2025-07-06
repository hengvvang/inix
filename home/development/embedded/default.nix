{ config, lib, pkgs, ... }:

{
  options.myHome.development.embedded = {
    toolchain.enable = lib.mkEnableOption "嵌入式开发工具链";
  };

  # 嵌入式开发模块入口
  imports = [
    ./toolchain.nix
  ];
}
