{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "direct") {
    
    home.file.".config/zellij/config.kdl" = {
      text = ''
        // Zellij 配置文件
        // 配置方式: direct - 直接文件配置

        // 基本设置
        default_shell "fish"
        default_cwd "$HOME"
        default_layout "default"
        default_mode "normal"
        mouse_mode true
        scroll_buffer_size 10000
        copy_command "wl-copy"
        copy_clipboard "primary"
        copy_on_select true
        scrollback_editor "vim"
        session_serialization true
        pane_viewport_serialization true

        // 主题设置 - GitHub Dark
        theme "github-dark" {
            fg "#c9d1d9"
            bg "#0d1117"
            red "#ff7b72"
            green "#7ee787"
            yellow "#f0883e"
            blue "#58a6ff"
            magenta "#da77f2"
            orange "#ffa657"
            cyan "#76e3ea"
            black "#21262d"
            white "#b1bac4"
        }

        // 键绑定
        keybinds clear-defaults=true {
            normal {
                // 模式切换
                bind "Ctrl a" { SwitchToMode "tmux"; }
            }
            tmux {
                bind "[" { SwitchToMode "scroll"; }
                bind "Ctrl a" { Write 1; SwitchToMode "normal"; }
                bind "\"" { NewPane "down"; SwitchToMode "normal"; }
                bind "%" { NewPane "right"; SwitchToMode "normal"; }
                bind "z" { ToggleFocusFullscreen; SwitchToMode "normal"; }
                bind "c" { NewTab; SwitchToMode "normal"; }
                bind "," { SwitchToMode "renamepane"; }
                bind "p" { GoToPreviousTab; SwitchToMode "normal"; }
                bind "n" { GoToNextTab; SwitchToMode "normal"; }
                bind "Left" { MoveFocus "left"; SwitchToMode "normal"; }
                bind "Right" { MoveFocus "right"; SwitchToMode "normal"; }
                bind "Down" { MoveFocus "down"; SwitchToMode "normal"; }
                bind "Up" { MoveFocus "up"; SwitchToMode "normal"; }
                bind "h" { MoveFocus "left"; SwitchToMode "normal"; }
                bind "l" { MoveFocus "right"; SwitchToMode "normal"; }
                bind "j" { MoveFocus "down"; SwitchToMode "normal"; }
                bind "k" { MoveFocus "up"; SwitchToMode "normal"; }
                bind "o" { FocusNextPane; SwitchToMode "normal"; }
                bind "d" { Detach; }
                bind "Space" { NextSwapLayout; SwitchToMode "normal"; }
                bind "x" { CloseFocus; SwitchToMode "normal"; }
            }
            scroll {
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "s" { SwitchToMode "entersearch"; SearchInput 0; }
                bind "G" { ScrollToBottom; }
                bind "g" {
                    bind "g" { ScrollToTop; }
                }
            }
            search {
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "n" { Search "down"; }
                bind "p" { Search "up"; }
                bind "c" { SearchToggleOption "CaseSensitivity"; }
                bind "w" { SearchToggleOption "Wrap"; }
                bind "o" { SearchToggleOption "WholeWord"; }
            }
            entersearch {
                bind "Enter" { SwitchToMode "search"; }
                bind "Ctrl c" "Esc" { SearchInput 27; SwitchToMode "scroll"; }
            }
            renamepane {
                bind "Enter" { SwitchToMode "normal"; }
                bind "Ctrl c" "Esc" { UndoRenamePane; SwitchToMode "normal"; }
            }
            shared_except "locked" {
                bind "Ctrl g" { SwitchToMode "locked"; }
                bind "Ctrl q" { Quit; }
                bind "Alt n" { NewPane; }
                bind "Alt h" "Alt Left" { MoveFocusOrTab "left"; }
                bind "Alt l" "Alt Right" { MoveFocusOrTab "right"; }
                bind "Alt j" "Alt Down" { MoveFocus "down"; }
                bind "Alt k" "Alt Up" { MoveFocus "up"; }
                bind "Alt =" "Alt +" { Resize "increase"; }
                bind "Alt -" { Resize "decrease"; }
                bind "Alt [" { PreviousSwapLayout; }
                bind "Alt ]" { NextSwapLayout; }
            }
            shared_except "normal" "locked" {
                bind "Enter" "Esc" { SwitchToMode "normal"; }
            }
            shared_except "renamepane" "locked" {
                bind "Ctrl c" { SwitchToMode "normal"; }
            }
        }

        // 插件配置
        plugins {
            tab-bar { path "tab-bar"; }
            status-bar { path "status-bar"; }
            strider { path "strider"; }
            compact-bar { path "compact-bar"; }
        }

        // 布局
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                children
                pane size=2 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }
        }

        // UI 配置
        ui {
            pane_frames {
                rounded_corners true
                hide_session_name false
            }
        }

        // 会话选项
        session_serialization true
        pane_viewport_serialization true
        scrollback_lines_to_serialize 10000
      '';
    };

    home.file.".config/zellij/layouts/default.kdl" = {
      text = ''
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                children
                pane size=2 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }
            tab name="Main" {
                pane
            }
        }
      '';
    };

    home.file.".config/zellij/layouts/development.kdl" = {
      text = ''
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                children
                pane size=2 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }
            tab name="Editor" {
                pane command="vim"
            }
            tab name="Terminal" split_direction="vertical" {
                pane size="70%"
                pane size="30%" split_direction="horizontal" {
                    pane command="git" {
                        args "status"
                    }
                    pane
                }
            }
            tab name="Server" {
                pane
            }
        }
      '';
    };
  };
}
