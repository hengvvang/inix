{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.toolkits.user.utilities.enable {
    home.packages = with pkgs; [
    unzip
    zip
    p7zip
    jq            # JSON 处理
    yq            # YAML 处理
    bat           # 更好的 cat
    eza           # 更好的 ls
    lsd                # 现代 ls (彩色、图标)
    bat                # 现代 cat (语法高亮)
    ripgrep            # 现代 grep (更快)
    tree          # 目录树显示
    fd            # 快速文件查找
    rsync         # 文件同步
    zoxide             # 智能 cd (记录常用目录)
    fzf                # 模糊搜索工具
    delta              # 更好的 git diff
    starship           # 现代提示符
    ];
  };
}
