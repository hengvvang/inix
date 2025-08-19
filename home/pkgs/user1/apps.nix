{config, lib, pkgs, inputs, ...}:

{
    config = lib.mkIf config.myHome.pkgs.user1.enable {
        home.packages = with pkgs; [
            lazygit

            # 浏览器
            inputs.zen-browser.packages.${pkgs.system}.twilight

            # qutebrowser
            # google-chrome
            # firefox

            telegram-desktop
            discord
            qq

            spotify
            # cider-2
            # vlc (macOS 不支持)

            # clash-verge-rev
            # clash-nyanpasu

            # lutris (仅 Linux)
            # blender           # 3D 建模
            # gimp              # 图像编辑
            # inkscape          # 矢量图编辑
            # davinci-resolve   # 视频编辑 (需要 unfree)

            # virtualbox        # VirtualBox (需要 unfree)
            # gparted           # 分区工具

            zed-editor
            vscode
            # git
            # rio
            # zellij
            # rmpc
            # yazi
            # ghostty
            calcure
            # flameshot (仅 Linux)
            # satty (仅 Linux)
            mise
            just
            devenv
        ] ++ lib.optionals pkgs.stdenv.isLinux [
            # Linux 特有的应用
            flameshot         # 截图工具 (仅 Linux)
            satty             # 截图编辑工具 (仅 Linux)
            lutris            # 游戏启动器 (仅 Linux)
            vlc               # VLC 媒体播放器 (仅 Linux)
            wechat            # 微信 (仅 Linux x86_64)
            wpsoffice-cn      # WPS Office 中文版 (仅 Linux x86_64)
            libreoffice-qt6   # LibreOffice (仅 Linux)
        ];
    };
}
