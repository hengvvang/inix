{ config, lib, pkgs, ... }:

{
  options.mySystem.services.drivers = {
    enable = lib.mkEnableOption "硬件驱动服务总开关";
  };

  imports = [
    # === GPU 显卡驱动模块 ===
    ./nvidia         # NVIDIA 独立显卡驱动 (RTX/GTX 系列)
    ./amd           # AMD 显卡驱动 (Radeon/RX 系列)  
    ./intel         # Intel 集成显卡驱动
    
    # === 音频系统驱动模块 ===
    ./audio         # 音频驱动 (PipeWire + ALSA + 控制工具)
    
    # === 输入设备驱动模块 ===
    ./touchpad      # 笔记本触摸板驱动 (libinput + 手势支持)
    ./wacom         # Wacom 数位板驱动 (专业绘图设备)
    
    # === 网络连接驱动模块 ===
    ./wifi          # WiFi 无线网络驱动 (NetworkManager)
    ./bluetooth     # 蓝牙设备驱动 (音频 + 输入设备)
    ./ethernet      # 有线网络驱动 (以太网接口)
    
    # === 存储设备驱动模块 ===
    ./ssd           # SSD 固态硬盘优化 (TRIM + 性能调优)
    ./usb           # USB 设备驱动 (存储 + 外设支持)
    
    # === 外设设备驱动模块 ===
    ./printing      # 打印机驱动 (CUPS + 扫描仪)
  ];
}
