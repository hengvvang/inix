# ==============================================================================
# rmpc (Rust MPD Client) External Configuration 外部配置模块
# ==============================================================================
# 配置示例:
#   myHome.dotfiles.rmpc = {
#     enable = true;
#     method = "external";
#   };
#
# ==============================================================================
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "external") {
    # 安装 rmpc 及相关工具
    home.packages = with pkgs; [
      rmpc          # 现代 Rust MPD 客户端
      cava          # 终端音频可视化器（可选）
      libnotify     # 桌面通知支持
    ];
    
    # 引用外部配置文件
    home.file.".config/rmpc/config.ron" = {
      source = ./configs/config.ron;
      executable = false;
    };
    
    # 创建必要目录
    home.file.".cache/rmpc/.keep".text = "";
    home.file.".local/share/rmpc/lyrics/.keep".text = "";
    
    # 简单启动包装器（人体工程学优化）
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # rmpc 启动脚本 - 检查 MPD 连接状态
        
        if command -v mpc >/dev/null 2>&1; then
          if ! mpc status >/dev/null 2>&1; then
            echo "⚠️  警告: MPD 服务未运行或无法连接"
            echo "💡 提示: systemctl status mpd"
          fi
        fi
        
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };
    
    # 桌面启动器
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc
      Comment=现代化终端 MPD 客户端
      Exec=rmpc-wrapper
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;terminal;rust;
    '';
  };
}
