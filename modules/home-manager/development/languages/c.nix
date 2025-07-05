{ config, lib, pkgs, ... }:

{
  # C/C++ 开发环境配置模块 - 简化版
  home.packages = with pkgs; [
    # 编译器
    gcc                  # GNU 编译器集合
    clang                # LLVM C/C++ 编译器
    
    # 构建工具
    cmake                # 跨平台构建系统
    make                 # GNU Make
    ninja                # 快速构建系统
    pkg-config           # 库配置工具
    
    # 调试工具
    gdb                  # GNU 调试器
    lldb                 # LLVM 调试器
    valgrind             # 内存分析工具
    
    # 语言服务器
    clang-tools          # clangd LSP 服务器
    
    # 代码格式化
    clang-tools          # 包含 clang-format
  ];
  
  # C/C++ 别名
  home.shellAliases = {
    # 编译快捷方式
    gcc-debug = "gcc -g -Wall -Wextra -std=c11";
    "g++-debug" = "g++ -g -Wall -Wextra -std=c++17";
    clang-debug = "clang -g -Wall -Wextra -std=c11";
    "clang++-debug" = "clang++ -g -Wall -Wextra -std=c++17";
    
    # 构建
    mk = "make";
    mkj = "make -j$(nproc)";
    cm = "cmake";
    cmb = "cmake --build";
    
    # 调试
    gdb-run = "gdb -ex run --args";
    valgrind-mem = "valgrind --leak-check=full --show-leak-kinds=all";
  };
}
