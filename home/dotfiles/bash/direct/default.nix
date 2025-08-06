{ config, lib, pkgs, ... }:

let
  bashConfig = import ./bash-config.nix { inherit config lib pkgs; };
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {
    
    programs.bash = {
      enable = true;
      package = pkgs.bash;
      historySize = bashConfig.historySize;
      historyFileSize = bashConfig.historyFileSize;
      historyControl = bashConfig.historyControl;
      historyIgnore = bashConfig.historyIgnore;
      enableCompletion = bashConfig.enableCompletion;
      shellAliases = bashConfig.shellAliases;
      shellOptions = bashConfig.shellOptions;
      initExtra = bashConfig.initExtra;
      logoutExtra = bashConfig.logoutExtra;
    };
  };
}
