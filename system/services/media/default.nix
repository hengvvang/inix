{ config, lib, pkgs, ... }:

{
  options.mySystem.services.media = {
    enable = lib.mkEnableOption "媒体服务";
    players.enable = lib.mkEnableOption "媒体播放器";
    # 其他功能暂时禁用，只保留已实现的players
    # editing.enable = lib.mkEnableOption "媒体编辑工具";
    # streaming.enable = lib.mkEnableOption "流媒体工具";
    # download.enable = lib.mkEnableOption "下载工具";
  };

  imports = [
    ./players  # 引用players目录
    # 其他模块待实现
    # ./editing
    # ./streaming
    # ./download
  ];
}
