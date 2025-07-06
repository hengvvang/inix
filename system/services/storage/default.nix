{ config, lib, pkgs, ... }:

{
  options.mySystem.services.storage = {
    samba.enable = lib.mkEnableOption "Samba 文件共享服务";
    nfs.enable = lib.mkEnableOption "NFS 网络文件系统";
    syncthing.enable = lib.mkEnableOption "Syncthing 文件同步服务";
  };

  imports = [
    ./samba
    ./nfs
    ./syncthing
  ];
}
