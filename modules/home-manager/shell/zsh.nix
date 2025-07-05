{ config, lib, pkgs, ... }:

{
   # Zsh Shell 配置 - 强大的交互式 Shell
   programs.zsh = {
   	enable = true;
   	enableCompletion = true;
   	autosuggestion.enable = true;
   	syntaxHighlighting.enable = true;
   	
   	# Oh-My-Zsh 配置
   	oh-my-zsh = {
   		enable = true;
   		plugins = [ 
   		  "git"              # Git 命令补全和别名
   		  "docker"           # Docker 命令补全
   		  "docker-compose"   # Docker Compose 命令补全
   		  "rust"             # Rust 开发工具
   		  "node"             # Node.js 开发工具
   		  "npm"              # npm 命令补全
   		  "sudo"             # sudo 命令增强
   		];
   		theme = "dst";
   	};
   	
   	# Zsh 初始化配置
   	initContent = ''
   		# 快捷键绑定
   		bindkey '^f' autosuggest-accept  # Ctrl+F 接受建议
   		
   		# 历史配置
   		HISTSIZE=10000                   # 内存中的历史记录条数
   		SAVEHIST=10000                   # 保存到文件的历史记录条数
   		HISTFILE=~/.zsh_history          # 历史文件位置
   		
   		# 历史选项
   		setopt HIST_VERIFY               # 历史展开时显示命令
   		setopt SHARE_HISTORY             # 多个会话共享历史
   		setopt APPEND_HISTORY            # 追加而不是覆盖历史文件
   		setopt INC_APPEND_HISTORY        # 立即追加历史记录
   		setopt HIST_IGNORE_DUPS          # 忽略重复的命令
   		setopt HIST_IGNORE_ALL_DUPS      # 删除所有重复的历史记录
   		setopt HIST_REDUCE_BLANKS        # 删除多余的空格
   		setopt HIST_IGNORE_SPACE         # 忽略以空格开头的命令
   		
   		# 其他选项
   		setopt AUTO_CD                   # 输入目录名自动cd
   		setopt AUTO_PUSHD                # 自动pushd
   		setopt PUSHD_IGNORE_DUPS         # pushd时忽略重复目录
   		
   		# 开发环境函数
   		mkcd() { mkdir -p "$1" && cd "$1"; }  # 创建目录并进入
   		
   		# 问候语
   		echo "🚀 欢迎使用 Zsh! 当前时间: $(date '+%Y年%m月%d日 %H:%M:%S')"
   	'';
   };
   
   # FZF 模糊搜索工具
   programs.fzf = {
   	enable = true;
   	enableZshIntegration = true;
   	
   	# FZF 基础配置
   	defaultCommand = "fd --type f --hidden --follow --exclude .git";
   	defaultOptions = [
   	  "--height 40%"
   	  "--layout=reverse"
   	  "--border"
   	];
   };
}
