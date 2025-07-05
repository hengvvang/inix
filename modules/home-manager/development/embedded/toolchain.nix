{ config, lib, pkgs, ... }:

{
  # 嵌入式开发环境配置模块
  home.packages = with pkgs; [
    # ARM 工具链
    gcc-arm-embedded     # ARM GCC 编译器
    openocd              # 片上调试器
    
    # 调试工具
    gdb                  # 调试器
    
    # 串口工具
    minicom              # 串口终端
    picocom              # 轻量串口工具
    
    # 二进制分析
    binutils             # 二进制工具集
    hexdump              # 十六进制查看
  ];
  
  # 嵌入式开发别名
  home.shellAliases = {
    # 串口连接
    serial = "minicom -D";
    serial-115200 = "minicom -D /dev/ttyUSB0 -b 115200";
    
    # OpenOCD
    ocd = "openocd";
    
    # 二进制分析
    hexdump16 = "hexdump -C";
    objdump-arm = "arm-none-eabi-objdump";
    
    # ARM 编译
    arm-gcc = "arm-none-eabi-gcc";
    arm-gdb = "arm-none-eabi-gdb";
  };
}
