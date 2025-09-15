{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    pkgs.vscode

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
