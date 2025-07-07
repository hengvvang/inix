{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.proxy.clash;
in
{
  options.myHome.dotfiles.proxy.clash = {
    enable = lib.mkEnableOption "Clash 用户配置文件管理";
    
    configMethod = lib.mkOption {
      type = lib.types.enum [ "direct" "external" "homemanager" ];
      default = "homemanager";
      description = ''
        配置文件管理方式:
        - direct: 直接复制到用户配置目录
        - external: 使用外部配置文件  
        - homemanager: 通过 Home Manager 管理
      '';
    };
    
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.config/clash";
      description = "Clash 用户配置目录";
    };
  };

  config = lib.mkIf cfg.enable {
    # Home Manager 模式 - 推荐
    home.file = lib.mkIf (cfg.configMethod == "homemanager") {
      "${cfg.configDir}/config.yaml".source = ./configs/config.yaml;
      "${cfg.configDir}/README.md".text = ''
        # Clash 配置 (Home Manager 模式)
        
        配置文件由 Home Manager 管理。
        
        修改配置: 编辑 Nix 配置文件后运行 `home-manager switch`
        同步到系统: `sudo cp ~/.config/clash/config.yaml /etc/clash/config.yaml && sudo systemctl restart clash`
      '';
    };
    
    # 安装用户工具
    home.packages = with pkgs; [
      yq-go  # YAML 处理工具
    ];
  };
}
