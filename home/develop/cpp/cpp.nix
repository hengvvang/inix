{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基本 C/C++ 配置
    (lib.mkIf (config.myHome.develop.enable && config.myHome.develop.cpp.enable) {
      # C/C++ 核心开发环境
      home.packages = with pkgs; [
        # 编译器
        gcc                  # GNU 编译器套件
        
        # 构建工具
        cmake                # 现代构建系统
        gnumake              # GNU Make
        
        # 调试器
        (lib.hiPrio gdb)     # GNU 调试器，高优先级确保这是主要的 gdb
        
        # 代码分析和格式化
        clang-tools          # 包含 clang-format 等工具
        
        # 基础库
        boost                # Boost C++ 库
      ];
    })
    
    # C/C++ 嵌入式开发配置
    (lib.mkIf (config.myHome.develop.enable && config.myHome.develop.cpp.enable && config.myHome.develop.cpp.embedded.enable) {
      home.packages = with pkgs; [
        # ARM 工具链
        (pkgs.buildEnv {
          name = "arm-embedded-toolchain";
          paths = [ gcc-arm-embedded ];
          ignoreCollisions = true;
          pathsToLink = [ "/bin" "/include" "/lib" "/libexec" ];
        })
        
        # 嵌入式开发工具
        openocd              # 片上调试器
        
        # 串口工具
        minicom              # 串口终端
        picocom              # 轻量串口工具
        
        # 二进制分析
        binutils             # 二进制工具集
        hexdump              # 十六进制查看
      ];
    })
  ];
}
