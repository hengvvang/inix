{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "external") {
    # 方式3: 外部文件引用
    home.file.".config/nushell/config.nu".source = ./configs/config.nu;
    home.file.".config/nushell/env.nu".source = ./configs/env.nu;
  };
}
