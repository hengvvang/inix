{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "direct") {
    # 方式2: 直接文件写入（演示用）
    # 特点：直接写入配置文件，灵活但需要手动维护
    
    home.file.".config/nushell/config.nu".text = ''
      # Nushell 基础配置
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
      
      # 基础别名
      alias ll = ls -la
      alias la = ls -a
      alias l = ls
      alias .. = cd ..
      alias ... = cd ../..
      
      # Git 别名
      alias gs = git status
      alias ga = git add
      alias gc = git commit
      alias gp = git push
      alias gl = git log --oneline
      
      # 现代工具别名
      alias cat = bat
      alias find = fd
      alias grep = rg
      
      # 快捷函数
      def mkcd [dir: string] {
        mkdir $dir
        cd $dir
      }
    '';
    
    home.file.".config/nushell/env.nu".text = ''
      # Nushell 环境配置
      $env.EDITOR = "vim"
      $env.BROWSER = "google-chrome"
      $env.TERM = "xterm-256color"
    '';
  };
}
