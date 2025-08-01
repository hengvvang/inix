# Hardware configuration for daily host (macOS)
{ config, lib, pkgs, ... }:

{
  # macOS系统配置
  # 注意：macOS下不需要文件系统配置

  # 网络配置
  networking.computerName = "daily";
  networking.hostName = "daily";
  networking.localHostName = "daily";

  # CPU 架构
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
