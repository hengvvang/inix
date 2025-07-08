{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "external") {
    home.packages = with pkgs; [ vim ];
    
    # 外部文件引用 - 演示用简化配置
    home.file.".vimrc".source = ./configs/vimrc;
    # 注意：此方式需要手动维护 configs/vimrc 文件
  };
}
