# Ironbar macOS Tahoe 主题配置

## 概述
此配置为 Ironbar 提供了完整的 macOS Tahoe 风格主题，具有液态玻璃透明效果和胶囊设计。

## 文件结构
```
home/desktop/niri/external/ironbar/
├── config.json    # Ironbar 主配置文件
└── style.css      # macOS Tahoe 主题样式
```

## 主要特性

### 视觉设计
- **液态玻璃效果**: 半透明背景with磨砂玻璃blur效果
- **胶囊形状**: 24px圆角的现代设计
- **macOS色彩方案**: 基于macOS Tahoe的深色主题色彩
- **流体动画**: 200ms流畅过渡动画
- **发光效果**: hover状态的光晕和阴影效果

### 组件配置

#### 启动器 (Launcher)
- 蓝色主题配色
- 支持应用启动
- hover时显示蓝色光晕

#### 工作区 (Workspaces)
- 当前工作区显示蓝色渐变背景
- 未激活工作区半透明显示
- 支持工作区切换动画
- 紧急状态红色闪烁提示

#### 系统组件
- **聚焦窗口**: 显示当前活动窗口标题
- **系统托盘**: 系统应用图标
- **音量控制**: 橙色主题配色
- **电池状态**: 绿色主题配色
- **网络状态**: 蓝色主题配色
- **通知中心**: 红色计数徽章
- **时钟**: 14px粗体字体
- **电源菜单**: 红色主题退出按钮

## 配置说明

### config.json
```json
{
  "layer": "top",                     // 显示在最顶层
  "position": "top",                  // 顶部栏
  "height": 42,                       // 42px高度，符合macOS比例
  "margin": {                         // 8px外边距
    "top": 8,
    "right": 8,
    "left": 8
  },
  "modules": {                        // 12个功能模块
    "start": ["launcher", "workspaces"],
    "center": ["focused"],
    "end": ["tray", "volume", "battery", "network", "notifications", "clock", "power-menu"]
  }
}
```

### style.css 主要特性
- **色彩变量**: 使用@define-color定义统一色彩方案
- **胶囊设计**: 24px圆角主容器
- **毛玻璃效果**: backdrop-filter blur(20px)
- **动画支持**: cubic-bezier缓动函数
- **响应式设计**: 适配不同屏幕尺寸

## 安装使用

1. 确保文件位于正确路径:
   ```
   ~/.config/niri/external/ironbar/config.json
   ~/.config/niri/external/ironbar/style.css
   ```

2. 更新niri配置启动ironbar:
   ```kdl
   spawn-at-startup "ironbar"
   ```

3. 重启niri或重新加载配置

## 自定义选项

### 颜色主题修改
在 `style.css` 中修改色彩变量：
```css
@define-color tahoe_accent_blue #007AFF;    /* 主题蓝色 */
@define-color tahoe_bg_primary rgba(28, 28, 30, 0.85);  /* 主背景 */
```

### 尺寸调整
修改栏高度：
```json
"height": 42,    /* 调整为所需高度 */
```

### 模块配置
添加或移除模块：
```json
"end": ["tray", "volume", "battery", "network", "clock"]  /* 移除通知和电源菜单 */
```

## 兼容性
- 需要支持Wayland的环境
- 需要GTK 3+环境
- 支持背景blur效果的compositor
- 建议使用支持字体的系统：SF Pro Display, Inter, Noto Sans

## 故障排除

### 样式不生效
1. 检查CSS语法错误
2. 确认ironbar版本支持所有CSS属性
3. 检查字体是否正确安装

### 模块不显示
1. 检查系统依赖(pulseaudio, network-manager等)
2. 确认JSON配置语法正确
3. 查看ironbar日志输出

### 动画卡顿
1. 降低动画时长
2. 检查GPU加速支持
3. 减少blur效果强度

## 维护更新
定期检查ironbar更新，可能需要调整配置以适配新版本特性。
