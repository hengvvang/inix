{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.dotfiles.nushell.enable {
    # 方式1: Home Manager 程序模块
    programs.nushell = {
      enable = true;
      
      configFile.text = ''
        # Nushell 配置 - Home Manager 方式
        $env.config = {
          show_banner: false
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
          }
          history: {
            max_size: 10000
            sync_on_enter: true
            file_format: "plaintext"
          }
          edit_mode: emacs
        }
      '';
      
      envFile.text = ''
        # Nushell 环境配置
        $env.EDITOR = "vim"
        $env.BROWSER = "google-chrome"
        $env.TERM = "xterm-256color"
      '';
      
      shellAliases = {
        ll = "ls -la";
        la = "ls -a";
        l = "ls";
        ".." = "cd ..";
        "..." = "cd ../..";
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline";
      };
    };
  };
}
