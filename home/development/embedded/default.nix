{ config, lib, pkgs, ... }:

{
  options.myHome.development.embedded.enable = lib.mkEnableOption "嵌入式开发" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.embedded.enable {
    # 设置嵌入式开发工具的默认值
    myHome.development.embedded = {
      toolchain.enable = lib.mkDefault true;
    };
  };

  # 嵌入式开发模块入口
  imports = [
    ./toolchain.nix
  ];
}
