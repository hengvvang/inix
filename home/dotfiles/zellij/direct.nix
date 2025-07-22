{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "direct") {
    # 直接安装zellij包
    home.packages = with pkgs; [ 
        zellij
        wl-clipboard
    ];

    # 直接文件写入 - 演示用简化配置
    home.file.".config/zellij/config.kdl".text = ''
      // Zellij 简化配置文件
      
      // 基础设置
      theme "catppuccin-mocha"
      default_shell "fish"
      
      // 界面设置
      pane_frames true
      mouse_mode true
      copy_command "wl-copy"
      
      // 关闭启动提示
      show_startup_tips false
      
      // 键绑定简化版本
      keybinds {
          normal {
              // 基础控制
              bind "Ctrl q" { Quit; }
              bind "Ctrl d" { Detach; }
              
              // 窗格导航 - Vi风格
              bind "Alt h" { MoveFocus "Left"; }
              bind "Alt j" { MoveFocus "Down"; }
              bind "Alt k" { MoveFocus "Up"; }
              bind "Alt l" { MoveFocus "Right"; }
              
              // 窗格分割
              bind "Alt |" { NewPane "Right"; }
              bind "Alt -" { NewPane "Down"; }
              
              // 标签页管理
              bind "Alt n" { NewTab; }
              bind "Alt 1" { GoToTab 1; }
              bind "Alt 2" { GoToTab 2; }
              bind "Alt 3" { GoToTab 3; }
              
              // 模式切换
              bind "Ctrl p" { SwitchToMode "Pane"; }
              bind "Ctrl t" { SwitchToMode "Tab"; }
          }
          
          pane {
              bind "h" { MoveFocus "Left"; }
              bind "j" { MoveFocus "Down"; }
              bind "k" { MoveFocus "Up"; }
              bind "l" { MoveFocus "Right"; }
              bind "n" { NewPane; }
              bind "x" { CloseFocus; }
              bind "Esc" { SwitchToMode "Normal"; }
          }
          
          tab {
              bind "h" { GoToPreviousTab; }
              bind "l" { GoToNextTab; }
              bind "n" { NewTab; }
              bind "x" { CloseTab; }
              bind "Esc" { SwitchToMode "Normal"; }
          }
      }
      
      // 基础布局
      layout {
          tab name="Terminal" {
              pane
          }
      }
    '';
    
    # Fish shell集成
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # 简单的zellij启动函数
      function zj
          if test (count $argv) -eq 0
              zellij attach -c default
          else
              zellij attach -c $argv[1]
          end
      end
    '';
  };
}
