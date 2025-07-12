{ config, pkgs, lib, ... }:

{
  options.myHome.profiles.stylix.targets = {
    enable = lib.mkEnableOption "Stylix 目标应用配置";
    
    # 终端应用
    terminals = {
      alacritty.enable = lib.mkEnableOption "Alacritty 主题";
      kitty.enable = lib.mkEnableOption "Kitty 主题";
    };
    
    # 编辑器
    editors = {
      vim.enable = lib.mkEnableOption "Vim 主题";
      neovim.enable = lib.mkEnableOption "Neovim 主题";
    };
    
    # 工具
    tools = {
      tmux.enable = lib.mkEnableOption "Tmux 主题";
      bat.enable = lib.mkEnableOption "Bat 主题";
      fzf.enable = lib.mkEnableOption "Fzf 主题";
    };
    
    # 桌面环境
    desktop = {
      gtk.enable = lib.mkEnableOption "GTK 主题";
    };
    
    # 浏览器
    browsers = {
      firefox.enable = lib.mkEnableOption "Firefox 主题";
    };
  };

  config = lib.mkIf (config.myHome.profiles.stylix.enable && config.myHome.profiles.stylix.targets.enable) {
    stylix.targets = {
      # 终端应用
      alacritty.enable = config.myHome.profiles.stylix.targets.terminals.alacritty.enable;
      kitty.enable = config.myHome.profiles.stylix.targets.terminals.kitty.enable;
      
      # 编辑器
      vim.enable = config.myHome.profiles.stylix.targets.editors.vim.enable;
      neovim.enable = config.myHome.profiles.stylix.targets.editors.neovim.enable;
      
      # 工具
      tmux.enable = config.myHome.profiles.stylix.targets.tools.tmux.enable;
      bat.enable = config.myHome.profiles.stylix.targets.tools.bat.enable;
      fzf.enable = config.myHome.profiles.stylix.targets.tools.fzf.enable;
      
      # 桌面环境
      gtk.enable = config.myHome.profiles.stylix.targets.desktop.gtk.enable;
      
      # 浏览器
      firefox.enable = config.myHome.profiles.stylix.targets.browsers.firefox.enable;
    };
    
    # 透明度配置
    stylix.opacity = {
      terminal = 0.9;
      popups = 0.8;
      desktop = 1.0;
    };
  };
}
