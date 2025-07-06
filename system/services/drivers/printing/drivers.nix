{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.printing;
in
{
  config = lib.mkIf cfg.enable {
    # 打印机驱动程序合并
    services.printing.drivers = lib.flatten [
      # HP 打印机驱动
      (lib.optionals cfg.drivers.hp (with pkgs; [
        hplip
        hplipWithPlugin
      ]))
      # Canon 打印机驱动
      (lib.optionals cfg.drivers.canon (with pkgs; [
        canon-cups-ufr2
        cnijfilter2
      ]))
      # Epson 打印机驱动
      (lib.optionals cfg.drivers.epson (with pkgs; [
        epson-escpr
        epson-escpr2
      ]))
      # Brother 打印机驱动
      (lib.optionals cfg.drivers.brother (with pkgs; [
        brlaser
        brother-cups-wrapper
      ]))
      # 通用打印驱动
      (lib.optionals cfg.drivers.generic (with pkgs; [
        cups-filters
        foomatic-filters
        ghostscript
        gutenprint
      ]))
    ];
    
    # 驱动相关工具
    environment.systemPackages = lib.mkMerge [
      (lib.mkIf cfg.drivers.hp (with pkgs; [
        hplip       # HP 打印机管理工具
      ]))
      
      (lib.mkIf cfg.drivers.canon (with pkgs; [
        canon-cups-ufr2
      ]))
      
      (lib.mkIf cfg.drivers.epson (with pkgs; [
        epson-escpr
      ]))
      
      (lib.mkIf cfg.drivers.brother (with pkgs; [
        brlaser
      ]))
    ];
  };
}
