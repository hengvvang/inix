{ config, lib, pkgs, ... }:

let
  vimConfig = import ./vim-config.nix { inherit config lib pkgs; };
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "direct") {
    
    home.packages = with pkgs; [ vim ];
    
    home.file.".vimrc".text = vimConfig.extraConfig;
    
    # 创建必要的目录
    home.file.".vim/undo/.keep".text = "";
    home.file.".vim/backup/.keep".text = "";
    home.file.".vim/swp/.keep".text = "";
  };
}
