{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "external") {
    
    home.packages = with pkgs; [ vim ];
    
    home.file.".vimrc".source = ./configs/vimrc;
    # 注意：此方式需要手动维护 configs/vimrc 文件
  };
}
