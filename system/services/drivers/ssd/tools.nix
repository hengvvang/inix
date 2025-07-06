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
  };
}
