{ config, lib, pkgs, ... }:

{
  # 模板配置选项在 default.nix 中定义  
  config = lib.mkIf config.myHome.dotfiles.zsh.enable {
    # 方式4: 模板化配置
    home.file.".zshrc".text = 
      let
        cfg = config.myHome.dotfiles.zsh;
        aliases = cfg.extraAliases // {
          ll = "ls -alF";
          la = "ls -A";
          l = "ls -CF";
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          gs = "git status";
          ga = "git add";
          gc = "git commit";
          gp = "git push";
          gl = "git log --oneline";
          gd = "git diff";
          gb = "git branch";
          gco = "git checkout";
        };
      in ''
        # Zsh 配置文件 - 模板化生成
        # 生成时间: ${builtins.toString builtins.currentTime}
        # 主题: ${cfg.theme}
        
        # 历史设置
        HISTSIZE=${toString cfg.historySize}
        SAVEHIST=${toString cfg.historySize}
        HISTFILE=~/.zsh_history
        setopt SHARE_HISTORY
        setopt HIST_VERIFY
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_IGNORE_SPACE
        
        # 自动补全
        autoload -U compinit
        compinit
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        
        # 目录导航
        setopt AUTO_CD
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        
        # 别名
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "alias ${name}='${value}'") aliases)}
        
        # 现代工具别名
        alias cat='bat'
        alias ls='eza --icons'
        alias tree='eza --tree'
        alias find='fd'
        alias grep='rg'
        alias du='dust'
        alias df='duf'
        alias ps='procs'
        alias top='btop'
        
        ${lib.optionalString cfg.enableAutosuggestion ''
        # 自动建议
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        ''}
        
        ${lib.optionalString cfg.enableSyntaxHighlighting ''
        # 语法高亮
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ''}
        
        # 键绑定
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word
        
        # 主题设置
        ${if cfg.theme == "simple" then ''
        autoload -U colors && colors
        PROMPT='%{$fg[cyan]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$ '
        '' else if cfg.theme == "powerline" then ''
        PROMPT='┌─[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}]─[%{$fg[blue]%}%~%{$reset_color%}]
        └─$ '
        '' else ''
        # 默认主题
        PROMPT='$ '
        ''}
        
        # 环境变量
        export EDITOR=vim
        export BROWSER=google-chrome
        export TERM=xterm-256color
        
        # 路径设置
        export PATH=$HOME/.local/bin:$PATH
        export PATH=$HOME/.cargo/bin:$PATH
      '';
  };
}
