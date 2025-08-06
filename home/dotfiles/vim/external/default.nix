{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "external") {
    
    home.packages = with pkgs; [ vim ];
    
    home.file.".vimrc".source = ./configs/vimrc;
    
    # 创建必要的目录
    home.file.".vim/undo/.keep".text = "";
    home.file.".vim/backup/.keep".text = "";
    home.file.".vim/swp/.keep".text = "";
  };
}
