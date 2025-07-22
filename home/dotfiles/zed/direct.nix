{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "direct") {
    # Zed Editor 配置 - 直接安装包方式
    home.packages = with pkgs; [
      zed-editor                  # 官方 Zed Editor
    ];
    
    # 提示用户手动配置
    home.file."zed-setup-note.txt" = {
      text = ''
        Zed Editor 直接安装模式配置说明:
        
        1. 已安装 Zed Editor 到系统环境
        2. 已安装常用语言服务器和格式化工具
        3. 请手动配置 Zed 设置和扩展
        
        配置文件位置:
        - 设置: ~/.config/zed/settings.json
        - 键位: ~/.config/zed/keymap.json
        - 主题: ~/.config/zed/themes/
        
        推荐扩展 (在 Zed 中安装):
        - Nix 语言支持
        - Vim 键位绑定
        - Catppuccin 主题
        - Git 集成工具
        
        启动 Zed:
        - 命令行: zed
        - 打开目录: zed /path/to/project
        
        如需自动化配置，请切换到 homemanager 模式。
      '';
      target = "Documents/zed-setup-note.txt";
    };
    
    # 创建基础配置目录结构
    home.file.".config/zed/.gitkeep" = {
      text = "# Zed configuration directory";
    };
  };
}
