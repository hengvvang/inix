{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.develop.enable {
    environment.systemPackages = with pkgs; [
      vim             # Vim 编辑器
      vscode          # Visual Studio Code
      zed-editor      # Zed 编辑器
      git             # Git 版本控制
      rustup          # Rust 工具链
    ];
  };
}
