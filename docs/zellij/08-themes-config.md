# 主题配置 (Themes)

Zellij 主题系统允许你自定义界面的颜色方案。主题基于 UI 组件定义，每个组件都有自己的颜色属性。

## 使用内置主题

设置 `theme` 配置项来使用内置主题：

```kdl
theme "dracula"
```

**可用的内置主题包括:**
- `"default"` - 默认主题
- `"dracula"` - Dracula 主题
- `"nord"` - Nord 主题
- `"gruvbox-dark"` - Gruvbox 深色主题
- `"gruvbox-light"` - Gruvbox 浅色主题
- `"tokyo-night"` - Tokyo Night 主题
- `"tokyo-night-storm"` - Tokyo Night Storm 主题
- `"tokyo-night-light"` - Tokyo Night 浅色主题
- `"catppuccin-frappe"` - Catppuccin Frappe 主题
- `"catppuccin-macchiato"` - Catppuccin Macchiato 主题
- `"catppuccin-mocha"` - Catppuccin Mocha 主题
- `"catppuccin-latte"` - Catppuccin Latte 主题

## 主题定义结构

主题在 `themes` 块中定义：

```kdl
themes {
    my-theme {
        // UI 组件颜色定义
        ribbon_unselected {
            base 0 0 0
            background 255 153 0
            emphasis_0 255 53 94
            emphasis_1 255 255 255
            emphasis_2 0 217 227
            emphasis_3 255 0 255
        }
        // ... 其他组件
    }
}
```

## UI 组件属性

每个 UI 组件都有以下颜色属性，每个属性包含三个数字（RGB 值）：

1. **base** - 组件的基础颜色
2. **background** - 组件的背景颜色
3. **emphasis_0** - 第一级强调颜色
4. **emphasis_1** - 第二级强调颜色
5. **emphasis_2** - 第三级强调颜色
6. **emphasis_3** - 第四级强调颜色

## UI 组件详细说明

### text_unselected
未选中的文本部分（如状态栏中的 `Ctrl` 或 `Alt` 修饰符指示）

```kdl
text_unselected {
    base 248 248 242
    background 40 42 54
    emphasis_0 80 250 123
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### text_selected
选中状态下的文本部分（如搜索结果分页时）

```kdl
text_selected {
    base 40 42 54
    background 80 250 123
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### ribbon_unselected
未选中的功能区（如标签页和状态栏中的键绑定模式）

```kdl
ribbon_unselected {
    base 248 248 242
    background 68 71 90
    emphasis_0 80 250 123
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### ribbon_selected
选中的功能区（如聚焦的标签页或状态栏中的活动键绑定模式）

```kdl
ribbon_selected {
    base 40 42 54
    background 80 250 123
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### table_title
表格 UI 组件的标题行样式

```kdl
table_title {
    base 248 248 242
    background 40 42 54
    emphasis_0 80 250 123
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### table_cell_unselected
表格中未选中的单元格样式

```kdl
table_cell_unselected {
    base 248 248 242
    background 40 42 54
    emphasis_0 80 250 123
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### table_cell_selected
表格中选中的单元格样式

```kdl
table_cell_selected {
    base 40 42 54
    background 80 250 123
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### list_unselected
嵌套列表中未选中的行项目

```kdl
list_unselected {
    base 248 248 242
    background 40 42 54
    emphasis_0 80 250 123
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### list_selected
嵌套列表中选中的行项目

```kdl
list_selected {
    base 40 42 54
    background 80 250 123
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### frame_unselected
非聚焦窗格周围的边框

```kdl
frame_unselected {
    base 68 71 90
    background 40 42 54
    emphasis_0 80 250 123
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### frame_selected
聚焦窗格周围的边框

```kdl
frame_selected {
    base 80 250 123
    background 40 42 54
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### frame_highlight
用户进入非基础模式时聚焦窗格周围的边框（如 `PANE` 或 `TAB` 模式）

```kdl
frame_highlight {
    base 255 184 108
    background 40 42 54
    emphasis_0 248 248 242
    emphasis_1 80 250 123
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### exit_code_success
命令窗格中成功退出代码的颜色指示

```kdl
exit_code_success {
    base 80 250 123
    background 40 42 54
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

### exit_code_error
命令窗格中错误退出代码的颜色指示

```kdl
exit_code_error {
    base 255 85 85
    background 40 42 54
    emphasis_0 248 248 242
    emphasis_1 255 184 108
    emphasis_2 139 233 253
    emphasis_3 255 121 198
}
```

## 多用户颜色配置

### multiplayer_user_colors
这是唯一与其他 UI 组件不同的主题部分：

```kdl
multiplayer_user_colors {
    player_1 255 0 255
    player_2 0 217 227
    player_3 255 230 0
    player_4 0 229 229
    player_5 255 53 94
    player_6 139 233 253
    player_7 80 250 123
    player_8 255 184 108
    player_9 248 248 242
    player_10 68 71 90
}
```

每个玩家代表加入（附加到）活动会话的用户的颜色。这些颜色对所有用户都相同，按附加顺序分配。

## 完整主题示例

以下是一个完整的自定义主题示例：

```kdl
themes {
    my-dark-theme {
        text_unselected {
            base 200 200 200
            background 30 30 30
            emphasis_0 100 200 100
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        text_selected {
            base 30 30 30
            background 100 200 100
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        ribbon_unselected {
            base 180 180 180
            background 50 50 50
            emphasis_0 100 200 100
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        ribbon_selected {
            base 30 30 30
            background 100 200 100
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        table_title {
            base 200 200 200
            background 30 30 30
            emphasis_0 100 200 100
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        table_cell_unselected {
            base 180 180 180
            background 30 30 30
            emphasis_0 100 200 100
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        table_cell_selected {
            base 30 30 30
            background 100 200 100
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        list_unselected {
            base 180 180 180
            background 30 30 30
            emphasis_0 100 200 100
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        list_selected {
            base 30 30 30
            background 100 200 100
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        frame_unselected {
            base 80 80 80
            background 30 30 30
            emphasis_0 100 200 100
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        frame_selected {
            base 100 200 100
            background 30 30 30
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        frame_highlight {
            base 200 150 100
            background 30 30 30
            emphasis_0 200 200 200
            emphasis_1 100 200 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        exit_code_success {
            base 100 200 100
            background 30 30 30
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        exit_code_error {
            base 200 100 100
            background 30 30 30
            emphasis_0 200 200 200
            emphasis_1 200 150 100
            emphasis_2 100 150 200
            emphasis_3 200 100 150
        }

        multiplayer_user_colors {
            player_1 255 100 255
            player_2 100 255 255
            player_3 255 255 100
            player_4 100 255 100
            player_5 255 100 100
            player_6 100 100 255
            player_7 255 200 100
            player_8 200 100 255
            player_9 100 255 200
            player_10 200 255 100
        }
    }
}
```

## 主题应用方式

### 直接在配置文件中定义

```kdl
themes {
    my-theme {
        // 主题定义...
    }
}

theme "my-theme"
```

### 从外部主题文件加载

1. 将主题文件放在主题目录中（默认为 `~/.config/zellij/themes/`）
2. 设置主题目录（可选）：
   ```kdl
   theme_dir "/path/to/my/themes"
   ```
3. 使用主题：
   ```kdl
   theme "my-theme"
   ```

### 命令行指定主题

```bash
zellij options --theme my-theme
```

## 主题开发技巧

### 实时主题开发

在开发主题时，建议将主题直接定义在主配置文件中，Zellij 会实时应用更改，无需重启会话。

### 主题测试插件

使用主题测试插件来查看所有 UI 组件：

```bash
zellij plugin -- https://github.com/imsnif/theme-tester
```

这将显示所有 UI 组件及其排列，让你实时看到更改效果。

### 颜色选择建议

1. **对比度:** 确保文本和背景有足够的对比度
2. **一致性:** 保持颜色系统的一致性
3. **可访问性:** 考虑色盲用户的需求
4. **终端兼容性:** 在不同终端中测试主题效果
