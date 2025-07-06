{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.vim = {
      enable = true;
      defaultEditor = true;
      
      settings = {
        expandtab = true;
        history = 1000;
        ignorecase = true;
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        smartcase = true;
        tabstop = 4;
      };
      
      extraConfig = ''
        " 基本设置
        set cursorline
        set showcmd
        set wildmenu
        set hlsearch
        set incsearch
        set autoindent
        set smartindent
        set wrap
        set linebreak
        set encoding=utf-8
        
        " 外观设置
        syntax on
        set background=dark
        set t_Co=256
        
        " 文件类型检测
        filetype on
        filetype plugin on
        filetype indent on
        
        " 键位映射
        let mapleader = " "
        nnoremap <leader>w :w<CR>
        nnoremap <leader>q :q<CR>
        nnoremap <leader>wq :wq<CR>
        
        " 窗口操作
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l
        
        " 状态栏设置
        set laststatus=2
        set statusline=%f\ %m%r%h%w\ [%Y]\ [%{&ff}]\ %=%l,%c\ %p%%
      '';
    };
  };
}
