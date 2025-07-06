{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        add_newline = true;
        
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };
        
        directory = {
          style = "cyan bold";
          truncation_length = 3;
        };
        
        git_branch = {
          symbol = " ";
          style = "purple bold";
        };
        
        git_status = {
          style = "red bold";
        };
        
        cmd_duration = {
          min_time = 2000;
          format = "took [$duration]($style) ";
          style = "yellow bold";
        };
        
        nix_shell = {
          format = "via [❄️ $state]($style) ";
          style = "bold blue";
        };
        
        os = {
          symbols = {
            NixOS = "❄️ ";
            Linux = "🐧 ";
          };
        };
      };
    };
  };
}
