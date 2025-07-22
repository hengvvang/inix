{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && 
                    config.myHome.dotfiles.obs-studio.method == "direct") {

    home.packages = with pkgs; [ obs-studio ];

    # 直接方式配置 - 演示用
    home.activation.obsConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/obs-studio
      $DRY_RUN_CMD echo "Direct OBS configuration method - demo only"
    '';
  };
}
