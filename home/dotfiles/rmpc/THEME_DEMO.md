# RMPC Rose Pine 主题系列演示

## 🌙 Rose Pine 主题系列特性

Rose Pine 是一个优雅的主题系列，包含三种变体，专为不同使用场景设计：

### 🎨 主题变体

#### 1. 🌑 Rose Pine (深色主题)
- **使用场景**: 夜间使用，长时间音乐欣赏
- **基础配色**: 深紫色系，护眼舒适
- **主要颜色**:
  - Base: `#191724` - 深紫色背景
  - Text: `#e0def4` - 柔和白色文本
  - Iris: `#c4a7e7` - 紫色强调
  - Rose: `#ebbcba` - 粉色进度条

#### 2. ☀️ Rose Pine Dawn (浅色主题)
- **使用场景**: 白天使用，明亮环境
- **基础配色**: 温暖米白色系
- **主要颜色**:
  - Base: `#faf4ed` - 米白色背景
  - Text: `#575279` - 深紫色文本
  - Iris: `#907aa9` - Dawn 紫色强调
  - Rose: `#d7827e` - Dawn 粉色进度条

#### 3. 🌙 Rose Pine Moon (月光主题)
- **使用场景**: 黄昏时光，中等光线环境
- **基础配色**: 深蓝紫色系，平衡对比度
- **主要颜色**:
  - Base: `#232136` - 深蓝紫背景
  - Text: `#e0def4` - 柔和白色文本
  - Iris: `#c4a7e7` - 紫色强调
  - Rose: `#ea9a97` - Moon 粉色进度条

### 🎵 界面元素统一设计

所有主题变体都包含完整的界面元素配色：
- **标签栏**: 活动/非活动状态清晰区分
- **进度条**: 渐变色彩，缓冲区显示
- **播放状态**: 色彩语义化状态指示
- **音量控制**: 直观的音量条显示
- **搜索高亮**: 金色关键词高亮
- **边框装饰**: 优雅的 Unicode 边框字符

### 🔧 主题配置结构

主题文件位于 `configs/themes/` 目录：
```
configs/
└── themes/
    ├── rose-pine.ron       # 深色主题
    ├── rose-pine-dawn.ron  # 浅色主题
    └── rose-pine-moon.ron  # 月光主题
```

## 📥 安装使用

### 1. 启用配置 - 三种主题可选
```nix
# 深色主题 (推荐)
myHome.dotfiles.rmpc = {
  enable = true;
  method = "homemanager";
  theme = "rose-pine";           # 深色主题
};

# 浅色主题
myHome.dotfiles.rmpc = {
  enable = true;
  method = "homemanager";
  theme = "rose-pine-dawn";      # 浅色主题
};

# 月光主题
myHome.dotfiles.rmpc = {
  enable = true;
  method = "homemanager";
  theme = "rose-pine-moon";      # 月光主题
};
```

### 2. 应用配置
```bash
home-manager switch --flake .#hengvvang@laptop
```

### 3. 启动 RMPC
```bash
rmpc
```

## 🔧 主题自定义

如需自定义主题，可以编辑：
- 主题文件：`~/.config/rmpc/themes/rose-pine.ron`
- 配置文件：`~/.config/rmpc/config.ron`

## 🎯 功能展示

### 播放界面
- 专辑封面显示（如果可用）
- Rose 粉色进度条
- Gold 金色时间显示
- Iris 紫色音量控制

### 浏览界面
- 艺术家列表：Subtle 灰色文本
- 专辑列表：Text 白色文本
- 歌曲列表：分级色彩显示

### 搜索界面
- Gold 金色搜索关键词高亮
- 分类结果显示
- 快速键盘导航

## 🌈 对比效果

| 元素 | 默认主题 | Rose Pine 主题 |
|------|----------|----------------|
| 背景 | 系统默认 | 深紫色 `#191724` |
| 文本 | 系统默认 | 柔和白色 `#e0def4` |
| 强调色 | 蓝色系 | 紫色系 `#c4a7e7` |
| 进度条 | 基础色彩 | 渐变粉色 |
| 状态显示 | 单调色彩 | 丰富色彩语义 |

## 💡 使用建议

1. **长时间使用**: Rose Pine 深色护眼设计，适合长时间音乐欣赏
2. **夜间模式**: 低亮度色彩，夜间使用更舒适
3. **色彩识别**: 不同功能区域使用不同色彩，操作更直观
4. **视觉层次**: 清晰的色彩层次，信息获取更高效

## 🎪 快捷键说明

Rose Pine 主题保持了完整的 Vim 风格快捷键：
- `p` / `<Space>`: 播放/暂停
- `>` / `<`: 下一首/上一首
- `+` / `-`: 音量调节
- `h` / `l`: 左右导航
- `j` / `k`: 上下导航
- `q`: 退出程序

享受 Rose Pine 主题带来的优雅音乐体验！ 🌙🎵
