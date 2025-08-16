{config, lib, pkgs, ...}:

{
    config = lib.mkIf config.myHome.pkgs.user2.enable {
        home.packages = with pkgs; [
            lazygit

            # qutebrowser
            # google-chrome
            # firefox

            telegram-desktop
            discord
            qq
            wechat
            wpsoffice-cn

            spotify
            # cider-2
            vlc

            # clash-verge-rev
            # clash-nyanpasu

            lutris
            # blender           # 3D 建模
            # gimp              # 图像编辑
            # inkscape          # 矢量图编辑
            # davinci-resolve   # 视频编辑 (需要 unfree)

            # virtualbox        # VirtualBox (需要 unfree)
            # gparted           # 分区工具

            # vim
            zed-editor
            vscode
            # git
            # rio
            # zellij
            # rmpc
            # yazi
            # ghostty
            calcure
            flameshot
            satty
            mise
            just
            devenv
        ];
    };
}
