{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
  
  # 主题文件映射
  rosePineTheme = ./configs/themes/rose-pine.ron;
  rosePineDawnTheme = ./configs/themes/rose-pine-dawn.ron;
  rosePineMoonTheme = ./configs/themes/rose-pine-moon.ron;
  
  # 根据主题选择确定主题配置
  themeConfig = if cfg.theme == "default" then null else cfg.theme;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && 
                    config.myHome.dotfiles.rmpc.method == "direct") {
    home.packages = with pkgs; [ rmpc ];
    
    # 直接写入简化配置 - 仅作为演示配置方式
    home.file.".config/rmpc/config.ron".text = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
        // 基础 MPD 连接
        address: "127.0.0.1:6600",
        password: None,
        
        // 简化配置
        theme: ${if themeConfig != null then ''"${themeConfig}"'' else "None"},
        volume_step: 5,
        scrolloff: 3,
        wrap_navigation: true,
        enable_mouse: true,
        
        // 基础键绑定
        keybinds: (
          global: {
            "p":       TogglePause,
            "q":       Quit,
            ">":       NextTrack,
            "<":       PreviousTrack,
            "+":       VolumeUp,
            "-":       VolumeDown,
            "1":       SwitchToTab("Queue"),
            "2":       SwitchToTab("Search"),
          },
          navigation: {
            "j":       Down,
            "k":       Up,
            "<CR>":    Confirm,
            "<Esc>":   Close,
          },
          queue: {
            "<CR>":    Play,
            "d":       Delete,
          },
        ),
      )
    '';
    
    # 主题文件 - 根据选择复制对应主题
    home.file.".config/rmpc/themes/rose-pine.ron" = lib.mkIf (cfg.theme == "rose-pine") {
      source = rosePineTheme;
    };
    
    home.file.".config/rmpc/themes/rose-pine-dawn.ron" = lib.mkIf (cfg.theme == "rose-pine-dawn") {
      source = rosePineDawnTheme;
    };
    
    home.file.".config/rmpc/themes/rose-pine-moon.ron" = lib.mkIf (cfg.theme == "rose-pine-moon") {
      source = rosePineMoonTheme;
    };
  };
}
