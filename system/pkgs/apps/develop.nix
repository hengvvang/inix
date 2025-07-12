{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.develop.enable {
    environment.systemPackages = with pkgs; [
      vim             # Vim 编辑器
      git             # Git 版本控制
    ];
  };
}
