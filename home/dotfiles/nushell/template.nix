{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.nushell = {
    enable = lib.mkEnableOption "Nushell dotfiles 配置";
    
    # 模板配置选项
    historySize = lib.mkOption {
      type = lib.types.int;
      default = 10000;
      description = "历史记录大小";
    };
    
    editMode = lib.mkOption {
      type = lib.types.enum [ "emacs" "vi" ];
      default = "emacs";
      description = "编辑模式";
    };
    
    showBanner = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "显示启动横幅";
    };
    
    completionAlgorithm = lib.mkOption {
      type = lib.types.enum [ "prefix" "fuzzy" ];
      default = "fuzzy";
      description = "补全算法";
    };
    
    extraAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "额外的别名";
    };
  };

  config = lib.mkIf config.myHome.dotfiles.nushell.enable {
    # 方式4: 模板化配置
    home.file.".config/nushell/config.nu".text = 
      let
        cfg = config.myHome.dotfiles.nushell;
        defaultAliases = {
          ll = "ls -la";
          la = "ls -a";
          l = "ls";
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
        # Nushell 配置文件 - 模板化生成
        # 生成时间: ${builtins.toString builtins.currentTime}
        # 编辑模式: ${cfg.editMode}
        
        # 别名设置
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "alias ${name} = ${value}") allAliases)}
        
        # 现代工具别名
        alias cat = bat
        alias find = fd
        alias grep = rg
        alias du = dust
        alias df = duf
        alias ps = procs
        alias top = btop
        
        # 自定义命令
        def mkcd [dir: string] {
            mkdir $dir
            cd $dir
        }
        
        def extract [file: string] {
            if ($file | path exists) {
                let ext = ($file | path parse | get extension)
                match $ext {
                    "zip" => { unzip $file }
                    "tar" => { tar -xf $file }
                    "gz" => { 
                        if ($file | str ends-with ".tar.gz") {
                            tar -xzf $file
                        } else {
                            gunzip $file
                        }
                    }
                    "bz2" => {
                        if ($file | str ends-with ".tar.bz2") {
                            tar -xjf $file
                        } else {
                            bunzip2 $file
                        }
                    }
                    "7z" => { 7z x $file }
                    "rar" => { unrar x $file }
                    _ => { echo $"Cannot extract ($file): unsupported format" }
                }
            } else {
                echo $"File ($file) does not exist"
            }
        }
        
        # 配置设置
        $env.config = {
            show_banner: ${lib.boolToString cfg.showBanner}
            completions: {
                case_sensitive: false
                quick: true
                partial: true
                algorithm: "${cfg.completionAlgorithm}"
            }
            history: {
                max_size: ${toString cfg.historySize}
                sync_on_enter: true
                file_format: "plaintext"
            }
            edit_mode: ${cfg.editMode}
            shell_integration: true
            cursor_shape: {
                emacs: line
                vi_insert: line
                vi_normal: block
            }
        }
      '';
      
    home.file.".config/nushell/env.nu".text = ''
      # Nushell 环境配置文件 - 模板化生成
      # 生成时间: ${builtins.toString builtins.currentTime}
      
      # 环境变量
      $env.EDITOR = "vim"
      $env.BROWSER = "google-chrome"
      $env.TERM = "xterm-256color"
      
      # 路径设置
      $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/bin" | prepend $"($env.HOME)/.cargo/bin")
      
      # 自定义提示符
      def create_left_prompt [] {
          let home = $nu.home-path
          let dir = (
              if ($env.PWD | path relative-to $home | is-empty) {
                  "~"
              } else {
                  ($env.PWD | str replace $home "~")
              }
          )
          
          let user = (whoami)
          let host = (hostname)
          
          $"(ansi cyan)($user)@($host)(ansi reset):(ansi blue)($dir)(ansi reset)$ "
      }
      
      def create_right_prompt [] {
          let time_segment = ([
              (date now | format date '%H:%M:%S')
          ] | str join)
          
          $time_segment
      }
      
      $env.PROMPT_COMMAND = {|| create_left_prompt }
      $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
      $env.PROMPT_INDICATOR = "〉"
      $env.PROMPT_INDICATOR_VI_INSERT = ": "
      $env.PROMPT_INDICATOR_VI_NORMAL = "〉"
      $env.PROMPT_MULTILINE_INDICATOR = "::: "
    '';
  };
}
