{ config, lib, pkgs, ... }:

{
  options.myHome.development.embedded.enable = lib.mkEnableOption "嵌入式开发" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.embedded.enable {
    # 嵌入式层默认值：工具链默认开启
    myHome.development.embedded = {
      toolchain.enable = lib.mkDefault true;
    };
  };

  # 嵌入式开发模块入口
  imports = [
    ./toolchain.nix
  ];
}
