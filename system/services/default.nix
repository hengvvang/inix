{ config, lib, pkgs, ... }:

{
  options.mySystem.services = {
    # 基础网络服务（单独配置）
    ssh = {
      enable = lib.mkEnableOption "SSH 服务配置";
    };
    
    # 媒体服务（单独配置）
    jellyfin = {
      enable = lib.mkEnableOption "Jellyfin 媒体服务器";
    };
    transmission = {
      enable = lib.mkEnableOption "Transmission BitTorrent 客户端";
    };
    
    # 存储和文件共享（单独配置）
    samba = {
      enable = lib.mkEnableOption "Samba 文件共享服务";
    };
    nfs = {
      enable = lib.mkEnableOption "NFS 网络文件系统";
    };
    syncthing = {
      enable = lib.mkEnableOption "Syncthing 文件同步服务";
    };
    
    # 硬件和系统服务（单独配置）
    printing = {
      enable = lib.mkEnableOption "CUPS 打印服务";
    };
    bluetooth = {
      enable = lib.mkEnableOption "蓝牙服务";
    };
    sound = {
      enable = lib.mkEnableOption "PipeWire 音频服务";
    };
  };

  imports = [
    # 模块化服务目录
    ./docker
    ./databases
    ./web
    ./network
    
    # 单文件服务
    ./ssh.nix
    ./jellyfin.nix
    ./transmission.nix
    ./samba.nix
    ./nfs.nix
    ./syncthing.nix
    ./printing.nix
    ./bluetooth.nix
    ./sound.nix
  ];
}
