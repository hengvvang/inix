{config, lib, pkgs, inputs, ...}:

{
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

    # pkgs.clash-verge-rev
    # pkgs.mihomo
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

    pkgs.flameshot
    pkgs.satty
    pkgs.lutris
    pkgs.vlc
    pkgs.wechat
    pkgs.wpsoffice-cn
    pkgs.libreoffice-qt6
  ];
}
