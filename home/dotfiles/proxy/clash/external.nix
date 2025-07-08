{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.proxy.enable && config.myHome.dotfiles.proxy.method == "external" && config.myHome.dotfiles.proxy.clash.enable) {
    # 方式3: 外部文件引用（演示用）
    # 特点：引用外部配置文件，便于独立管理和分享
    
    home.file.".config/clash/config.yaml".source = ./configs/config.yaml;
    home.file.".config/clash/Country.mmdb".source = ./configs/Country.mmdb;
  };
}
