{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.compose.enable) {
    # Compose 工具
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
