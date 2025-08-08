# 完整配置文件示例

本文档提供了完整的 Zellij 配置文件示例，展示所有主要配置选项的使用方法。

## 基础配置示例

```kdl
// 基本选项配置
on_force_close "detach"
simplified_ui false
default_shell "fish"
pane_frames true
theme "dracula"
default_layout "default"
default_mode "normal"
mouse_mode true
scroll_buffer_size 10000
copy_clipboard "system"
copy_on_select true
scrollback_editor "nvim"
mirror_session false
auto_layout true
styled_underlines true
session_serialization true
pane_viewport_serialization false
serialization_interval 60
disable_session_metadata false
stacked_resize true
show_startup_tips true
show_release_notes true

// 环境变量
env {
    EDITOR "nvim"
    RUST_BACKTRACE "1"
    COLORTERM "truecolor"
}

// UI 配置
ui {
    pane_frames {
        rounded_corners true
        hide_session_name false
    }
}
```

## 完整键绑定配置

```kdl
keybinds {
    normal {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "Alt [" { PreviousSwapLayout; }
        bind "Alt ]" { NextSwapLayout; }
    }

    locked {
        bind "Ctrl g" { SwitchToMode "Normal"; }
    }

    resize {
        bind "Ctrl n" { SwitchToMode "Normal"; }
        bind "h" "Left" { Resize "Increase Left"; }
        bind "j" "Down" { Resize "Increase Down"; }
        bind "k" "Up" { Resize "Increase Up"; }
        bind "l" "Right" { Resize "Increase Right"; }
        bind "H" { Resize "Decrease Left"; }
        bind "J" { Resize "Decrease Down"; }
        bind "K" { Resize "Decrease Up"; }
        bind "L" { Resize "Decrease Right"; }
        bind "=" "+" { Resize "Increase"; }
        bind "-" { Resize "Decrease"; }
    }

    pane {
        bind "Ctrl p" { SwitchToMode "Normal"; }
        bind "h" "Left" { MoveFocus "Left"; }
        bind "l" "Right" { MoveFocus "Right"; }
        bind "j" "Down" { MoveFocus "Down"; }
        bind "k" "Up" { MoveFocus "Up"; }
        bind "p" { SwitchFocus; }
        bind "n" { NewPane; SwitchToMode "Normal"; }
        bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
        bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
        bind "s" { NewPane "stacked"; SwitchToMode "Normal"; }
        bind "x" { CloseFocus; SwitchToMode "Normal"; }
        bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
        bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
        bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
        bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
        bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0; }
        bind "i" { TogglePanePinned; SwitchToMode "Normal"; }
    }

    move {
        bind "Ctrl h" { SwitchToMode "Normal"; }
        bind "n" "Tab" { MovePane; }
        bind "p" { MovePaneBackwards; }
        bind "h" "Left" { MovePane "Left"; }
        bind "j" "Down" { MovePane "Down"; }
        bind "k" "Up" { MovePane "Up"; }
        bind "l" "Right" { MovePane "Right"; }
    }

    tab {
        bind "Ctrl t" { SwitchToMode "Normal"; }
        bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
        bind "h" "Left" "Up" "k" { GoToPreviousTab; }
        bind "l" "Right" "Down" "j" { GoToNextTab; }
        bind "n" { NewTab; SwitchToMode "Normal"; }
        bind "x" { CloseTab; SwitchToMode "Normal"; }
        bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
        bind "b" { BreakPane; SwitchToMode "Normal"; }
        bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
        bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
        bind "1" { GoToTab 1; SwitchToMode "Normal"; }
        bind "2" { GoToTab 2; SwitchToMode "Normal"; }
        bind "3" { GoToTab 3; SwitchToMode "Normal"; }
        bind "4" { GoToTab 4; SwitchToMode "Normal"; }
        bind "5" { GoToTab 5; SwitchToMode "Normal"; }
        bind "Tab" { ToggleTab; }
    }

    scroll {
        bind "Ctrl s" { SwitchToMode "Normal"; }
        bind "e" { EditScrollback; SwitchToMode "Normal"; }
        bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
        bind "j" "Down" { ScrollDown; }
        bind "k" "Up" { ScrollUp; }
        bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
        bind "d" { HalfPageScrollDown; }
        bind "u" { HalfPageScrollUp; }
    }

    search {
        bind "Ctrl s" { SwitchToMode "Normal"; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
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
        bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
        bind "Enter" { SwitchToMode "Search"; }
    }

    renametab {
        bind "Ctrl c" { SwitchToMode "Normal"; }
        bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
    }

    renamepane {
        bind "Ctrl c" { SwitchToMode "Normal"; }
        bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
    }

    session {
        bind "Ctrl o" { SwitchToMode "Normal"; }
        bind "Ctrl s" { SwitchToMode "Scroll"; }
        bind "d" { Detach; }
        bind "w" {
            LaunchOrFocusPlugin "session-manager" {
                floating true
                move_to_focused_tab true
            };
            SwitchToMode "Normal"
        }
        bind "c" {
            LaunchOrFocusPlugin "configuration" {
                floating true
                move_to_focused_tab true
            };
            SwitchToMode "Normal"
        }
    }

    shared_except "locked" {
        bind "Ctrl g" { SwitchToMode "Locked"; }
        bind "Ctrl q" { Quit; }
        bind "Alt f" { ToggleFloatingPanes; }
        bind "Alt n" { NewPane; }
        bind "Alt i" { MoveTab "Left"; }
        bind "Alt o" { MoveTab "Right"; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "Alt [" { PreviousSwapLayout; }
        bind "Alt ]" { NextSwapLayout; }
    }

    shared_except "normal" "locked" {
        bind "Enter" "Esc" { SwitchToMode "Normal"; }
    }

    shared_except "pane" "locked" {
        bind "Ctrl p" { SwitchToMode "Pane"; }
    }

    shared_except "resize" "locked" {
        bind "Ctrl n" { SwitchToMode "Resize"; }
    }

    shared_except "scroll" "locked" {
        bind "Ctrl s" { SwitchToMode "Scroll"; }
    }

    shared_except "session" "locked" {
        bind "Ctrl o" { SwitchToMode "Session"; }
    }

    shared_except "tab" "locked" {
        bind "Ctrl t" { SwitchToMode "Tab"; }
    }

    shared_except "move" "locked" {
        bind "Ctrl h" { SwitchToMode "Move"; }
    }
}
```

## 插件配置示例

```kdl
plugins {
    tab-bar location="zellij:tab-bar"
    status-bar location="zellij:status-bar"
    strider location="zellij:strider"
    compact-bar location="zellij:compact-bar"
    session-manager location="zellij:session-manager"
    welcome-screen location="zellij:session-manager" {
        welcome_screen true
    }
    filepicker location="zellij:strider" {
        cwd "/"
    }
    configuration location="zellij:configuration"
    plugin-manager location="zellij:plugin-manager"
    about location="zellij:about"
}
```

## 自定义主题示例

```kdl
themes {
    custom-dark {
        text_unselected {
            base 220 220 220
            background 40 40 40
            emphasis_0 120 220 120
            emphasis_1 220 180 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        text_selected {
            base 40 40 40
            background 120 220 120
            emphasis_0 220 220 220
            emphasis_1 220 180 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        ribbon_unselected {
            base 200 200 200
            background 60 60 60
            emphasis_0 120 220 120
            emphasis_1 220 180 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        ribbon_selected {
            base 40 40 40
            background 120 220 120
            emphasis_0 220 220 220
            emphasis_1 220 180 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        frame_unselected {
            base 80 80 80
            background 40 40 40
            emphasis_0 120 220 120
            emphasis_1 220 180 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        frame_selected {
            base 120 220 120
            background 40 40 40
            emphasis_0 220 220 220
            emphasis_1 220 180 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        frame_highlight {
            base 220 180 120
            background 40 40 40
            emphasis_0 220 220 220
            emphasis_1 120 220 120
            emphasis_2 120 180 220
            emphasis_3 220 120 180
        }

        multiplayer_user_colors {
            player_1 255 120 255
            player_2 120 255 255
            player_3 255 255 120
            player_4 120 255 120
            player_5 255 120 120
            player_6 120 120 255
            player_7 255 200 120
            player_8 200 120 255
            player_9 120 255 200
            player_10 200 255 120
        }
    }
}
```

## 高级配置示例

### 开发者配置

```kdl
// 开发者友好的配置
default_shell "zsh"
scrollback_editor "code --wait"
scroll_buffer_size 50000
copy_command "wl-copy"
copy_on_select false

env {
    EDITOR "code --wait"
    GIT_EDITOR "code --wait"
    RUST_BACKTRACE "1"
    CARGO_TERM_COLOR "always"
}

// 快速开发键绑定
keybinds {
    normal {
        // 快速创建窗格
        bind "Alt Enter" { NewPane "Down"; }
        bind "Alt Shift Enter" { NewPane "Right"; }

        // Git 相关快捷键
        bind "Alt g" {
            NewPane "Down";
            WriteChars "git status";
            WriteChars "\n";
        }

        // 快速编辑器
        bind "Alt e" {
            NewPane "Right";
            WriteChars "code .";
            WriteChars "\n";
        }
    }
}
```

### 服务器管理配置

```kdl
// 服务器管理配置
session_serialization true
pane_viewport_serialization true
scrollback_lines_to_serialize 5000
serialization_interval 30

// Web 服务器配置
web_server true
web_server_ip "0.0.0.0"
web_server_port 8080
web_server_cert "/etc/ssl/certs/zellij.crt"
web_server_key "/etc/ssl/private/zellij.key"
enforce_https_on_localhost false

env {
    PATH "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    TERM "screen-256color"
}
```

### 最小化配置

```kdl
// 最小化界面配置
simplified_ui true
pane_frames false
show_startup_tips false
show_release_notes false
mouse_mode false

plugins {
    compact-bar location="zellij:compact-bar"
}

keybinds {
    normal {
        bind "Ctrl Space" { SwitchToMode "locked"; }
    }
    locked {
        bind "Ctrl Space" { SwitchToMode "normal"; }
    }
}

theme "default"
```

## 配置验证

使用以下命令验证配置：

```bash
# 检查配置文件语法
zellij setup --check

# 生成默认配置作为参考
zellij setup --dump-config > reference-config.kdl

# 使用特定配置启动
zellij --config custom-config.kdl
```

## 配置技巧

1. **分段配置:** 将大型配置文件分解为多个较小的文件
2. **版本控制:** 将配置文件加入 Git 版本控制
3. **备份配置:** 定期备份工作配置
4. **测试配置:** 在测试环境中验证新配置
5. **文档注释:** 在配置文件中添加注释说明用途
