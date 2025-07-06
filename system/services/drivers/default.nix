{ config, lib, pkgs, ... }:

{
  options.mySystem.services.drivers = {
    enable = lib.mkEnableOption "硬件驱动服务总开关";
  };

  imports = [
    # === 真正原子化：每个驱动在自己的目录中定义所有选项 ===
    # 每个模块负责自己的选项定义和子功能实现
    
    # 显卡驱动模块
    ./nvidia         # NVIDIA 完整功能模块
    ./amd           # AMD 完整功能模块  
    ./intel         # Intel 完整功能模块
    
    # 音频驱动模块
    ./audio         # 音频完整功能模块
    
    # 输入设备驱动模块
    ./touchpad      # 触摸板完整功能模块
    ./wacom         # Wacom 完整功能模块
    
    # 网络驱动模块
    ./wifi          # WiFi 完整功能模块
    ./bluetooth     # 蓝牙完整功能模块
    ./ethernet      # 以太网完整功能模块
    
    # 存储驱动模块
    ./ssd           # SSD 完整功能模块
    ./usb           # USB 完整功能模块
    
    # 其他驱动模块
    ./printing      # 打印完整功能模块
  ];
}
