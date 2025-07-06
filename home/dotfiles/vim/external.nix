{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "external") {
    # 方式3: 外部文件引用
    home.file.".vimrc".source = ./configs/vimrc;
  };
}
