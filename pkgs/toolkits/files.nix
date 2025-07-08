{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.toolkits.files.enable {
    home.packages = with pkgs; [
      # 压缩工具
      unzip
      zip
      p7zip
      zstd            # 高效压缩
      
      # 现代文件操作
      bat             # 更好的 cat (语法高亮)
      eza             # 更好的 ls (彩色、图标)
      lsd             # 另一个现代 ls
      fd              # 现代 find (快速文件查找)
      tree            # 目录树显示
      dust            # 现代 du (磁盘使用)
      duf             # 现代 df (磁盘信息)
      
      # 文件同步和传输
      rsync           # 文件同步
      rclone          # 云存储同步
      
      # 文件管理器
      yazi            # 现代文件管理器
      ranger          # 另一个终端文件管理器
      
      # 文件工具
      hexyl           # 十六进制查看器
      
      # 导航和搜索
      zoxide          # 智能 cd (z - 记录常用目录)
      fzf             # 模糊搜索工具
      
      # 硬件信息
      neofetch        # 系统信息显示
      lshw            # 硬件信息
      usbutils        # USB 工具
      pciutils        # PCI 工具
      ncdu            # 磁盘使用分析
    ];
  };
}
