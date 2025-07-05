{ config, lib, pkgs, ... }:

{
  # 嵌入式开发环境配置
  home.packages = with pkgs; [
    # ARM 嵌入式开发工具链
    gcc-arm-embedded        # ARM GCC 工具链
    openocd                 # 开源片上调试器
    gdb                     # GDB 调试器 (支持多目标)
    
    # RISC-V 嵌入式开发
    pkgsCross.riscv64-embedded.buildPackages.gcc
    
    # 嵌入式开发工具
    minicom                 # 串口终端工具
    screen                  # 终端复用器 (也可用于串口)
    picocom                 # 轻量级串口工具
    
    # 硬件相关工具
    sigrok-cli              # 逻辑分析仪命令行工具
    pulseview               # 逻辑分析仪图形界面
    
    # 固件工具
    dfu-util                # DFU (Device Firmware Update) 工具
    avrdude                 # AVR 微控制器编程工具
    stlink                  # STM32 编程和调试工具
    
    # 嵌入式仿真器
    qemu                    # 系统仿真器
    
    # 二进制分析工具
    binutils                # 二进制工具集 (包含 objdump, nm, readelf 等)
    hexdump                 # 十六进制查看器
    xxd                     # 十六进制编辑器
    
    # 嵌入式文档工具
    graphviz                # 图形绘制工具
    plantuml                # UML 图表工具
  ];

  # Rust 嵌入式开发
  home.sessionVariables = {
    # Rust 嵌入式目标支持
    CARGO_TARGET_THUMBV7EM_NONE_EABIHF_RUNNER = "gdb-multiarch";
    CARGO_TARGET_THUMBV6M_NONE_EABI_RUNNER = "gdb-multiarch";
  };

  # 嵌入式开发别名
  home.shellAliases = {
    # 串口工具
    serial = "minicom -D";
    ttyusb = "ls /dev/ttyUSB* /dev/ttyACM*";
    
    # 二进制分析
    objdump-arm = "arm-none-eabi-objdump";
    size-arm = "arm-none-eabi-size";
    
    # 嵌入式构建
    cargo-embed = "cargo embed";
    cargo-flash = "cargo flash";
    
    # OpenOCD 常用命令
    openocd-stlink = "openocd -f interface/stlink.cfg";
    openocd-jlink = "openocd -f interface/jlink.cfg";
  };

  # 创建嵌入式开发脚本
  home.file.".local/bin/embed-setup".text = ''
    #!/bin/bash
    # 嵌入式开发环境设置脚本
    
    echo "🔧 设置嵌入式开发环境..."
    
    # 检查串口设备
    echo "📡 可用串口设备:"
    ls /dev/tty{USB,ACM}* 2>/dev/null || echo "未找到串口设备"
    
    # 检查调试器连接
    echo "🔍 检查调试器连接:"
    lsusb | grep -E "(ST-LINK|J-Link|CMSIS-DAP)" || echo "未找到调试器"
    
    # Rust 嵌入式目标检查
    echo "🦀 Rust 嵌入式目标:"
    rustup target list --installed | grep -E "(thumbv|riscv)" || echo "请安装嵌入式目标: rustup target add thumbv7em-none-eabihf"
    
    echo "✅ 嵌入式开发环境检查完成!"
  '';

  # OpenOCD 配置文件
  home.file.".config/openocd/stm32f4.cfg".text = ''
    # STM32F4 OpenOCD 配置
    source [find interface/stlink.cfg]
    source [find target/stm32f4x.cfg]
    
    # 配置选项
    adapter speed 1000
    
    # 重置配置
    reset_config srst_only
  '';
}
