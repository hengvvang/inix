# Dunst vs Mako 对比指南

详细对比 Dunst 和 Mako 两个通知守护进程，帮助你选择最适合的方案。

## 📊 功能对比表

| 特性 | Dunst | Mako | 说明 |
|------|-------|------|------|
| 🎨 **主题支持** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Dunst 配置更灵活 |
| ⚡ **性能** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Mako 更轻量 |
| 🔧 **配置复杂度** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Mako 配置更简单 |
| 📱 **移动端风格** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 两者都很好 |
| 🎯 **规则匹配** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | Dunst 规则更强大 |
| 📚 **文档完整度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Dunst 文档更详细 |
| 🐛 **稳定性** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Dunst 更成熟 |

## 🎨 视觉效果对比

### macOS Tahoe 风格支持

#### Dunst
✅ **优势：**
- 更细致的毛玻璃效果控制
- 支持复杂的分层样式
- 详细的进度条自定义
- 丰富的应用特定样式

❌ **劣势：**
- 配置文件较长
- 学习曲线稍陡

#### Mako
✅ **优势：**
- 配置简洁直观
- 开箱即用的美观效果
- 更好的 Wayland 集成
- 动画效果更流畅

❌ **劣势：**
- 自定义选项相对较少
- 某些高级功能需要其他工具配合

## ⚙️ 配置对比

### Dunst 配置特点
```ini
# 分段式配置，功能强大
[global]
    # 全局设置
    font = LXGW WenKai Mono 13
    corner_radius = 18

[urgency_low]
    # 低优先级样式
    background = "#1d1d1f12"

[appname_Music]
    # 应用特定样式
    background = "#32d74b20"
```

### Mako 配置特点
```bash
# 简洁的命令行风格配置
font=LXGW WenKai Mono 13
border-radius=18
background-color=#1d1d1f18

# 条件配置
[urgency=low]
background-color=#1d1d1f12

[app-name="Music"]
background-color=#32d74b20
```

## 🚀 性能对比

### 内存使用
- **Mako**: ~2-5MB RAM
- **Dunst**: ~5-10MB RAM

### CPU 使用
- **Mako**: 极低 CPU 使用率
- **Dunst**: 低 CPU 使用率，处理复杂规则时略高

### 启动时间
- **Mako**: 几乎瞬时启动
- **Dunst**: 快速启动，配置复杂时稍慢

## 🎯 使用场景推荐

### 选择 Dunst 如果你：
- 🎨 需要高度自定义的通知样式
- 📱 有复杂的通知分类需求
- 🔧 喜欢折腾配置细节
- 📚 需要详细的文档支持
- 🎭 要为不同应用设置不同样式
- 📊 需要复杂的过滤规则

### 选择 Mako 如果你：
- ⚡ 优先考虑性能和速度
- 🎯 喜欢简洁的配置
- 🌊 更重视 Wayland 原生体验
- 💫 需要更流畅的动画效果
- 🎨 满足于美观的默认样式
- 🚀 希望快速设置完成

## 📋 功能详细对比

### 通知管理

#### Dunst
```bash
# 丰富的控制命令
dunstctl close              # 关闭当前
dunstctl close-all          # 关闭所有
dunstctl history-pop        # 弹出历史
dunstctl context            # 上下文菜单
dunstctl action             # 执行操作
dunstctl reload            # 重新加载配置
```

#### Mako
```bash
# 简洁的控制命令
makoctl dismiss            # 关闭当前
makoctl dismiss -a         # 关闭所有
makoctl history            # 显示历史
makoctl reload             # 重新加载配置
```

### 样式自定义

#### Dunst 样式选项
- ✅ 分离的边框样式
- ✅ 复杂的文本格式化
- ✅ 多级嵌套规则
- ✅ 条件样式匹配
- ✅ 详细的进度条控制
- ✅ 键盘快捷键绑定

#### Mako 样式选项
- ✅ 简洁的毛玻璃效果
- ✅ 流畅的动画
- ✅ 基础的条件样式
- ✅ 紧凑的配置语法
- ✅ 好看的默认样式

## 🔄 迁移指南

### 从 Mako 迁移到 Dunst
1. 备份当前 Mako 配置
2. 启用 Dunst 配置：
   ```bash
   # 禁用 mako
   systemctl --user disable mako
   
   # 启用 dunst
   systemctl --user enable dunst
   ```
3. 转换配置规则
4. 测试通知效果

### 从 Dunst 迁移到 Mako
1. 记录当前 Dunst 样式
2. 启用 Mako 配置：
   ```bash
   # 禁用 dunst
   systemctl --user disable dunst
   
   # 启用 mako
   systemctl --user enable mako
   ```
3. 简化配置规则
4. 测试通知效果

## 🛠️ 实际使用建议

### 初学者推荐
🎯 **推荐 Mako**
- 配置简单，容易上手
- 默认效果就很美观
- 性能开销小
- 文档清晰易懂

### 高级用户推荐
🎯 **推荐 Dunst**
- 配置选项丰富
- 可以实现复杂的通知逻辑
- 支持详细的样式控制
- 社区支持更好

### 性能敏感场景
🎯 **推荐 Mako**
- 内存占用更少
- CPU 使用率更低
- 启动速度更快
- 对系统影响最小

### 高度定制场景
🎯 **推荐 Dunst**
- 支持复杂的过滤规则
- 可以针对不同应用设置不同样式
- 提供详细的进度条控制
- 支持键盘快捷键

## 🎨 我们的配置特色

### 本配置的 Dunst 版本
- 🌙 与 Mako 版本保持视觉一致
- 📱 相同的 macOS Tahoe 风格
- 🎯 丰富的应用特定样式
- 🔧 强大的主题切换功能
- 📊 详细的系统集成脚本

### 本配置的 Mako 版本
- ☀️ 简洁优雅的配置
- ⚡ 优化的性能表现
- 🎨 开箱即用的美观效果
- 🌊 流畅的 Wayland 体验

## 💡 选择建议

### 如果你不确定选择哪个：
1. **先试用 Mako**（配置简单，快速体验）
2. **需要更多自定义时切换到 Dunst**
3. **两个配置都可以无缝切换**

### 快速切换命令
```bash
# 切换到 Mako
systemctl --user stop dunst
systemctl --user start mako

# 切换到 Dunst  
systemctl --user stop mako
systemctl --user start dunst
```

## 🎉 结论

**Dunst** 和 **Mako** 都是优秀的通知系统，选择主要取决于你的需求：

- 🎨 **重视自定义** → Dunst
- ⚡ **重视性能** → Mako  
- 🔧 **喜欢折腾** → Dunst
- 🎯 **要求简洁** → Mako

两个配置都能提供出色的 macOS Tahoe 风格体验！