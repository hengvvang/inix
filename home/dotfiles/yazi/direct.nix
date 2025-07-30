{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "direct") {
    
    home.packages = with pkgs; [ yazi ];

    home.file.".config/yazi/yazi.toml".text = ''
    '';
    
    home.file.".config/yazi/keymap.toml".text = ''
    '';
    
    home.file.".config/yazi/theme.toml".text = ''
    '';

    home.file.".config/yazi/plugins/smart-entry.yazi/main.lua".text = ''
    '';
    home.file.".config/yazi/plugins/smart-entry.yazi/LICENSE".text = ''
    '';
    home.file.".config/yazi/plugins/smart-entry.yazi/README.md".text = ''
    '';

    home.file.".config/yazi/flavors/tokyo-night.yazi/flavor.toml".text = ''
    '';
    home.file.".config/yazi/flavors/tokyo-night.yazi/tmtheme.xml".text = ''
    '';
  };
}
