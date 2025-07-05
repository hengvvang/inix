{ config, lib, pkgs, ... }:

{
  # C 开发环境 - 简化版
  home.packages = with pkgs; [
    # C 编译器
    gcc                  # GNU 编译器套件
    clang                # LLVM C 编译器
    
    # 构建工具
    cmake                # 跨平台构建系统
    gnumake              # GNU Make
    
    # 调试器
    gdb                  # GNU 调试器
  ];
}
