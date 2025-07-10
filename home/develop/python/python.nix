{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.develop.enable && config.myHome.develop.python.enable) {
    # Python 开发环境配置
    home.packages = with pkgs; [
      # Python 运行时
      python3                     # Python 3 解释器
      python3Packages.pip         # pip 包管理器
      python3Packages.virtualenv  # 虚拟环境管理
      
      # 开发工具
      python3Packages.black       # 代码格式化
      python3Packages.pytest      # 测试框架
      python3Packages.mypy        # 类型检查
      python3Packages.flake8      # 代码质量检查
    ];
  };
}
