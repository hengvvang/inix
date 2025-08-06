{ config, lib, pkgs, ... }:

let
  yaziConfig = import ./yazi-config.nix { inherit config lib pkgs; };
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "direct") {
    
    home.packages = with pkgs; [ yazi ];

    home.file.".config/yazi/yazi.toml".text = yaziConfig.yaziToml;
    home.file.".config/yazi/keymap.toml".text = yaziConfig.keymapToml;
    home.file.".config/yazi/theme.toml".text = yaziConfig.themeToml;
    home.file.".config/yazi/init.lua".text = yaziConfig.initLua;
  };
}
    '';
    home.file.".config/yazi/plugins/smart-entry.yazi/README.md".text = ''
    '';

    home.file.".config/yazi/flavors/tokyo-night.yazi/flavor.toml".text = ''
    '';
    home.file.".config/yazi/flavors/tokyo-night.yazi/tmtheme.xml".text = ''
    '';
  };
}
