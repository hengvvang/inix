{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.git = {
      enable = true;
      
      userName = "hengvvang";
      userEmail = "hengvvang@example.com";  # 请替换为您的邮箱
      
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        core.autocrlf = "input";
        core.safecrlf = true;
        
        push.default = "simple";
        pull.rebase = false;
        
        color.ui = true;
        color.status = "auto";
        color.branch = "auto";
        color.interactive = "auto";
        color.diff = "auto";
        
        diff.tool = "vimdiff";
        merge.tool = "vimdiff";
        
        alias = {
          st = "status";
          co = "checkout";
          br = "branch";
          cm = "commit";
          pl = "pull";
          ps = "push";
          lg = "log --oneline --graph --decorate";
          ll = "log --pretty=format:'%h - %an, %ar : %s'";
          unstage = "reset HEAD --";
          last = "log -1 HEAD";
          visual = "!gitk";
        };
      };
      
      # Git 忽略文件
      ignores = [
        # 系统文件
        ".DS_Store"
        "Thumbs.db"
        
        # 编辑器文件
        "*.swp"
        "*.swo"
        "*~"
        ".vscode/"
        ".idea/"
        
        # 临时文件
        "*.tmp"
        "*.temp"
        "*.log"
        
        # 构建文件
        "node_modules/"
        "target/"
        "build/"
        "dist/"
        ".cache/"
        
        # 环境文件
        ".env"
        ".env.local"
        ".env.*.local"
      ];
      
      # Delta 配置 (更好的 diff 显示)
      delta = {
        enable = true;
        options = {
          navigate = true;
          light = false;
          side-by-side = true;
          line-numbers = true;
          syntax-theme = "Dracula";
        };
      };
    };
  };
}
