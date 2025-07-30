{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {
    
    home.packages = with pkgs; [ bash ];

    home.file.".bashrc".text = ''
    '';

    home.file.".bash_profile".text = ''
    '';
    home.file.".bash_aliases".text = ''
    '';
    home.file.".bash_logout".text = ''
    '';
    home.file.".bash_completion".text = ''
    '';
    home.file.".bash_prompt".text = ''
    '';
  };
}
