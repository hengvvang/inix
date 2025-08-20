{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.bash = {
    enable = lib.mkEnableOption "Bash Shell 配置";

    packageEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装 Bash Shell 软件包 (设为 false 时仅应用配置文件)";
    };

    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        配置方式选择:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
        - direct: 直接文件写入方式
        - external: 外部文件引用方式
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
