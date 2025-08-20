{ config, lib, pkgs, ... }:

{
  imports = [
    ./vimrc.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "direct") {

    home.packages = lib.optionals config.myHome.dotfiles.vim.packageEnable (with pkgs; [ vim ]);

    home.file.".vim/autoload/.keep".text = "";
    home.file.".vim/backup/.keep".text = "";
    home.file.".vim/colors/.keep".text = "";
    home.file.".vim/plugged/.keep".text = "";
    home.file.".vim/undo/.keep".text = "";
    home.file.".vim/swp/.keep".text = "";
  };
}
