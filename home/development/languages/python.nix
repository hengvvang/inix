{ config, lib, pkgs, ... }:

{
  options = {
    myHome.development.languages.python.enable = lib.mkEnableOption "Python 开发环境";
  };

  config = lib.mkIf config.myHome.development.languages.python.enable {
    # Python 开发环境 - 简化版
    home.packages = with pkgs; [
    # Python 运行时
    python3                        # Python 3 解释器
    python3Packages.pip           # pip 包管理器
    python3Packages.virtualenv    # 虚拟环境管理
    
    # 开发工具
    python3Packages.black         # 代码格式化
    python3Packages.pytest       # 测试框架
  ];
  };
}
