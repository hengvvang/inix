{ config, pkgs, lib, ... }:

{
  options.myHome.profiles.theme.targets = {
    # 终端和编辑器
    kitty.enable = lib.mkEnableOption "Kitty 主题支持";
    alacritty.enable = lib.mkEnableOption "Alacritty 主题支持";
    tmux.enable = lib.mkEnableOption "Tmux 主题支持";
    vim.enable = lib.mkEnableOption "Vim 主题支持";
    neovim.enable = lib.mkEnableOption "Neovim 主题支持";
    
    # 桌面环境
    gtk.enable = lib.mkEnableOption "GTK 主题支持";
    
    # 浏览器
    firefox.enable = lib.mkEnableOption "Firefox 主题支持";
    
    # 开发工具
    bat.enable = lib.mkEnableOption "Bat 主题支持";
    fzf.enable = lib.mkEnableOption "Fzf 主题支持";
  };

  config = lib.mkIf config.myHome.profiles.theme.enable {
    stylix = {
      # 目标应用程序配置
      targets = {
        # 终端和编辑器
        kitty.enable = config.myHome.profiles.theme.targets.kitty.enable;
        alacritty.enable = config.myHome.profiles.theme.targets.alacritty.enable;
        tmux.enable = config.myHome.profiles.theme.targets.tmux.enable;
        vim.enable = config.myHome.profiles.theme.targets.vim.enable;
        neovim.enable = config.myHome.profiles.theme.targets.neovim.enable;
        
        # 桌面环境
        gtk.enable = config.myHome.profiles.theme.targets.gtk.enable;
        
        # 浏览器
        firefox.enable = config.myHome.profiles.theme.targets.firefox.enable;
        
        # 开发工具
        bat.enable = config.myHome.profiles.theme.targets.bat.enable;
        fzf.enable = config.myHome.profiles.theme.targets.fzf.enable;
      };
      
      # 透明度设置
      opacity = {
        terminal = 0.9;
        popups = 0.8;
        desktop = 1.0;
      };
    };
  };
}
