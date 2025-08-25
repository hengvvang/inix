{ config, lib, pkgs, ... }:

{
  # Host2 (work) 硬件配置
  
  # 设置系统架构
  nixpkgs.hostPlatform = "aarch64-linux";
  
  # 启用基础硬件支持
  hardware.enableAllFirmware = true;
  
  # 如果需要特定硬件配置，在这里添加
}
