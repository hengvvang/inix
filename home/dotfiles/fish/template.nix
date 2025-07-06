{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.fish = {
    enable = lib.mkEnableOption "Fish dotfiles 配置";
    
    # 模板配置选项
    greeting = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Fish shell 欢迎信息";
    };
    
    theme = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "Fish 主题";
    };
    
    enableVI = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "启用 VI 模式";
    };
    
    extraAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "额外的别名";
    };
    
    extraFunctions = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "额外的函数";
    };
  };

  config = lib.mkIf config.myHome.dotfiles.fish.enable {
    # 方式4: 模板化配置
    home.file.".config/fish/config.fish".text = 
      let
        cfg = config.myHome.dotfiles.fish;
        defaultAliases = {
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
        allAliases = defaultAliases // cfg.extraAliases;
      in ''
        # Fish Shell 配置文件 - 模板化生成
        # 生成时间: ${builtins.toString builtins.currentTime}
        # 主题: ${cfg.theme}
        
        # 欢迎信息设置
        ${if cfg.greeting == "" then ''
        set -g fish_greeting ""
        '' else ''
        set -g fish_greeting "${cfg.greeting}"
        ''}
        
        # 环境变量
        set -gx EDITOR vim
        set -gx BROWSER google-chrome
        set -gx TERM xterm-256color
        
        # 路径设置
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin
        
        ${lib.optionalString cfg.enableVI ''
        # VI 模式
        fish_vi_key_bindings
        ''}
        
        # 别名设置
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "alias ${name}='${value}'") allAliases)}
        
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
        
        # 键绑定
        ${if cfg.enableVI then ''
        # VI 模式键绑定
        bind -M insert \e\[1\;5C forward-word
        bind -M insert \e\[1\;5D backward-word
        '' else ''
        # Emacs 模式键绑定 (默认)
        bind \e\[1\;5C forward-word
        bind \e\[1\;5D backward-word
        ''}
        
        # 主题设置
        ${if cfg.theme == "nord" then ''
        # Nord 主题配置
        set -g fish_color_normal normal
        set -g fish_color_command 81a1c1
        set -g fish_color_quote a3be8c
        set -g fish_color_redirection b48ead
        set -g fish_color_end 88c0d0
        set -g fish_color_error ebcb8b
        set -g fish_color_param eceff4
        set -g fish_color_comment 616e88
        set -g fish_color_match --background=brblue
        set -g fish_color_selection white --bold --background=brblack
        set -g fish_color_search_match bryellow --background=brblack
        set -g fish_color_history_current --bold
        set -g fish_color_operator 00a6b2
        set -g fish_color_escape 00a6b2
        set -g fish_color_cwd green
        set -g fish_color_cwd_root red
        set -g fish_color_valid_path --underline
        set -g fish_color_autosuggestion 4c566a
        set -g fish_color_user brgreen
        set -g fish_color_host normal
        set -g fish_color_cancel -r
        set -g fish_pager_color_completion normal
        set -g fish_pager_color_description B3A06D yellow
        set -g fish_pager_color_prefix white --bold --underline
        set -g fish_pager_color_progress brwhite --background=cyan
        '' else ''
        # 默认主题
        ''}
      '';
    
    # 生成额外函数文件
    home.file = lib.mkMerge [
      # 默认函数
      {
        ".config/fish/functions/mkcd.fish".text = ''
          function mkcd --description "Create directory and change to it"
              mkdir -p $argv
              and cd $argv
          end
        '';
        
        ".config/fish/functions/extract.fish".text = ''
          function extract --description "Extract various archive formats"
              if test -f $argv[1]
                  switch $argv[1]
                      case '*.tar.bz2'
                          tar xjf $argv[1]
                      case '*.tar.gz'
                          tar xzf $argv[1]
                      case '*.bz2'
                          bunzip2 $argv[1]
                      case '*.rar'
                          unrar x $argv[1]
                      case '*.gz'
                          gunzip $argv[1]
                      case '*.tar'
                          tar xf $argv[1]
                      case '*.tbz2'
                          tar xjf $argv[1]
                      case '*.tgz'
                          tar xzf $argv[1]
                      case '*.zip'
                          unzip $argv[1]
                      case '*.Z'
                          uncompress $argv[1]
                      case '*.7z'
                          7z x $argv[1]
                      case '*'
                          echo "'$argv[1]' cannot be extracted via extract()"
                  end
              else
                  echo "'$argv[1]' is not a valid file"
              end
          end
        '';
      }
      
      # 额外自定义函数
      (lib.mapAttrs' (name: body: {
        name = ".config/fish/functions/${name}.fish";
        value = { text = ''
          function ${name}
              ${body}
          end
        ''; };
      }) cfg.extraFunctions)
    ];
  };
}
