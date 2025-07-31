{config, lib, pkgs, ...}:

{
    config = lib.mkIf config.myHome.pkgs.apps.enable {
        home.packages = with pkgs; [

            ghostty

            lazygit

            qutebrowser
            
            #google-chrome
            #firefox
            
            telegram-desktop
            discord
            #qq
            #wechat
            
            wpsoffice-cn
            pot
            
            spotify
            vlc
            rmpc
            # clash-verge-rev   # 代理工具（主要）
            # clash-nyanpasu    # 代理工具（备用）
            # clash-meta        # Clash 内核
            
            # steam
            # lutris
            
            # blender           # 3D 建模
            # gimp              # 图像编辑
            # inkscape          # 矢量图编辑
            # davinci-resolve   # 视频编辑 (需要 unfree)
            
            # virtualbox        # VirtualBox (需要 unfree)
            
            # 系统工具
            # gparted           # 分区工具
        ];
        programs.obs-studio = {
            enable = true;
            plugins = with pkgs.obs-studio-plugins; [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
            ];
        };
    };
}
