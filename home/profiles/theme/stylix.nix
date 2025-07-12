{ config, pkgs, lib, ... }:

{
  stylix = {
    # 目标应用程序配置
    targets = {
      # 终端和编辑器
      kitty.enable = true;
      # alacritty.enable = true;  # 暂时禁用，避免配置冲突
      tmux.enable = true;
      vim.enable = true;
      neovim.enable = true;
      
      # 桌面环境
      gtk.enable = true;
      
      # 浏览器
      firefox.enable = true;
      
      # 其他常用应用
      # rofi.enable = true;        # 需要确认是否支持
      # dunst.enable = true;       # 需要确认是否支持
      # waybar.enable = true;      # 需要确认是否支持
      # swaylock.enable = true;    # 需要确认是否支持
      
      # 开发工具
      # bat.enable = true;         # 需要确认是否支持
      # fzf.enable = true;         # 需要确认是否支持
    };
    
    # 透明度设置
    opacity = {
      terminal = 0.9;
      popups = 0.8;
      desktop = 1.0;
    };
  };
}
