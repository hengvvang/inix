{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && 
                    config.myHome.dotfiles.rmpc.method == "direct") {
    home.packages = with pkgs; [ rmpc ];
    
    # 直接写入简化配置 - 仅作为演示配置方式
    home.file.".config/rmpc/config.ron".text = ''
      Config(
        // MPD 连接
        address: "127.0.0.1:6600",
        
        // 简化主题配置
        theme: Some(Theme(
          primary_color: Some("#7aa2f7"),
          background_color: Some("#1a1b26"),
          text_color: Some("#c0caf5"),
        )),
        
        // 基础键绑定
        keybinds: Some(KeyBinds(
          global: {
            "space": "TogglePause",
            "n": "NextSong", 
            "p": "PreviousSong",
            "+": "VolumeUp",
            "-": "VolumeDown",
            "q": "Quit",
          },
        )),
        
        // 基础配置
        volume_step: 5,
        scrolloff: 3,
      )
    '';
  };
}
