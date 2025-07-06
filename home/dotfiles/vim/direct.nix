{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.dotfiles.vim.enable {
    # 方式2: 直接文件写入
    home.file.".vimrc".text = ''
      " Vim 配置文件 - 直接文件写入方式
      
      " 基本设置
      set number
      set relativenumber
      set cursorline
      set showcmd
      set wildmenu
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set autoindent
      set smartindent
      set expandtab
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
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
      
      " 搜索设置
      set nohlsearch
      nnoremap <C-l> :nohlsearch<CR>
      
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
}
