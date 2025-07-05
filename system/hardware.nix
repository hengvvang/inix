{ config, lib, pkgs, ... }:

{
  options.mySystem.hardware.enable = lib.mkEnableOption "硬件配置" // {
    default = false;
  };

  config = lib.mkIf config.mySystem.hardware.enable {
  # NVIDIA 显卡配置
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;               # 使用闭源驱动
    nvidiaSettings = true;      # 安装 nvidia-settings 图形工具
  };

  # 音频配置
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 触摸板支持
  services.libinput.enable = true;

  # 打印支持
  services.printing.enable = true;
  };
}
