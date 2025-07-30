{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "direct") {
    
    home.packages = with pkgs; [ vim ];
    
    home.file.".vimrc".text = ''
    '';
  };
}
