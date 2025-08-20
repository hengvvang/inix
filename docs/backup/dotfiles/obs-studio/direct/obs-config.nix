{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "direct") {
    
    home.file.".config/obs-studio/global.ini" = {
      text = ''
        [General]
        Name=Default
        
        [Video]
        BaseCX=1920
        BaseCY=1080
        OutputCX=1920
        OutputCY=1080
        FPSType=0
        FPSCommon=30
        
        [Audio]
        SampleRate=44100
        ChannelSetup=Stereo
        
        [Output]
        Mode=Simple
        FilePath=${config.home.homeDirectory}/Videos
        RecFormat=mkv
        RecEncoder=x264
        RecQuality=0
        RecRescale=false
        RecRescaleRes=1280x720
        
        [Stream]
        StreamEncoder=x264
        ABitrate=160
        VBitrate=2500
        Rescale=false
        RescaleRes=1280x720
        
        [AdvOut]
        TrackIndex=1
        RecType=Standard
        RecFilePath=${config.home.homeDirectory}/Videos
        RecFormat=mkv
        RecEncoder=none
        RecMuxerCustom=
        RecSplitFile=false
        RecSplitFileTime=15
        RecSplitFileSize=2048
        
        [Hotkeys]
        OBSBasic.StartRecording=
        OBSBasic.StopRecording=
        OBSBasic.StartStreaming=
        OBSBasic.StopStreaming=
        
        [BasicWindow]
        DockState=AAAA/wAAAAD9AAAAAwAAAAAAAAEYAAAC7QAAAAT9AgAAAAEAAAAWAAAAA8oAAAAMAPwBAAACAwAAAAEAAAABAAAAA
        geometry=AdnQywADAAAAAAGOAAAAPQAABfEAAAMjAAABjgAAAD0AAAXxAAADIwAAAAAAAAAABQAA
      '';
    };

    home.file.".config/obs-studio/basic/profiles/Default/basic.ini" = {
      text = ''
        [Video]
        BaseCX=1920
        BaseCY=1080
        OutputCX=1920
        OutputCY=1080
        FPSType=0
        FPSCommon=30
        
        [Audio]
        SampleRate=44100
        ChannelSetup=Stereo
        
        [AdvOut]
        Track1Bitrate=160
        Track2Bitrate=160
        Track3Bitrate=160
        Track4Bitrate=160
        Track5Bitrate=160
        Track6Bitrate=160
        
        [SimpleOutput]
        FilePath=${config.home.homeDirectory}/Videos
        RecFormat=mkv
        RecQuality=0
        RecEncoder=x264
        VBitrate=2500
        ABitrate=160
        UseAdvanced=false
        EnforceBitrate=true
        CustomMuxerSettings=
        RecRB=false
        RecRBTime=20
        RecRBSize=512
        
        [Stream1]
        DynamicBitrate=false
        IgnoreRecommended=false
      '';
    };

    home.file.".config/obs-studio/basic/scenes/Default.json" = {
      text = ''
        {
          "current_scene": "Scene",
          "current_transition": "Fade",
          "groups": [],
          "name": "Default",
          "preview_locked": false,
          "quick_transitions": [],
          "scene_order": [
            {
              "name": "Scene"
            }
          ],
          "sources": [
            {
              "balance": 0.5,
              "deinterlace_field_order": 0,
              "deinterlace_mode": 0,
              "enabled": true,
              "flags": 0,
              "hotkeys": {},
              "id": "scene",
              "mixers": 255,
              "monitoring_type": 0,
              "muted": false,
              "name": "Scene",
              "push-to-mute": false,
              "push-to-mute-delay": 0,
              "push-to-talk": false,
              "push-to-talk-delay": 0,
              "settings": {},
              "sync": 0,
              "versioned_id": "scene",
              "volume": 1.0
            }
          ],
          "transitions": [
            {
              "hotkeys": {},
              "id": "fade_transition",
              "name": "Fade",
              "settings": {},
              "versioned_id": "fade_transition"
            },
            {
              "hotkeys": {},
              "id": "cut_transition",
              "name": "Cut",
              "settings": {},
              "versioned_id": "cut_transition"
            }
          ],
          "version": "28.1.2"
        }
      '';
    };
  };
}
