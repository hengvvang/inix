#!/bin/bash
# MPD 音乐目录迁移脚本

set -e

OLD_DIR="/srv/music"
NEW_DIR="$HOME/Music"

echo "🎵 MPD 音乐目录迁移工具"
echo "================================"
echo "从: $OLD_DIR"
echo "到: $NEW_DIR"
echo ""

# 检查旧目录
if [ ! -d "$OLD_DIR" ]; then
    echo "ℹ️  旧目录不存在，创建新目录..."
    mkdir -p "$NEW_DIR"
    echo "✅ 已创建音乐目录: $NEW_DIR"
    exit 0
fi

# 检查是否有音乐文件
if [ ! "$(ls -A $OLD_DIR 2>/dev/null)" ]; then
    echo "ℹ️  旧目录为空，创建新目录..."
    mkdir -p "$NEW_DIR"
    echo "✅ 已创建音乐目录: $NEW_DIR"
    exit 0
fi

# 创建新目录
mkdir -p "$NEW_DIR"

# 移动文件
echo "📂 开始迁移音乐文件..."
if sudo cp -r "$OLD_DIR"/* "$NEW_DIR"/; then
    echo "✅ 文件复制完成"
    
    # 修改权限
    chown -R "$USER:$USER" "$NEW_DIR"
    echo "✅ 权限设置完成"
    
    # 显示统计
    FILE_COUNT=$(find "$NEW_DIR" -type f | wc -l)
    echo "📊 迁移完成: 共 $FILE_COUNT 个文件"
    
    echo ""
    echo "⚠️  旧目录 $OLD_DIR 仍然存在"
    echo "💡 确认新目录工作正常后，可手动删除："
    echo "   sudo rm -rf $OLD_DIR"
    
else
    echo "❌ 迁移失败"
    exit 1
fi

echo ""
echo "🔄 请重新构建配置以应用更改："
echo "   nix build .#homeConfigurations.\"hengvvang@laptop\".activationPackage"
echo "   ./result/activate"
echo ""
echo "🎵 然后更新 MPD 数据库："
echo "   mpc update"
