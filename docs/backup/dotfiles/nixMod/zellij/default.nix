{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.zellij = {
    # 基本启用选项
    enable = lib.mkEnableOption "Zellij 终端多路复用器配置";

    packageEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装 Zellij 软件包 (设为 false 时仅应用配置文件)";
    };

    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        Zellij 配置方式选择:
        - homemanager: 使用 Home Manager 的 programs.zellij 模块 (推荐)
        - direct: 直接通过 Home Manager 配置文件管理
        - external: 使用外部配置文件
        - xdirect: 使用 builtins.readFile 读取外部文件
      '';
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
