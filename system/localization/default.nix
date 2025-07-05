{ config, lib, pkgs, ... }:

{
  # 选项已经在各子模块中定义，这里只做导入
  imports = [
    ./timeZone
    ./inputMethod
  ];
}