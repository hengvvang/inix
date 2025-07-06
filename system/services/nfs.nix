{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.nfs.enable {
    # NFS 网络文件系统配置
    services.nfs.server = {
      enable = true;
      
      # 导出配置
      exports = ''
        /export         192.168.0.0/24(rw,fsid=0,no_subtree_check)
        /export/public  192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
      '';
      
      # 创建导出根目录
      createMountPoints = true;
    };

    # 启用必要的 RPC 服务
    services.rpcbind.enable = true;

    # 防火墙配置
    networking.firewall = {
      allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
      allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
    };

    # 确保导出目录存在
    systemd.tmpfiles.rules = [
      "d /export 0755 root root -"
      "d /export/public 0755 nobody nobody -"
    ];

    # NFS 客户端支持（如果需要挂载其他 NFS 共享）
    services.rpcbind.enable = true;
    boot.supportedFilesystems = [ "nfs" ];
  };
}
