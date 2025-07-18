# 🎨 Stylix 主题图库

这个文档展示了所有可用的 Stylix 主题选项。你可以在 `laptop.nix` 中通过修改 `colors.scheme` 来切换主题。

## 🌟 自定义主题

### 🤍 简约白色暖色调 (`warm-white`) ⭐ **当前启用**
```nix
colors = {
  enable = true;
  scheme = "warm-white";
};
```
- **背景**: 纯白色 (#fefefe)
- **前景**: 深灰色 (#444444)
- **强调色**: 暖色调（红、橙、黄、绿等）
- **适用场景**: 日常办公、编程开发、长时间使用
- **特点**: 护眼、简约、温暖

### 🩵 冷静蓝色主题 (`cool-blue`)
```nix
colors = {
  enable = true;
  scheme = "cool-blue";
};
```
- **背景**: 冰雪白 (#f8fafc)
- **前景**: 深蓝灰 (#334155)
- **强调色**: 冷色调（蓝、青、紫等）
- **适用场景**: 专业工作、技术文档、代码审查
- **特点**: 专业、冷静、高效

### 🌿 森林绿色主题 (`forest-green`)
```nix
colors = {
  enable = true;
  scheme = "forest-green";
};
```
- **背景**: 薄荷白 (#f7fdf7)
- **前景**: 深绿 (#166534)
- **强调色**: 自然色调（绿、棕、金等）
- **适用场景**: 创意工作、自然主题、环保应用
- **特点**: 自然、清新、舒适

### 🧡 日落橙色主题 (`sunset-orange`)
```nix
colors = {
  enable = true;
  scheme = "sunset-orange";
};
```
- **背景**: 奶油白 (#fffbf5)
- **前景**: 深橙 (#9a3412)
- **强调色**: 暖夕阳色调（橙、红、金等）
- **适用场景**: 创意设计、温馨应用、艺术项目
- **特点**: 温暖、活力、创意

### 💜 薰衣草紫色主题 (`lavender-purple`)
```nix
colors = {
  enable = true;
  scheme = "lavender-purple";
};
```
- **背景**: 淡紫白 (#faf5ff)
- **前景**: 深紫 (#6b21a8)
- **强调色**: 优雅紫色调（紫、粉、蓝等）
- **适用场景**: 优雅应用、女性向设计、艺术项目
- **特点**: 优雅、柔和、精致

### 🖤 优雅深色主题 (`dark-elegant`)
```nix
colors = {
  enable = true;
  scheme = "dark-elegant";
};
```
- **背景**: 深黑 (#0f0f0f)
- **前景**: 浅灰 (#b4b4b4)
- **强调色**: 柔和色调（柔和红、蓝、绿等）
- **适用场景**: 夜间工作、护眼、专业开发
- **特点**: 优雅、护眼、专业

## 🔥 经典预设主题

### Gruvbox 系列
- `gruvbox-light` - 经典暖色亮色主题
- `gruvbox-dark-hard` - 经典暖色深色主题

### Solarized 系列
- `solarized-light` - 经典护眼亮色主题
- `solarized-dark` - 经典护眼深色主题

### 现代主题
- `nord` - 北欧风冷色调主题
- `dracula` - 流行的深色主题
- `tokyo-night` - 东京夜色主题

### Catppuccin 系列
- `catppuccin-latte` - 现代亮色主题
- `catppuccin-mocha` - 现代深色主题

### Atom 系列
- `one-light` - Atom 编辑器亮色主题
- `one-dark` - Atom 编辑器深色主题

## 🔄 动态主题
- `auto` - 从壁纸自动生成颜色方案

## 🚀 如何切换主题

在 `users/hengvvang/laptop.nix` 中修改：

```nix
profiles = {
  stylix = {
    enable = true;
    polarity = "light";  # 或 "dark"
    
    colors = {
      enable = true;
      scheme = "主题名称";  # 从上面选择
    };
  };
};
```

然后重新构建配置：
```bash
nix build .#homeConfigurations."hengvvang@laptop".activationPackage
./result/activate
```

## 💡 推荐搭配

### 日间工作
- 🤍 `warm-white` + `polarity = "light"`
- 🩵 `cool-blue` + `polarity = "light"`  
- 🌿 `forest-green` + `polarity = "light"`

### 夜间工作
- 🖤 `dark-elegant` + `polarity = "dark"`
- `nord` + `polarity = "dark"`
- `tokyo-night` + `polarity = "dark"`

### 创意工作
- 🧡 `sunset-orange` + `polarity = "light"`
- 💜 `lavender-purple` + `polarity = "light"`
- `dracula` + `polarity = "dark"`
