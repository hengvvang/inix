{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.development.versionControl.git {
    programs.git = {
    enable = true;
    
    # 用户信息
    userName = "hengvvang";
    userEmail = "hengvvang@example.com";
    
    # 基础配置
    extraConfig = {
      core = {
        editor = "micro";
        autocrlf = "input";
      };
      
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      
      pull = {
        rebase = false;
      };
      
      init = {
        defaultBranch = "main";
      };
      
      # 基础别名
      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        s = "status -s";
        d = "diff";
        l = "log --oneline";
        lg = "log --graph --oneline --all";
        cm = "commit -m";
        unstage = "reset HEAD";
      };
    };
    
    # 基础忽略文件
    ignores = [
      # 临时文件
      "*.tmp"
      "*.swp"
      "*~"
      
      # 系统文件
      ".DS_Store"
      "Thumbs.db"
      
      # IDE
      ".vscode/"
      ".idea/"
      
      # 环境文件
      ".env"
      ".env.local"
      
      # 常见构建目录
      "node_modules/"
      "__pycache__/"
      "*.pyc"
      "target/"
      "build/"
      "dist/"
    ];
  };
  
  # Git 相关工具
  home.packages = with pkgs; [
    # Git 增强
    delta              # 更好的 git diff
    gh                 # GitHub CLI
    lazygit            # 终端 Git UI
    
    # 实用工具
    git-lfs            # Git 大文件支持
  ];
  };
}
