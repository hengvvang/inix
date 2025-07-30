{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.packages = with pkgs; [ zsh ];

    home.file.".zshrc".text = ''
    '';
    home.file.".config/zsh/zshenv".text = ''
    '';
    home.file.".config/zsh/zlogin".text = ''
    '';
    home.file.".config/zsh/zlogout".text = ''
    '';
    home.file.".config/zsh/zprofile".text = ''
    '';
  };
}
