{ config, lib, pkgs, ... }:

{
  # Fish Shell 配置 - 现代化的交互式 Shell
  programs.fish = {
    enable = true;
    
    # Fish 交互式配置
    interactiveShellInit = ''
      # 设置问候语
      set fish_greeting "🐟 欢迎使用 Fish Shell! 今天是 $(date '+%Y年%m月%d日')"
      
      # 设置颜色主题
      set -g fish_color_command brgreen
      set -g fish_color_param cyan
      set -g fish_color_error brred
      set -g fish_color_autosuggestion brblack
      
      # 历史记录配置
      set -g fish_history_limit 10000
    '';
    
    # Fish Shell 别名 (特定于 Fish 的别名)
    shellAliases = {
      # Git 快捷命令
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      lg = "lazygit";
      
      # 开发快捷命令
      cr = "cargo run";
      cb = "cargo build";
      ct = "cargo test";
      py = "python3";
      nr = "npm run";
      
      # 目录操作
      ".." = "cd ..";
      "..." = "cd ../..";
      
      # 编辑器
      vi = "micro";
      vim = "micro";
    };
    
    # Fish 插件
    plugins = [
      # Pure 提示符主题
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];
  };

  # Fish 相关工具 (基础工具已在 modern-tools.nix 中配置)
  home.packages = with pkgs; [
    fishPlugins.pure # Pure 提示符
  ];
}
