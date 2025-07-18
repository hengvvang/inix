{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "homemanager") {
    programs.vim = {
      # 启用 Vim
      enable = true;
      
      # 基础设置 - 使用 Home Manager 的声明式配置
      settings = {
        # 基础编辑器设置
        number = true;              # 显示行号
        expandtab = true;           # 使用空格替代 tab
        tabstop = 2;               # tab 宽度为 2 个空格
        shiftwidth = 2;            # 自动缩进宽度
        
        # 搜索设置
        ignorecase = true;         # 搜索时忽略大小写
        smartcase = true;          # 当搜索包含大写字母时区分大小写
        
        # 撤销设置
        undofile = true;           # 启用持久化撤销
        # undodir = [ "~/.vim/undo" ]; # 撤销文件目录 - 可能有问题，先注释
        
        # 界面设置
        background = "dark";       # 暗色主题背景
        hidden = true;             # 允许切换缓冲区而不保存
        history = 1000;            # 命令历史数量
        
        # 鼠标设置 (关闭以保持纯键盘操作)
        # mouse = "";                # 禁用鼠标 - 空字符串可能有问题，先注释
        
        # 其他有用设置
        modeline = false;          # 关闭 modeline (安全考虑)
        copyindent = true;         # 复制缩进格式
      };
      
      # 精选插件配置
      plugins = with pkgs.vimPlugins; [
        vim-sensible               # Vim 合理默认设置
        auto-pairs                 # 自动配对括号
        vim-surround              # 包围字符操作
        vim-commentary            # 快速注释
        vim-nix                   # Nix 语法支持
      ];
      
      # 增强的 Vim 配置
      extraConfig = ''
        " ===== 基础设置 =====
        set nocompatible          " 关闭 vi 兼容模式
        set encoding=utf-8        " 设置编码
        syntax enable             " 启用语法高亮
        
        " ===== 界面设置 =====
        set cursorline            " 高亮当前行
        set showmatch             " 显示匹配的括号
        set ruler                 " 显示光标位置
        set showcmd               " 显示命令
        set wildmenu              " 命令行补全菜单
        
        " ===== 搜索设置 =====
        set hlsearch              " 高亮搜索结果
        set incsearch             " 增量搜索
        
        " ===== 缩进设置 =====
        set autoindent            " 自动缩进
        filetype plugin indent on " 启用文件类型检测和缩进
        
        " ===== 基础键位映射 =====
        let mapleader = " "       " 设置 leader 键
        
        " 清除搜索高亮
        nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
        
        " 快速保存
        nnoremap <C-s> :w<CR>
        inoremap <C-s> <Esc>:w<CR>a
        
        " ===== 文件类型特定设置 =====
        autocmd FileType python setlocal tabstop=4 shiftwidth=4
        autocmd FileType nix setlocal tabstop=2 shiftwidth=2
        autocmd FileType javascript,json setlocal tabstop=2 shiftwidth=2
        autocmd FileType yaml,yml setlocal tabstop=2 shiftwidth=2
      '';
    };
    
    # 确保必要的目录存在
    home.file.".vim/undo/.keep".text = "";
    home.file.".vim/backup/.keep".text = "";
    home.file.".vim/swp/.keep".text = "";
  };
}
