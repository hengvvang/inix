{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.flatpak;
in
{
  # Flatpak 服务实现
  config = lib.mkIf cfg.enable {
    # 核心 Flatpak 服务
    services.flatpak.enable = true;

    # XDG 门户支持
    xdg.portal = lib.mkIf cfg.xdgPortal {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # 系统工具包
    environment.systemPackages = with pkgs; [
      flatpak
    ];

    # 字体支持
    fonts.fontDir.enable = lib.mkIf cfg.fonts true;
    
    # 主题支持
    environment.sessionVariables = lib.mkIf cfg.themes {
      GTK_THEME = lib.mkDefault "Adwaita:dark";
    };

    # Flathub 远程仓库配置
    systemd.services.configure-flathub-repo = lib.mkIf cfg.flathub {
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

    # 用户权限配置
    users.users.hengvvang.extraGroups = [ "flatpak" ];
  };
}
