#!/usr/bin/env bash

# 🎨 生成主题颜色预览
# 这个脚本会输出所有主题的颜色方案预览

set -euo pipefail

echo "🎨 Stylix 主题颜色预览"
echo "======================="

# 🤍 简约白色暖色调
echo ""
echo "🤍 简约白色暖色调 (warm-white) ⭐ 当前启用"
echo "背景: #fefefe (纯白色)"
echo "前景: #444444 (深灰色)"
echo "强调色: #d73027(红) #e67e22(橙) #f39c12(黄) #27ae60(绿) #16a085(青) #3498db(蓝) #8e44ad(紫)"
echo ""

# 🩵 冷静蓝色
echo "🩵 冷静蓝色主题 (cool-blue)"
echo "背景: #f8fafc (冰雪白)"
echo "前景: #334155 (深蓝灰)"
echo "强调色: #dc2626(红) #ea580c(橙) #d97706(黄) #16a34a(绿) #0891b2(青) #2563eb(蓝) #7c3aed(紫)"
echo ""

# 🌿 森林绿色
echo "🌿 森林绿色主题 (forest-green)"
echo "背景: #f7fdf7 (薄荷白)"
echo "前景: #166534 (深绿)"
echo "强调色: #dc2626(红) #ea580c(橙) #ca8a04(黄) #16a34a(绿) #0d9488(青) #0369a1(蓝) #7c2d12(紫)"
echo ""

# 🧡 日落橙色
echo "🧡 日落橙色主题 (sunset-orange)"
echo "背景: #fffbf5 (奶油白)"
echo "前景: #9a3412 (深橙)"
echo "强调色: #dc2626(红) #ea580c(橙) #d97706(黄) #65a30d(绿) #0891b2(青) #2563eb(蓝) #7c3aed(紫)"
echo ""

# 💜 薰衣草紫色
echo "💜 薰衣草紫色主题 (lavender-purple)"
echo "背景: #faf5ff (淡紫白)"
echo "前景: #6b21a8 (深紫)"
echo "强调色: #dc2626(红) #ea580c(橙) #d97706(黄) #16a34a(绿) #0891b2(青) #2563eb(蓝) #7c3aed(紫)"
echo ""

# 🖤 优雅深色
echo "🖤 优雅深色主题 (dark-elegant)"
echo "背景: #0f0f0f (深黑)"
echo "前景: #b4b4b4 (浅灰)"
echo "强调色: #ff6b6b(红) #ff9f43(橙) #ffd93d(黄) #6bcf7f(绿) #4ecdc4(青) #74b9ff(蓝) #a29bfe(紫)"
echo ""

echo "💡 切换主题指南:"
echo "1. 运行 './switch-theme.sh' 进入交互式选择"
echo "2. 运行 './switch-theme.sh 主题名称' 直接切换"
echo "3. 查看 'docs/stylix-theme-gallery.md' 获取完整文档"
echo ""

echo "🚀 快速切换示例:"
echo "   ./switch-theme.sh warm-white    # 切换到简约白色"
echo "   ./switch-theme.sh cool-blue     # 切换到冷静蓝色"
echo "   ./switch-theme.sh dark-elegant  # 切换到优雅深色"
