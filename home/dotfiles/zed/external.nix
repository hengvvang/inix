{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "external") {
    
    home.packages = with pkgs; [
      zed-editor
    ];
    
    # 链接外部配置文件到 Zed 配置目录
    home.file.".config/zed/settings.json" = {
      source = ./configs/settings.json;
      # 设置为只读，确保配置文件不被 Zed 修改
      # readonly = true;  # 可选，如果希望 Zed 可以修改配置则注释此行
    };
    
    home.file.".config/zed/keymap.json" = {
      source = ./configs/keymap.json;
      # readonly = true;  # 可选
    };
    
    # 主题配置目录 (可选)
    home.file.".config/zed/themes" = {
      source = ./configs/themes;
      recursive = true;  # 递归复制整个目录
    };
    
    # 创建配置说明文件
    home.file."zed-external-config-note.txt" = {
      text = ''
        Zed Editor 外部配置模式说明:
        
        配置文件位置:
        - 设置: ~/.config/zed/settings.json
        - 键位: ~/.config/zed/keymap.json
        - 主题: ~/.config/zed/themes/
        
        配置文件来源:
        - home/dotfiles/zed/configs/ 目录下的配置文件
        
        修改配置:
        1. 编辑 configs/ 目录下的对应文件
        2. 重新构建 Home Manager 配置
        3. 重启 Zed 使配置生效
        
        扩展安装:
        - Zed 扩展需要在编辑器内手动安装
        - 命令面板: Ctrl+Shift+P
        - 搜索: "Extensions" 或 "Install Extension"
        
        推荐扩展:
        - Nix 语言支持
        - Vim 键位绑定
        - Catppuccin 主题
        - Git 集成工具
        
        注意: 如果设置了 readonly = true，Zed 无法直接修改配置文件。
      '';
      target = "Documents/zed-external-config-note.txt";
    };
  };
}
