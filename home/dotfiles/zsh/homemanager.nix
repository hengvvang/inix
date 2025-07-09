{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "homemanager") {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        ignoreSpace = true;
        extended = true;
      };
      
      sessionVariables = {
        EDITOR = "vim";
        BROWSER = "google-chrome";
        TERM = "xterm-256color";
      };
      
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
        cat = "bat";
        find = "fd";
        grep = "rg";
      };
      
      initExtra = ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        setopt AUTO_CD
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        
        # 让 Starship 接管提示符，禁用自定义 PROMPT
        autoload -U colors && colors
      '';
      
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "z" "fzf" ];
        # 禁用 oh-my-zsh 主题，让 Starship 接管
        theme = "";
      };
    };
  };
}
