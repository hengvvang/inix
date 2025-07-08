{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.develop.languages.cpp.enable {
    # C++ 核心开发环境 - 简化版
    home.packages = with pkgs; [
    # C++ 编译器
    gcc                  # GNU 编译器套件
    
    # 构建工具
    cmake                # 现代构建系统
    gnumake              # GNU Make
    
    # 调试器 - 高优先级，确保这是主要的 gdb
    (lib.hiPrio gdb)     # GNU 调试器
    
    # 代码格式化
    clang-tools          # 包含 clang-format 等工具
    
    # 基础库
    boost                # Boost C++ 库
  ];
  };
}
