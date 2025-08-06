{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "xdirect") {

    home.packages = with pkgs; [ vim ];

    home.file.".vimrc".text = builtins.readFile ./configs/vimrc;

    home.file.".vim/autoload/.keep".text = "";
    home.file.".vim/backup/.keep".text = "";
    home.file.".vim/colors/.keep".text = "";
    home.file.".vim/plugged/.keep".text = "";
    home.file.".vim/undo/.keep".text = "";
    home.file.".vim/swp/.keep".text = "";

  };
}
