{ config, lib, pkgs, ... }:

{
  vimConfig = ''
    " Vim 配置文件 - Direct Mode
    " ==========================

    " 基本设置
    set nocompatible                " 关闭 vi 兼容模式
    set encoding=utf-8              " 设置编码
    set fileencoding=utf-8          " 文件编码
    set number                      " 显示行号
    set relativenumber              " 相对行号
    set cursorline                  " 高亮当前行
    set ruler                       " 显示光标位置
    set showcmd                     " 显示命令
    set wildmenu                    " 命令行补全
    set laststatus=2                " 总是显示状态栏

    " 缩进和制表符
    set tabstop=4                   " Tab 宽度
    set shiftwidth=4                " 缩进宽度
    set expandtab                   " 使用空格代替 Tab
    set autoindent                  " 自动缩进
    set smartindent                 " 智能缩进

    " 搜索设置
    set hlsearch                    " 高亮搜索结果
    set incsearch                   " 增量搜索
    set ignorecase                  " 忽略大小写
    set smartcase                   " 智能大小写

    " 外观设置
    syntax on                       " 语法高亮
    set background=dark             " 深色背景
    colorscheme default             " 默认配色方案

    " 文件类型检测
    filetype on                     " 启用文件类型检测
    filetype indent on              " 启用文件类型缩进
    filetype plugin on              " 启用文件类型插件

    " 键盘映射
    let mapleader = " "             " 设置 Leader 键

    " 快速保存和退出
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>q :q<CR>
    nnoremap <Leader>wq :wq<CR>

    " 窗口导航
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " 取消搜索高亮
    nnoremap <Leader>/ :nohlsearch<CR>

    " 快速编辑 vimrc
    nnoremap <Leader>ve :edit $MYVIMRC<CR>
    nnoremap <Leader>vr :source $MYVIMRC<CR>

    " 自动命令
    augroup VimDirectConfig
        autocmd!
        " 进入插入模式时关闭相对行号
        autocmd InsertEnter * :set norelativenumber
        autocmd InsertLeave * :set relativenumber
        
        " 保存时自动删除行尾空格
        autocmd BufWritePre * :%s/\s\+$//e
    augroup END

    " 状态栏设置
    set statusline=
    set statusline+=%f              " 文件名
    set statusline+=\ %m            " 修改标志
    set statusline+=\ %r            " 只读标志
    set statusline+=%=              " 右对齐
    set statusline+=\ %l/%L         " 行号/总行数
    set statusline+=\ %c            " 列号
    set statusline+=\ %P            " 百分比

    " 备份和交换文件
    set nobackup                    " 不创建备份文件
    set noswapfile                  " 不创建交换文件
    set undofile                    " 启用撤销文件
    set undodir=~/.vim/undo         " 撤销文件目录

    " 创建撤销目录
    if !isdirectory($HOME."/.vim/undo")
        call mkdir($HOME."/.vim/undo", "p")
    endif

    " 折叠设置
    set foldmethod=indent           " 基于缩进的折叠
    set foldlevel=99                " 默认不折叠

    " 其他设置
    set mouse=a                     " 启用鼠标
    set clipboard=unnamedplus       " 使用系统剪贴板
    set wrap                        " 自动换行
    set linebreak                   " 在单词边界换行
    set scrolloff=8                 " 保持光标上下8行可见
    set sidescrolloff=8             " 保持光标左右8列可见

    " 显示不可见字符
    set list
    set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

    " 完成菜单设置
    set completeopt=menu,menuone,noselect
    set pumheight=10                " 补全菜单最大高度

    echo "🚀 Vim Direct Mode Loaded"
  '';
}
