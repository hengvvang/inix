{ config, lib, pkgs, ... }:

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
        theme: None,
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
  };
}
