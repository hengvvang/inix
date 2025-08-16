{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.flatpak;
in
{
  config = lib.mkIf cfg.enable {

    services.flatpak = {
      enable = true;
      package = pkgs.flatpak;
    };

    # XDG 门户支持
    xdg.portal = lib.mkIf cfg.xdgPortal.enable {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # Flathub 远程仓库配置
    systemd.services.configure-flathub-repo = lib.mkIf cfg.flathub.enable {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };

    # 额外的远程仓库配置
    systemd.services.configure-extra-flatpak-repos = lib.mkIf (cfg.remotes != []) {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = lib.concatMapStringsSep "\n" (remote: ''
        flatpak remote-add --if-not-exists ${remote.name} ${remote.url}
      '') cfg.remotes;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };
  };
}
