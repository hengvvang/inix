{ config, lib, pkgs, ... }:

{
  options.myHome.development.versionControl = {
    git = lib.mkEnableOption "Git 版本控制";
    lazygit = lib.mkEnableOption "Lazygit 终端 Git UI";
  };

  imports = [
    ./git.nix
    ./lazygit.nix
  ];
}