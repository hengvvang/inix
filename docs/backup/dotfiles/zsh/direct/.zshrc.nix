{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.file.".config/zsh/.zshrc" = {
      text = ''
        # Zsh configuration file
        export PATH="$HOME/bin:$PATH"
        alias ll='ls -la'
        alias gs='git status'
        source ~/.zsh_aliases
      '';
      target = ".zshrc";
      force = true; # Ensure the file is always written
    };
  };
}
