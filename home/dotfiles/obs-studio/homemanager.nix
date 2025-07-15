{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && 
                     config.myHome.dotfiles.obs-studio.method == "homemanager") {
    programs.obs-studio = {
      enable = true;

      # optional Nvidia hardware acceleration
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi #optional AMD hardware acceleration
        obs-gstreamer
        obs-vkcapture
      ];
    };
    # 最简配置：只配置插件和基本设置
    # home.file = {
    #   # Input Overlay 插件基础配置
    #   ".config/obs-studio/plugin_config/input-overlay/layout.json".text = builtins.toJSON {
    #     mouse = {
    #       enable = true;
    #       position = { x = 10; y = 10; };
    #     };
    #     keyboard = {
    #       enable = true;
    #       position = { x = 10; y = 100; };
    #       layout = "qwerty";
    #     };
    #   };
      
    #   # 基础快捷键
    #   ".config/obs-studio/basic/profiles/Untitled/basic.ini".text = ''
    #     [Hotkeys]
    #     OBSBasic.StartRecording=F10
    #     OBSBasic.StopRecording=F10
    #     OBSBasic.Screenshot=F8
    #   '';
    # };
  };
}
