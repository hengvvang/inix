{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "external") {
    # Visual Studio Code 配置 - 外部配置文件方式
    
    # 安装 VSCode 包
    home.packages = with pkgs; [
      vscode
    ];
    
    # 链接外部配置文件到 VSCode 配置目录
    home.file.".config/Code/User/settings.json" = {
      source = ./configs/settings.json;
      # 设置为只读，确保配置文件不被 VSCode 修改
      # readonly = true;  # 可选，如果希望 VSCode 可以修改配置则注释此行
    };
    
    home.file.".config/Code/User/keybindings.json" = {
      source = ./configs/keybindings.json;
      # readonly = true;  # 可选
    };
    
    # 扩展配置文件 (可选)
    home.file.".config/Code/User/extensions.json" = {
      source = ./configs/extensions.json;
    };
    
    # 代码片段配置 (可选)
    home.file.".config/Code/User/snippets" = {
      source = ./configs/snippets;
      recursive = true;  # 递归复制整个目录
    };
    
    # 创建配置说明文件
    home.file."vscode-external-config-note.txt" = {
      text = ''
        VSCode 外部配置模式说明:
        
        配置文件位置:
        - 设置: ~/.config/Code/User/settings.json
        - 快捷键: ~/.config/Code/User/keybindings.json
        - 扩展: ~/.config/Code/User/extensions.json
        - 代码片段: ~/.config/Code/User/snippets/
        
        配置文件来源:
        - home/dotfiles/vscode/configs/ 目录下的配置文件
        
        修改配置:
        1. 编辑 configs/ 目录下的对应文件
        2. 重新构建 Home Manager 配置
        3. 重启 VSCode 使配置生效
        
        注意: 如果设置了 readonly = true，VSCode 无法直接修改配置文件。
      '';
      target = "Documents/vscode-external-config-note.txt";
    };
  };
}
