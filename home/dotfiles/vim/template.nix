{ config, lib, pkgs, ... }:

{
  # 模板配置选项在 default.nix 中定义
  config = lib.mkIf (config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "template") {
    # 方式4: 模板化配置
    home.file.".vimrc".text = 
      let
        cfg = config.myHome.dotfiles.vim;
      in ''
        " Vim 配置文件 - 模板化配置
        
        " 基本设置
        ${lib.optionalString cfg.showLineNumbers ''
        set number
        set relativenumber
        ''}
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
        set tabstop=${toString cfg.tabSize}
        set shiftwidth=${toString cfg.tabSize}
        set softtabstop=${toString cfg.tabSize}
        set wrap
        set linebreak
        set encoding=utf-8
        
        ${lib.optionalString cfg.enableMouse ''
        " 鼠标支持
        set mouse=a
        ''}
        
        " 外观设置
        syntax on
        set background=dark
        set t_Co=256
        ${lib.optionalString (cfg.colorScheme != "default") ''
        colorscheme ${cfg.colorScheme}
        ''}
        
        " 文件类型检测
        filetype on
        filetype plugin on
        filetype indent on
        
        " 键位映射
        let mapleader = "${cfg.leader}"
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
