{ config, lib, pkgs, ... }:

{
  imports = [
    # 模块化服务目录
    ./docker
    ./network
    ./media
    ./sync
    ./drivers  # 所有硬件功能已迁移到drivers中，实现原子化配置
  ];
}
