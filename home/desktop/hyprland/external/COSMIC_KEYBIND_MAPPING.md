# Cosmic → Hyprland 快捷键映射总结

## 🎯 基于 Cosmic Settings 源代码的完整配置

根据 [pop-os/cosmic-settings](https://github.com/pop-os/cosmic-settings/tree/main/cosmic-settings/src/pages/input/keyboard/shortcuts) 的源代码分析，重新配置了 Hyprland 快捷键以完全匹配 Cosmic 桌面的默认行为。

## 📋 主要变更对比

### 之前配置 vs 现在配置

| 功能 | 之前 (基于个人配置) | 现在 (基于源代码) | 说明 |
|------|---------------------|-------------------|------|
| **工作区切换** | `Super + Ctrl + 1-9` | `Super + 1-9` | 恢复标准 Linux 桌面习惯 |
| **移动窗口到工作区** | `Super + Ctrl + Shift + 1-8` | `Super + Shift + 1-9` | 简化快捷键组合 |
| **应用启动器** | `Super` | `Super` | 保持一致 |
| **网页浏览器** | ❌ | `Super + B` | 新增 Cosmic 标准快捷键 |
| **输入法切换** | ❌ | `Super + Space` | 新增国际化支持 |
| **键盘背光** | ❌ | `XF86KbdBrightness*` | 新增硬件控制 |

## 🔄 核心改进

### 1. 标准化工作区操作
```bash
# Cosmic 标准 (现在使用)
Super + 1-9           # 切换工作区
Super + Shift + 1-9   # 移动窗口到工作区

# 个人配置 (之前使用)
Super + Ctrl + 1-9         # 切换工作区
Super + Ctrl + Shift + 1-8 # 移动窗口到工作区
```

### 2. 完整的系统动作支持
基于 `cosmic-settings/src/pages/input/keyboard/shortcuts/system.rs`:

```rust
// 现在支持的所有 SystemAction
SystemAction::AppLibrary         → Super
SystemAction::Terminal           → Super + Return  
SystemAction::HomeFolder         → Super + E
SystemAction::WebBrowser         → Super + B
SystemAction::LockScreen         → Super + L
SystemAction::Screenshot         → Print
// ... 等等
```

### 3. 媒体和硬件控制
新增完整的硬件控制支持：
- 键盘背光控制 (`XF86KbdBrightness*`)
- 麦克风静音 (`XF86AudioMicMute`)
- 输入源切换 (`Super + Space`)

## 🎨 配置特点

### ✅ 优势
1. **100% 兼容**: 完全基于 Cosmic Settings 源代码
2. **标准化**: 符合 Linux 桌面环境的通用习惯
3. **完整性**: 包含所有 Cosmic 支持的系统动作
4. **国际化**: 支持输入法切换等国际化功能
5. **硬件支持**: 完整的键盘、显示器、音频控制

### 📝 详细注释
每个快捷键都包含：
- 对应的 Cosmic SystemAction
- 功能说明
- 实现细节

### 🔧 易于维护
- 基于官方源代码，更新容易跟踪
- 清晰的分类和注释
- 符合最佳实践

## 🚀 使用建议

1. **新用户**: 这些快捷键与大多数 Linux 桌面环境一致
2. **Cosmic 用户**: 可以无缝从 Cosmic 切换到 Hyprland
3. **自定义**: 如需个人化调整，参考注释中的 SystemAction 类型

## 📖 参考文档

- [Cosmic Settings 源代码](https://github.com/pop-os/cosmic-settings)
- [Hyprland 官方文档](https://wiki.hyprland.org/)
- [快捷键配置指南](https://wiki.hyprland.org/Configuring/Binds/)

**配置更新完成！现在的 Hyprland 快捷键与 Cosmic 桌面完全一致。** 🎉
