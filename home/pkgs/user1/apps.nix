{config, lib, pkgs, inputs, ...}:

{
    config = lib.mkIf config.myHome.pkgs.user1.enable {
        home.packages = [
            inputs.zen-browser.packages.${pkgs.system}.twilight
            # pkgs.qutebrowser
            pkgs.google-chrome
            # pkgs.firefox

            # inputs.zed-editor.packages.${pkgs.system}.default
            pkgs.zed-editor
            pkgs.vscode

            pkgs.qq
            pkgs.discord
            pkgs.telegram-desktop

            pkgs.spotify

            pkgs.clash-verge-rev
            # pkgs.clash-nyanpasu

            # pkgs.blender           # 3D 建模
            # pkgs.gimp              # 图像编辑
            # pkgs.inkscape          # 矢量图编辑
            # pkgs.davinci-resolve   # 视频编辑 (需要 unfree)
            pkgs.kdePackages.kdenlive

            pkgs.calcure

            pkgs.mise
            pkgs.just
            pkgs.devenv

        ] ++ lib.optionals pkgs.stdenv.isLinux [
            # Linux 特有的应用
            pkgs.flameshot         # 截图工具 (仅 Linux)
            pkgs.satty             # 截图编辑工具 (仅 Linux)
            pkgs.lutris            # 游戏启动器 (仅 Linux)
            pkgs.vlc               # VLC 媒体播放器 (仅 Linux)
            pkgs.wechat            # 微信 (仅 Linux x86_64)
            pkgs.wpsoffice-cn      # WPS Office 中文版 (仅 Linux x86_64)
            pkgs.libreoffice-qt6   # LibreOffice (仅 Linux)
        ];
    };
}
