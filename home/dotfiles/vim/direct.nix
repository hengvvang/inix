{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "direct") {
    
    home.packages = with pkgs; [ vim ];
    
    home.file.".vimrc".text = ''
      " Vim 基础配置
      set nocompatible
      set number
      set relativenumber
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set mouse=a
      set clipboard=unnamed
      set backspace=indent,eol,start
      
      " 基础键位映射
      let mapleader = " "
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap <leader>h :noh<CR>
      
      " 窗口切换
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      
      " 语法高亮
      syntax on
      filetype plugin indent on
      
      " 基础主题
      colorscheme default
      set background=dark
    '';
  };
}
