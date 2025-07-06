{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # USB 管理工具
    environment.systemPackages = lib.optionals cfg.tools.management (with pkgs; [
      usbutils          # lsusb 等工具
      usb-modeswitch    # USB 模式切换
      udisks            # 磁盘管理
      pmount            # 用户空间挂载
    ]) ++ lib.optionals cfg.tools.debugging (with pkgs; [
      usbview           # USB 设备树查看器
      wireshark         # 网络协议分析（包含 USB）
      tcpdump           # 数据包捕获
    ]) ++ lib.optionals cfg.tools.security (with pkgs; [
      usbguard          # USB 设备控制
      lynis             # 安全审计
    ]) ++ lib.optionals cfg.tools.benchmark (with pkgs; [
      hdparm            # 硬盘性能测试
      bonnie            # 文件系统基准测试
      iozone            # I/O 性能测试
    ]);
    
    # USB 信息脚本
    environment.etc."usb-info.sh" = lib.mkIf cfg.tools.management {
      text = ''
        #!/bin/sh
        # USB 设备信息脚本
        echo "=== USB 设备列表 ==="
        lsusb -v 2>/dev/null | head -50
        
        echo -e "\n=== USB 存储设备 ==="
        lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E "(usb|sd[a-z])"
        
        echo -e "\n=== USB 设备树 ==="
        lsusb -t
        
        echo -e "\n=== dmesg USB 信息 ==="
        dmesg | grep -i usb | tail -10
      '';
      mode = "0755";
    };
    
    # USB 诊断脚本
    environment.etc."usb-diagnostic.sh" = lib.mkIf cfg.tools.debugging {
      text = ''
        #!/bin/sh
        # USB 诊断脚本
        echo "=== USB 诊断信息 ==="
        
        echo "USB 控制器信息:"
        lspci | grep -i usb
        
        echo -e "\nUSB 设备详细信息:"
        for device in /dev/bus/usb/*/*; do
          if [ -r "$device" ]; then
            echo "设备: $device"
            usbhid-dump -d "$device" 2>/dev/null | head -5
            echo "---"
          fi
        done
        
        echo -e "\nUSB 相关内核模块:"
        lsmod | grep -i usb
      '';
      mode = "0755";
    };
    
    # USB 性能测试脚本
    environment.etc."usb-benchmark.sh" = lib.mkIf cfg.tools.benchmark {
      text = ''
        #!/bin/sh
        # USB 性能测试脚本
        echo "=== USB 存储设备性能测试 ==="
        
        # 查找 USB 存储设备
        USB_DEVICES=$(lsblk -no NAME,TRAN | grep usb | awk '{print $1}')
        
        if [ -z "$USB_DEVICES" ]; then
          echo "未找到 USB 存储设备"
          exit 1
        fi
        
        for device in $USB_DEVICES; do
          echo "测试设备: /dev/$device"
          
          # 读取测试
          echo "读取性能测试..."
          hdparm -t "/dev/$device" 2>/dev/null || echo "读取测试失败"
          
          # 缓存读取测试
          echo "缓存读取测试..."
          hdparm -T "/dev/$device" 2>/dev/null || echo "缓存测试失败"
          
          echo "---"
        done
      '';
      mode = "0755";
    };
  };
}
