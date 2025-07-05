{ config, lib, pkgs, ... }:

{
  # 开发环境核心模块
  imports = lib.optionals config.myHome.development.versionControl.enable [
    ./version-control
  ] ++ lib.optionals config.myHome.development.languages.enable [
    ./languages
  ] ++ lib.optionals config.myHome.development.embedded.enable [
    ./embedded
  ];
}
