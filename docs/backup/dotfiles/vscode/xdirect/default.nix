{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "xdirect") {
    home.packages = lib.optionals config.myHome.dotfiles.vscode.packageEnable (with pkgs; [
      vscode
    ]);
    home.file.".config/Code/User/settings.json" = {
        text = builtins.readFile ./configs/settings.json;
        force = false;
    };
    home.file.".config/Code/User/extensions.json" = {
      text = builtins.readFile ./configs/extensions.json;
      force = false;
    };
  };
}
