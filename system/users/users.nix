{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.users {
    # 用户配置
    users.users.hengvvang = {
      isNormalUser = true;
      description = "hengvvang";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        # 用户特定的包可以在这里定义
      ];
      shell = pkgs.fish;
    };

    # Fish shell 配置
    programs.fish.enable = true;

    # Docker 配置
    virtualisation.docker.enable = true;

    # SSH 配置
    services.openssh.enable = true;
  };
}
