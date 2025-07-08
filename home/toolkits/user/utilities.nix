{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.toolkits.user.utilities.enable {
    home.packages = with pkgs; [
      # 基础工具
      unzip
      zip
      p7zip
      
      # 数据处理
      jq              # JSON 处理
      yq              # YAML 处理
      
      # 现代化命令行工具
      bat             # 更好的 cat (语法高亮)
      eza             # 更好的 ls (彩色、图标)
      lsd             # 另一个现代 ls
      ripgrep         # 现代 grep (rg - 更快搜索)
      fd              # 现代 find (快速文件查找)
      tree            # 目录树显示
      
      # 文件同步和传输
      rsync           # 文件同步
      rclone          # 云存储同步
      
      # 导航和搜索
      zoxide          # 智能 cd (z - 记录常用目录)
      fzf             # 模糊搜索工具
      
      # Git 工具
      delta           # 更好的 git diff
      lazygit         # Git GUI
      gitui           # 另一个 Git TUI
      
      # 系统监控
      btop            # 现代 htop
      procs           # 现代 ps
      dust            # 现代 du
      duf             # 现代 df
      bandwhich       # 网络带宽监控
      
      # 网络工具
      httpie          # 现代 curl
      gping           # 现代 ping
      dog             # 现代 dig
      
      # 文件工具
      xh              # 更快的 HTTP 客户端
      hexyl           # 十六进制查看器
      
      # 终端增强
      starship        # 现代提示符
      tmux            # 终端复用器
      
      # 文件管理
      yazi            # 现代文件管理器
      ranger          # 另一个终端文件管理器
      
      # 开发工具
      hyperfine       # 基准测试工具
      tealdeer        # 快速 man 页面 (tldr)
      
      # 安全工具
      age             # 现代文件加密
      
      # 数据可视化
      visidata        # 表格数据查看器
      
      # 文本处理
      choose          # 更好的 cut
      sd              # 现代 sed
      
      # 图像处理
      imagemagick     # 图像处理套件
      
      # 压缩工具
      zstd            # 高效压缩
      
      # 其他实用工具
      direnv          # 目录环境变量
      tokei           # 代码统计
      watchexec       # 文件监控执行
    ];
  };
}
