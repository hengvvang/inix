{ config, pkgs, lib, ... }:

{
  # 此模块仅处理目标应用的配置实现
  # options 已在 default.nix 中定义
  
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
      
      # 输入法
      fcitx5.enable = config.myHome.profiles.stylix.targets.inputMethods.fcitx5.enable;
    };
    
    # 透明度配置
    stylix.opacity = {
      terminal = 0.9;
      popups = 0.8;
      desktop = 1.0;
    };
  };
}
