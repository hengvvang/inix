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
   		  "docker-compose" 
   		  "docker" 
   		  "git"
   		  "sudo"
   		  "kubectl"
   		  "rust"
   		  "node"
   		  "npm"
   		];
   		theme = "dst";
   	};
   	
   	# Zsh 初始化配置
   	initExtra = ''
   		# 快捷键绑定
   		bindkey '^f' autosuggest-accept
   		
   		# 历史配置
   		HISTSIZE=10000
   		SAVEHIST=10000
   		HISTFILE=~/.zsh_history
   		
   		# 设置选项
   		setopt HIST_VERIFY
   		setopt SHARE_HISTORY
   		setopt APPEND_HISTORY
   		setopt INC_APPEND_HISTORY
   		setopt HIST_IGNORE_DUPS
   		setopt HIST_IGNORE_ALL_DUPS
   		setopt HIST_REDUCE_BLANKS
   		setopt HIST_IGNORE_SPACE
   		setopt CORRECT
   		setopt AUTO_CD
   		setopt AUTO_PUSHD
   		setopt PUSHD_IGNORE_DUPS
   		
   		# 自定义函数
   		mkcd() { mkdir -p "$1" && cd "$1"; }
   		backup() { cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"; }
   		
   		# 问候语
   		echo "🚀 欢迎使用 Zsh! 当前时间: $(date '+%Y年%m月%d日 %H:%M:%S')"
   	'';
   };
   
   # FZF 模糊搜索工具
   programs.fzf = {
   	enable = true;
   	enableZshIntegration = true;
   	
   	# FZF 配置选项
   	defaultCommand = "fd --type f --hidden --follow --exclude .git";
   	defaultOptions = [
   	  "--height 40%"
   	  "--layout=reverse"
   	  "--border"
   	  "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
   	];
   	
   	# 文件搜索配置
   	fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
   	fileWidgetOptions = [
   	  "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
   	];
   	
   	# 目录搜索配置
   	changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
   	changeDirWidgetOptions = [
   	  "--preview 'tree -C {} | head -200'"
   	];
   	
   	# 历史搜索配置
   	historyWidgetOptions = [
   	  "--sort"
   	  "--exact"
   	];
   };
}
