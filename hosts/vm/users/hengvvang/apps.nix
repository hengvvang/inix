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
    pkgs.wechat

    pkgs.mise
    pkgs.just
    pkgs.devenv
  ];
}
