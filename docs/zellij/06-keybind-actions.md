# 键绑定动作参考 (Keybind Actions)

此部分详细介绍 Zellij 中所有可用的键绑定动作及其参数。

## 模式切换动作

### SwitchToMode
切换到指定的模式

**参数:** 模式名称字符串

**可用模式:**
- `"Normal"` - 普通模式
- `"Locked"` - 锁定模式
- `"Pane"` - 窗格模式
- `"Tab"` - 标签页模式
- `"Resize"` - 调整大小模式
- `"Move"` - 移动模式
- `"Scroll"` - 滚动模式
- `"Search"` - 搜索模式
- `"EnterSearch"` - 进入搜索模式
- `"Session"` - 会话模式
- `"RenameTab"` - 重命名标签页模式
- `"RenamePane"` - 重命名窗格模式
- `"Tmux"` - Tmux 兼容模式

```kdl
bind "Ctrl g" { SwitchToMode "Locked"; }
bind "Esc" { SwitchToMode "Normal"; }
```

## 窗格操作动作

### NewPane
创建新窗格

**参数:** 可选的方向
- 无参数 - 根据可用空间决定方向
- `"Down"` - 在下方创建
- `"Right"` - 在右侧创建
- `"stacked"` - 创建堆叠窗格

```kdl
bind "n" { NewPane; }
bind "d" { NewPane "Down"; }
bind "r" { NewPane "Right"; }
bind "s" { NewPane "stacked"; }
```

### CloseFocus
关闭当前聚焦的窗格

```kdl
bind "x" { CloseFocus; }
```

### MoveFocus
移动焦点到指定方向的窗格

**参数:** 方向字符串
- `"Left"` - 左侧窗格
- `"Right"` - 右侧窗格
- `"Up"` - 上方窗格
- `"Down"` - 下方窗格

```kdl
bind "h" "Left" { MoveFocus "Left"; }
bind "l" "Right" { MoveFocus "Right"; }
bind "j" "Down" { MoveFocus "Down"; }
bind "k" "Up" { MoveFocus "Up"; }
```

### MoveFocusOrTab
移动焦点到指定方向的窗格，如果没有窗格则切换标签页

**参数:** 方向字符串

```kdl
bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
```

### SwitchFocus
在窗格间循环切换焦点

```kdl
bind "p" { SwitchFocus; }
```

### FocusNextPane
聚焦到下一个窗格

```kdl
bind "Tab" { FocusNextPane; }
```

### ToggleFocusFullscreen
切换当前窗格的全屏状态

```kdl
bind "f" { ToggleFocusFullscreen; }
```

### TogglePaneFrames
切换窗格边框的显示/隐藏

```kdl
bind "z" { TogglePaneFrames; }
```

### ToggleFloatingPanes
切换浮动窗格模式

```kdl
bind "w" { ToggleFloatingPanes; }
```

### TogglePaneEmbedOrFloating
切换窗格的嵌入/浮动状态

```kdl
bind "e" { TogglePaneEmbedOrFloating; }
```

### TogglePanePinned
切换窗格的固定状态

```kdl
bind "i" { TogglePanePinned; }
```

## 窗格移动和调整

### MovePane
移动窗格到指定方向或位置

**参数:**
- 方向字符串: `"Left"`, `"Right"`, `"Up"`, `"Down"`
- 无参数 - 移动到下一个位置

```kdl
bind "h" "Left" { MovePane "Left"; }
bind "n" "Tab" { MovePane; }
```

### MovePaneBackwards
向后移动窗格

```kdl
bind "p" { MovePaneBackwards; }
```

### Resize
调整窗格大小

**参数:** 调整类型和方向
- `"Increase Left"` - 向左增加
- `"Increase Right"` - 向右增加
- `"Increase Up"` - 向上增加
- `"Increase Down"` - 向下增加
- `"Decrease Left"` - 向左减少
- `"Decrease Right"` - 向右减少
- `"Decrease Up"` - 向上减少
- `"Decrease Down"` - 向下减少
- `"Increase"` - 增加（智能方向）
- `"Decrease"` - 减少（智能方向）

```kdl
bind "h" "Left" { Resize "Increase Left"; }
bind "l" "Right" { Resize "Increase Right"; }
bind "=" "+" { Resize "Increase"; }
bind "-" { Resize "Decrease"; }
```

## 标签页操作动作

### NewTab
创建新标签页

```kdl
bind "n" { NewTab; }
```

### CloseTab
关闭当前标签页

```kdl
bind "x" { CloseTab; }
```

### GoToTab
跳转到指定编号的标签页

**参数:** 标签页编号（1-9）

```kdl
bind "1" { GoToTab 1; }
bind "2" { GoToTab 2; }
// ... 等等
```

### GoToNextTab
切换到下一个标签页

```kdl
bind "l" "Right" "j" "Down" { GoToNextTab; }
```

### GoToPreviousTab
切换到上一个标签页

```kdl
bind "h" "Left" "k" "Up" { GoToPreviousTab; }
```

### ToggleTab
在当前和上一个标签页之间切换

```kdl
bind "Tab" { ToggleTab; }
```

### MoveTab
移动当前标签页

**参数:** 方向
- `"Left"` - 向左移动
- `"Right"` - 向右移动

```kdl
bind "Alt i" { MoveTab "Left"; }
bind "Alt o" { MoveTab "Right"; }
```

### ToggleActiveSyncTab
切换标签页的同步状态

```kdl
bind "s" { ToggleActiveSyncTab; }
```

### BreakPane
将当前窗格分离为新标签页

```kdl
bind "b" { BreakPane; }
```

### BreakPaneLeft
将当前窗格分离为左侧新标签页

```kdl
bind "[" { BreakPaneLeft; }
```

### BreakPaneRight
将当前窗格分离为右侧新标签页

```kdl
bind "]" { BreakPaneRight; }
```

## 滚动和搜索动作

### ScrollUp
向上滚动

```kdl
bind "k" "Up" { ScrollUp; }
```

### ScrollDown
向下滚动

```kdl
bind "j" "Down" { ScrollDown; }
```

### PageScrollUp
向上翻页

```kdl
bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
```

### PageScrollDown
向下翻页

```kdl
bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
```

### HalfPageScrollUp
向上翻半页

```kdl
bind "u" { HalfPageScrollUp; }
```

### HalfPageScrollDown
向下翻半页

```kdl
bind "d" { HalfPageScrollDown; }
```

### ScrollToBottom
滚动到底部

```kdl
bind "Ctrl c" { ScrollToBottom; }
```

### Search
搜索文本

**参数:** 搜索方向
- `"up"` - 向上搜索
- `"down"` - 向下搜索

```kdl
bind "n" { Search "down"; }
bind "p" { Search "up"; }
```

### SearchToggleOption
切换搜索选项

**参数:** 选项类型
- `"CaseSensitivity"` - 大小写敏感
- `"Wrap"` - 环绕搜索
- `"WholeWord"` - 全词匹配

```kdl
bind "c" { SearchToggleOption "CaseSensitivity"; }
bind "w" { SearchToggleOption "Wrap"; }
bind "o" { SearchToggleOption "WholeWord"; }
```

## 输入和编辑动作

### SearchInput
开始搜索输入

**参数:** 输入ID（通常为0）

```kdl
bind "s" { SearchInput 0; }
```

### TabNameInput
开始标签页名称输入

**参数:** 输入ID（通常为0）

```kdl
bind "r" { TabNameInput 0; }
```

### PaneNameInput
开始窗格名称输入

**参数:** 输入ID（通常为0）

```kdl
bind "c" { PaneNameInput 0; }
```

### UndoRenameTab
撤销标签页重命名

```kdl
bind "Esc" { UndoRenameTab; }
```

### UndoRenamePane
撤销窗格重命名

```kdl
bind "Esc" { UndoRenamePane; }
```

### EditScrollback
编辑滚动缓冲区

```kdl
bind "e" { EditScrollback; }
```

## 系统操作动作

### Quit
退出 Zellij

```kdl
bind "Ctrl q" { Quit; }
```

### Detach
从会话分离

```kdl
bind "d" { Detach; }
```

### Copy
复制选中的文本

```kdl
bind "Alt c" { Copy; }
```

### Write
写入指定字节

**参数:** 字节值

```kdl
bind "Ctrl b" { Write 2; }
```

## 布局操作动作

### PreviousSwapLayout
切换到上一个布局

```kdl
bind "Alt [" { PreviousSwapLayout; }
```

### NextSwapLayout
切换到下一个布局

```kdl
bind "Alt ]" { NextSwapLayout; }
bind "Space" { NextSwapLayout; }
```

## 窗格分组动作

### TogglePaneInGroup
切换窗格的分组状态

```kdl
bind "Alt p" { TogglePaneInGroup; }
```

### ToggleGroupMarking
切换分组标记

```kdl
bind "Alt Shift p" { ToggleGroupMarking; }
```
