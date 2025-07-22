{ config, lib, pkgs, ... }:

let
    cfg = config.myHome.dotfiles.rmpc;
in
{
    config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "direct") {

        home.packages = with pkgs; [ rmpc ];
        
        home.file.".config/rmpc/config.ron".text = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            // 基础 MPD 连接
            address: "127.0.0.1:6600",
            password: None,
            
            // 简化配置
            theme: "rose-pine",
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
        
        home.file.".config/rmpc/themes/rose-pine.ron" =  {
            source = ./configs/themes/rose-pine.ron;
            executable = false;
        };
        
        home.file.".config/rmpc/themes/rose-pine-dawn.ron" =  {
            source = ./configs/themes/rose-pine-dawn.ron;
            executable = false;
        };
        
        home.file.".config/rmpc/themes/rose-pine-moon.ron" =  {
            source = ./configs/themes/rose-pine-moon.ron;
            executable = false;
        };
    };
}
