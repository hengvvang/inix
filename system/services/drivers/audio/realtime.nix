{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.audio.enable && config.mySystem.services.drivers.audio.realtime.enable) {
    # 启用实时工具包
    security.rtkit.enable = true;
    
    # 用户组配置
    users.users = lib.mapAttrs (name: user: {
      extraGroups = user.extraGroups ++ [ "audio" "realtime" ];
    }) config.users.users;
    
    # 实时优先级限制
    security.pam.loginLimits = [
      {
        domain = "@audio";
        type = "soft";
        item = "rtprio";
        value = toString config.mySystem.services.drivers.audio.realtime.priority;
      }
      {
        domain = "@audio";
        type = "hard";
        item = "rtprio";
        value = toString config.mySystem.services.drivers.audio.realtime.priority;
      }
      {
        domain = "@audio";
        type = "soft";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "@audio";
        type = "hard";
        item = "memlock";
        value = "unlimited";
      }
    ];

    # 低延迟内核参数
    boot.kernel.sysctl = lib.mkIf config.mySystem.services.drivers.audio.realtime.lowLatency {
      "vm.swappiness" = 10;
      "fs.inotify.max_user_watches" = 524288;
    };

    # 实时内核模块
    boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];
  };
}
