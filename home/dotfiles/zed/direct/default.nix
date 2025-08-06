{ config, lib, pkgs, ... }:

let
  zedConfig = import ./zed-config.nix { inherit config lib pkgs; };
in
{
  imports = [
    ./zed-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "direct") {
    
    home.packages = with pkgs; [ zed-editor ];
    
    # 配置文件
    home.file.".config/zed/settings.json" = {
      text = zedConfig.zedSettings;
      force = false;
    };
    
    home.file.".config/zed/keymap.json" = {
      text = zedConfig.zedKeymap;
      force = false;
    };
  };
}
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
