{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.users.enable {
    # 用户配置
    users.users.hengvvang = {
      isNormalUser = true;
      description = "hengvvang";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        # 用户特定的包可以在这里定义
      ];
    };
    
    users.users.zlritsu = {
      isNormalUser = true;
      description = "zlritsu";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        # 用户特定的包可以在这里定义
      ];
    };
  };
}
