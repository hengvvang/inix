{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    pkgs.vscode
    pkgs.mise
    pkgs.just
    pkgs.devenv
    # pkgs.mihomo
  ];
}
