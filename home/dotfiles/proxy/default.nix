{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.proxy = {
    enable = lib.mkEnableOption "代理配置支持";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "代理配置方式";
    };
  };

  imports = [
    ./clash
  ];
}
