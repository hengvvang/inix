{ config, lib, pkgs, ... }:

{
  options.myHome.development.enable = lib.mkEnableOption "开发环境模块" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.enable {
    # 开发环境层默认值：版本控制必需，语言支持推荐，嵌入式可选
    myHome.development = {
      versionControl.enable = lib.mkDefault true;   # Git等版本控制 - 必需
      languages.enable = lib.mkDefault true;        # 编程语言支持 - 推荐
      embedded.enable = lib.mkDefault false;        # 嵌入式开发 - 可选
    };
  };

  # 开发环境核心模块
  imports = [
    ./version-control
    ./languages
    ./embedded
  ];
}
