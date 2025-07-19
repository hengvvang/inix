{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "direct") {
    # 直接安装 Rio 包
    home.packages = with pkgs; [ rio ];
    
    # 直接文件写入 - 演示用简化配置
    home.file.".config/rio/config.toml".text = ''
      # Rio Terminal 简化配置
      
      # 基础窗口设置
      [window]
      width = 100
      height = 30
      opacity = 0.95
      decorations = "Enabled"
      
      # 简单字体设置
      [fonts]
      family = "FiraCode Nerd Font"
      size = 13
      
      [fonts.extras]
      ligatures = true
      
      # Shell 设置
      [shell]
      program = "${pkgs.fish}/bin/fish"
      
      # 基础环境变量
      [env]
      TERM = "xterm-256color"
      
      # 简化的 Catppuccin 主题
      [colors]
      background = "#1e1e2e"
      foreground = "#cdd6f4"
      cursor = "#f5e0dc"
      
      [colors.normal]
      black = "#45475a"
      red = "#f38ba8"
      green = "#a6e3a1"
      yellow = "#f9e2af"
      blue = "#89b4fa"
      magenta = "#f5c2e7"
      cyan = "#94e2d5"
      white = "#bac2de"
      
      [colors.bright]
      black = "#585b70"
      red = "#f38ba8"
      green = "#a6e3a1"
      yellow = "#f9e2af"
      blue = "#89b4fa"
      magenta = "#f5c2e7"
      cyan = "#94e2d5"
      white = "#a6adc8"
      
      # 基础键绑定
      [bindings]
      [bindings.keys]
      { key = "c", mods = "control|shift", action = "Copy" }
      { key = "v", mods = "control|shift", action = "Paste" }
      { key = "plus", mods = "control", action = "IncreaseFontSize" }
      { key = "minus", mods = "control", action = "DecreaseFontSize" }
      { key = "0", mods = "control", action = "ResetFontSize" }
      { key = "f11", action = "ToggleFullscreen" }
      
      # 基础行为设置
      [behavior]
      confirm-before-quit = false
      hide-cursor-when-typing = true
      
      # 光标设置
      [cursor]
      style = "Block"
      blinking = true
      
      # 滚动设置
      [scroll]
      history = 5000
      auto-scroll = true
    '';
    
    # 简单的 Shell 集成
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # 简单的 Rio 检测
      if test "$TERM_PROGRAM" = "rio"
        set -gx COLORTERM truecolor
        alias rio-config="$EDITOR ~/.config/rio/config.toml"
      end
    '';
  };
}
