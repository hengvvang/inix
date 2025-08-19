{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.ghostty = {
    enable = lib.mkEnableOption "Ghostty dotfiles 配置";

    packageEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装 Ghostty 软件包 (设为 false 时仅应用配置文件)";
    };

    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "direct";
      description = "Ghostty 配置方式";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
