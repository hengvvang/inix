{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors.vim.enable = lib.mkEnableOption "Vim 编辑器配置";

  config = lib.mkIf config.myHome.apps.editors.vim.enable {
  # 基础文本编辑器
  home.packages = with pkgs; [
    vim
    micro         # 简单的终端编辑器
  ];

  # 配置 Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  };
}