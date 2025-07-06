{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.touchpad;
  helpers = import ../lib/module-helpers.nix { inherit lib; };
in
{
  # 触摸板驱动模块 - 重构版本（所有功能合并在一个文件中）
  
  options.mySystem.services.drivers.touchpad = {
    enable = lib.mkEnableOption "触摸板驱动基础支持";
    
    # === 基础功能选项 ===
    basic = {
      tapping = lib.mkEnableOption "轻触点击" // { default = true; };
      clickMethod = lib.mkOption {
        type = lib.types.enum [ "buttonareas" "clickfinger" ];
        default = "clickfinger";
        description = "点击方式";
      };
    };
    
    # === 滚动选项 ===
    scrolling = {
      naturalScrolling = lib.mkEnableOption "自然滚动" // { default = true; };
      twoFingerScrolling = lib.mkEnableOption "双指滚动" // { default = true; };
      edgeScrolling = lib.mkEnableOption "边缘滚动";
      horizontalScrolling = lib.mkEnableOption "水平滚动" // { default = true; };
    };
    
    # === 手势选项 ===
    gestures = {
      multitouch = lib.mkEnableOption "多点触控手势";
      swipeGestures = lib.mkEnableOption "滑动手势";
      pinchZoom = lib.mkEnableOption "缩放手势";
    };
    
    # === 敏感度选项 ===
    sensitivity = {
      speed = lib.mkOption {
        type = lib.types.float;
        default = 0.0;
        description = "指针速度 (-1.0 到 1.0)";
      };
      acceleration = lib.mkOption {
        type = lib.types.enum [ "none" "adaptive" "flat" ];
        default = "adaptive";
        description = "加速配置";
      };
    };
  };
  
  # 实现部分 - 使用合并模式
  config = helpers.createMergedModule {
    inherit config;
    enable = cfg.enable;
    mergeConfigs = [
      # 核心 libinput 配置
      {
        services.libinput = {
          enable = true;
          touchpad = {
            # 基础功能
            tapping = cfg.basic.tapping;
            clickMethod = cfg.basic.clickMethod;
            
            # 滚动配置
            naturalScrolling = cfg.scrolling.naturalScrolling;
            twoFingerScroll = cfg.scrolling.twoFingerScrolling;
            edgeScrolling = cfg.scrolling.edgeScrolling;
            horizontalScrolling = cfg.scrolling.horizontalScrolling;
            
            # 敏感度配置
            accelSpeed = cfg.sensitivity.speed;
            accelProfile = cfg.sensitivity.acceleration;
            
            # 其他功能
            middleEmulation = true;
            disableWhileTyping = true;
          };
        };
      }
      
      # 系统软件包（所有功能的包合并在一起）
      (helpers.mergeSystemPackages [
        # 基础工具
        (with pkgs; [
          libinput          # libinput 工具
          xinput            # X11 输入设备配置
        ])
        
        # 手势工具（条件安装）
        (helpers.conditionalPackages cfg.gestures.multitouch (with pkgs; [
          libinput-gestures  # libinput 手势支持
          touchegg           # 触摸手势引擎
        ]))
      ])
      
      # 权限和 udev 规则
      {
        services.udev.extraRules = ''
          # 触摸板设备权限
          KERNEL=="event[0-9]*", ATTRS{name}=="*touchpad*", GROUP="input", MODE="0664"
          KERNEL=="event[0-9]*", ATTRS{name}=="*TrackPad*", GROUP="input", MODE="0664"
          
          # 手势设备权限（如果启用了手势）
          ${lib.optionalString cfg.gestures.multitouch ''
            KERNEL=="event[0-9]*", ATTRS{name}=="*touchpad*", TAG+="uaccess"
            KERNEL=="event[0-9]*", ATTRS{name}=="*TrackPad*", TAG+="uaccess"
          ''}
        '';
        
        # 手势用户组
        users.groups.input = lib.mkIf cfg.gestures.multitouch {};
      }
      
      # 系统服务（手势相关）
      (lib.mkIf cfg.gestures.multitouch {
        systemd.user.services.libinput-gestures = lib.mkIf cfg.gestures.swipeGestures {
          description = "Libinput Gestures";
          wantedBy = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          serviceConfig = {
            ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
            Restart = "on-failure";
            RestartSec = 1;
          };
        };
        
        systemd.user.services.touchegg = lib.mkIf cfg.gestures.pinchZoom {
          description = "Touchegg Daemon";
          wantedBy = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.touchegg}/bin/touchegg --daemon";
            Restart = "on-failure";
            RestartSec = 3;
          };
        };
      })
    ];
  };
}
