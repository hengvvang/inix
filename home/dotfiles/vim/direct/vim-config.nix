{ config, lib, pkgs, ... }:

{
  extraConfig = ''
    " ===== 基础设置 =====
    set nocompatible          " 关闭 vi 兼容模式
    set encoding=utf-8        " 设置编码
    syntax enable             " 启用语法高亮
    set number                " 显示行号
    set relativenumber        " 显示相对行号
    set expandtab             " 使用空格替代 tab
    set tabstop=2             " tab 宽度为 2 个空格
    set shiftwidth=2          " 自动缩进宽度
    set softtabstop=2         " 软 tab 宽度
    
    " ===== 界面设置 =====
    set cursorline            " 高亮当前行
    set showmatch             " 显示匹配的括号
    set ruler                 " 显示光标位置
    set showcmd               " 显示命令
    set wildmenu              " 命令行补全菜单
    set laststatus=2          " 总是显示状态栏
    set background=dark       " 暗色主题背景
    
    " ===== 搜索设置 =====
    set hlsearch              " 高亮搜索结果
    set incsearch             " 增量搜索
    set ignorecase            " 搜索时忽略大小写
    set smartcase             " 当搜索包含大写字母时区分大小写
    
    " ===== 缩进设置 =====
    set autoindent            " 自动缩进
    set smartindent           " 智能缩进
    filetype plugin indent on " 启用文件类型检测和缩进
    
    " ===== 其他设置 =====
    set hidden                " 允许切换缓冲区而不保存
    set history=1000          " 命令历史数量
    set undofile              " 启用持久化撤销
    set undodir=~/.vim/undo   " 撤销文件目录
    set backupdir=~/.vim/backup " 备份文件目录
    set directory=~/.vim/swp  " 交换文件目录
    set modeline              " 启用 modeline
    set copyindent            " 复制缩进格式
    set wrap                  " 自动换行
    set linebreak             " 在单词边界换行
    
    " ===== 基础键位映射 =====
    let mapleader = " "       " 设置 leader 键
    nnoremap <leader>w :w<CR>
    nnoremap <leader>q :q<CR>
    nnoremap <leader>wq :wq<CR>
    nnoremap <C-l> :nohlsearch<CR>
    
    " ===== 窗口操作 =====
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    
    " ===== 文件类型特定设置 =====
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType nix setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType javascript,json setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType yaml,yml setlocal tabstop=2 shiftwidth=2 softtabstop=2
  '';
}
