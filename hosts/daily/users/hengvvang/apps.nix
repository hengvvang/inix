{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    # inputs.zen-browser.packages.${pkgs.system}.twilight
    # pkgs.google-chrome
    pkgs.firefox

    # inputs.zed-editor.packages.${pkgs.system}.default
    pkgs.zed-editor
    pkgs.vscode

    pkgs.qq
    pkgs.wechat
    pkgs.discord
    pkgs.element-desktop
    pkgs.telegram-desktop

    #
    # toolkits
    #
    nh
    nix-output-monitor
    nix-tree
    nixos-rebuild
    nvd
  ];
}
