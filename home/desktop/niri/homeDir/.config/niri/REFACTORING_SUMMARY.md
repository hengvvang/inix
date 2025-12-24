# Niri 配置模块化重构完成

## 重构概述

已成功将 817 行的单文件配置重构为模块化结构,使用 niri 25.11+ 版本的 include 语法。

## 配置文件结构

### 主配置文件 (138 行)
- **config.kdl** - 主入口文件,包含所有模块的 include 引用和核心配置

### 模块文件 (9 个)

1. **startup.kdl** (58 行)
   - 启动服务配置
   - fcitx5、waybar、dunst、swayidle、swww-daemon 等

2. **environment.kdl** (72 行)
   - 环境变量设置
   - DISPLAY、ELECTRON、GDK、QT、XWAYLAND 相关变量

3. **input.kdl** (167 行)
   - 输入设备配置
   - 键盘、触摸板、鼠标、轨迹点设置

4. **output.kdl** (117 行)
   - 显示输出配置
   - eDP-1 @ 2560x1600@240Hz, 1.5x 缩放

5. **layout.kdl** (194 行)
   - 窗口布局和视觉效果
   - gaps、focus-ring、border、shadow、tab-indicator 等

6. **animations.kdl** (126 行)
   - 动画效果配置
   - 工作区切换、窗口打开/关闭、配置变更等动画

7. **gestures.kdl** (93 行)
   - 手势配置
   - dnd-edge-view-scroll、workspace-switch、hot-corners

8. **window-rules.kdl** (335 行)
   - 窗口规则和样式
   - 全局样式、Firefox PiP、对话框、浮动窗口等

9. **binds.kdl** (491 行)
   - 快捷键绑定
   - 所有键盘、鼠标、触摸板快捷键定义

## 备份信息

- 原配置文件已备份至: `config.kdl.backup`
- 备份时间: 2024-12-24
- 原始文件大小: 27KB (817 行)

## 配置特点

### 语法更新
- ✅ 使用最新的 include 语法 (niri 25.11+)
- ✅ 所有配置项使用最新语法
- ✅ 详细的中文注释

### 模块化优势
- 更容易找到和修改特定设置
- 可以独立测试和重载各个模块
- 便于版本控制和协作
- 减少单个文件的复杂度

### 配置验证
```bash
$ niri validate
2025-12-24T00:54:20.198596Z DEBUG niri_config: loaded config from "/home/hengvvang/.config/niri/config.kdl"
2025-12-24T00:54:20.198643Z  INFO niri: config is valid
```

## 使用说明

### 热重载
niri 支持配置热重载,保存任何配置文件后会自动应用更改,包括所有 include 的文件。

### 常用命令
- 验证配置: `niri validate`
- 查看输出设备: `niri msg outputs`
- 查看窗口信息: `niri msg windows`

### 修改配置
根据需要编辑对应的模块文件:
- 修改启动程序 → `startup.kdl`
- 调整输入设备 → `input.kdl`
- 配置快捷键 → `binds.kdl`
- 自定义动画 → `animations.kdl`
- 等等...

## 注意事项

1. **Include 顺序**
   - include 是位置相关的
   - 后面的配置会覆盖前面的配置

2. **Binds 块**
   - binds 块不会自动填充默认值
   - 不要删除 `include "binds.kdl"`

3. **Window Rules 顺序**
   - 窗口规则的顺序很重要
   - 后面的规则会覆盖前面的规则

## 文件统计

| 文件             | 行数      | 大小       | 用途       |
| ---------------- | --------- | ---------- | ---------- |
| config.kdl       | 138       | 4.9KB      | 主配置文件 |
| startup.kdl      | 58        | 2.6KB      | 启动服务   |
| environment.kdl  | 72        | 2.8KB      | 环境变量   |
| input.kdl        | 167       | 5.0KB      | 输入设备   |
| output.kdl       | 117       | 4.0KB      | 显示输出   |
| layout.kdl       | 194       | 8.1KB      | 布局配置   |
| animations.kdl   | 126       | 4.9KB      | 动画效果   |
| gestures.kdl     | 93        | 3.1KB      | 手势配置   |
| window-rules.kdl | 335       | 8.7KB      | 窗口规则   |
| binds.kdl        | 491       | 19KB       | 快捷键绑定 |
| **总计**         | **1,791** | **63.1KB** | 包含注释   |

重构前单文件: 817 行, 27KB
重构后总计: 1,791 行 (因为增加了大量注释和说明文档)

## 完成时间
2024-12-24
