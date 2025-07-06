{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ssd;
in
{
  config = lib.mkIf cfg.enable {
    # NVMe 管理工具
    environment.systemPackages = lib.optionals cfg.tools.nvme (with pkgs; [
      nvme-cli         # NVMe 命令行工具
      smartmontools    # SMART 监控工具
    ]) ++ lib.optionals cfg.tools.analysis (with pkgs; [
      hdparm          # 硬盘参数工具
      sdparm          # SCSI 设备参数
      sg3_utils       # SCSI 通用工具
    ]) ++ lib.optionals cfg.tools.benchmark (with pkgs; [
      fio             # 灵活 I/O 测试器
      bonnie          # 文件系统基准测试
      iozone          # 文件系统基准测试
    ]) ++ lib.optionals cfg.tools.maintenance (with pkgs; [
      parted          # 分区工具
      gptfdisk        # GPT 分区工具
      e2fsprogs       # ext 文件系统工具
    ]);
    
    # SSD 测试脚本
    environment.etc."ssd-benchmark.sh" = lib.mkIf cfg.tools.benchmark {
      text = ''
        #!/bin/sh
        # SSD 性能测试脚本
        echo "=== SSD 性能测试 ==="
        
        # 创建测试目录
        TEST_DIR="/tmp/ssd-test"
        mkdir -p "$TEST_DIR"
        
        echo "顺序读写测试..."
        fio --name=seq-read --rw=read --bs=1M --size=1G --directory="$TEST_DIR" --runtime=30 --time_based --group_reporting
        
        echo "随机读写测试..."
        fio --name=rand-rw --rw=randrw --bs=4k --size=1G --directory="$TEST_DIR" --runtime=30 --time_based --group_reporting
        
        # 清理测试文件
        rm -rf "$TEST_DIR"
      '';
      mode = "0755";
    };
    
    # SSD 维护脚本
    environment.etc."ssd-maintenance.sh" = lib.mkIf cfg.tools.maintenance {
      text = ''
        #!/bin/sh
        # SSD 维护脚本
        echo "=== SSD 维护工具 ==="
        
        echo "TRIM 状态检查..."
        fstrim -v / 2>/dev/null || echo "TRIM 不支持或已禁用"
        
        echo "SSD 健康状态..."
        smartctl -H /dev/nvme0n1 2>/dev/null || smartctl -H /dev/sda
        
        echo "SSD 信息..."
        nvme list 2>/dev/null || echo "未检测到 NVMe 设备"
      '';
      mode = "0755";
    };
    
    # NVMe 设备信息脚本
    environment.etc."nvme-info.sh" = lib.mkIf cfg.tools.nvme {
      text = ''
        #!/bin/sh
        # NVMe 设备信息脚本
        echo "=== NVMe 设备信息 ==="
        nvme list
        
        echo -e "\n=== NVMe 智能信息 ==="
        for dev in /dev/nvme*n1; do
          if [ -e "$dev" ]; then
            echo "设备: $dev"
            nvme smart-log "$dev"
            echo "---"
          fi
        done
      '';
      mode = "0755";
    };
  };
}
