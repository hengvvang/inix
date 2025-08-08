# 键绑定配置 (Keybinds)

Zellij 的键绑定基于模式系统，每个模式都有自己的一套键绑定。你可以添加到默认键绑定或完全覆盖它们。

## 基本键绑定结构

键绑定在配置文件的 `keybinds` 块中定义：

```kdl
keybinds {
    // 键绑定按模式分组
    normal {
        // 绑定指令可以包含一个或多个键（两个键将分别绑定）
        // 绑定键可以包含一个或多个动作（所有动作将无顺序保证地执行）
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
    }
}
```

## 清除默认键绑定

如果要完全覆盖默认键绑定：

```kdl
keybinds clear-defaults=true {
    // 你的自定义键绑定
}
```

## 主要模式 (Modes)

### normal 模式
基础操作模式，这是默认模式

```kdl
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
}
```

### locked 模式
锁定模式，阻止意外的键盘输入

```kdl
locked {
    bind "Ctrl g" { SwitchToMode "Normal"; }
}
```

### pane 模式
窗格管理模式

```kdl
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
    bind "x" { CloseFocus; SwitchToMode "Normal"; }
    bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
    bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
    bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
    bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
    bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0; }
    bind "i" { TogglePanePinned; SwitchToMode "Normal"; }
}
```

### tab 模式
标签页管理模式

```kdl
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
    // ... 数字键 3-9
    bind "Tab" { ToggleTab; }
}
```

### resize 模式
调整窗格大小模式

```kdl
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
```

### move 模式
移动窗格模式

```kdl
move {
    bind "Ctrl h" { SwitchToMode "Normal"; }
    bind "n" "Tab" { MovePane; }
    bind "p" { MovePaneBackwards; }
    bind "h" "Left" { MovePane "Left"; }
    bind "j" "Down" { MovePane "Down"; }
    bind "k" "Up" { MovePane "Up"; }
    bind "l" "Right" { MovePane "Right"; }
}
```

### scroll 模式
滚动模式

```kdl
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
```

### search 模式
搜索模式

```kdl
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
```

### session 模式
会话管理模式

```kdl
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
```

## 共享键绑定

### shared_except
为除指定模式外的所有模式定义键绑定

```kdl
shared_except "locked" {
    bind "Ctrl g" { SwitchToMode "Locked"; }
    bind "Ctrl q" { Quit; }
    bind "Alt f" { ToggleFloatingPanes; }
    bind "Alt n" { NewPane; }
    bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
    bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
}

shared_except "normal" "locked" {
    bind "Enter" "Esc" { SwitchToMode "Normal"; }
}
```
