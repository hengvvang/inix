{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "homemanager") {
    programs.vim = {
      enable = true;
      defaultEditor = true;
      
      settings = {
        expandtab = true;
        history = 1000;
        ignorecase = true;
        smartcase = true;
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
      };
      
      extraConfig = ''
        set softtabstop=2
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
        set scrolloff=5
        
        syntax on
        set background=dark
        set t_Co=256
        
        filetype on
        filetype plugin on
        filetype indent on
        
        let mapleader = " "
        
        nnoremap <leader>w :w<CR>
        nnoremap <leader>q :q<CR>
        nnoremap <leader>x :x<CR>
        
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l
        
        nnoremap <leader>h :nohlsearch<CR>
        
        set laststatus=2
        set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04v]
      '';
    };
  };
}
