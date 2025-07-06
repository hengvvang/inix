{ config, lib, pkgs, ... }:

{
  options.myHome.development.versionControl = {
    git.enable = lib.mkEnableOption "Git 版本控制";
    lazygit.enable = lib.mkEnableOption "Lazygit 终端 Git UI";
  };

  imports = [
    ./git.nix
    ./lazygit.nix
  ];
}