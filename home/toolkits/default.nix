{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.enable = lib.mkEnableOption "工具包模块" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.enable {
    # 工具包层默认值：用户工具常用，系统工具可选
    myHome.toolkits = {
      user.enable = lib.mkDefault true;      # 用户工具 - 默认开启
      system.enable = lib.mkDefault false;   # 系统工具 - 可选
    };
  };

  # 工具模块入口
  imports = [
    ./system
    ./user
  ];
}
