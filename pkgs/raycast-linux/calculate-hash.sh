#!/usr/bin/env bash

# 计算 raycast-linux AppImage 的 hash
# 使用方法: ./calculate-hash.sh

set -e

echo "正在下载 raycast-linux AppImage 来计算 hash..."

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# 下载文件
curl -L -o raycast-linux.AppImage "https://github.com/ByteAtATime/raycast-linux/releases/download/v0.1.0-alpha/raycast-linux.AppImage"

# 计算 SHA256 hash
HASH=$(nix-hash --type sha256 --flat --base32 raycast-linux.AppImage)

echo "计算出的 hash: sha256-$HASH"
echo ""
echo "请将以下内容复制到 default.nix 文件中："
echo "    hash = \"sha256-$HASH\";"

# 清理
cd /
rm -rf "$TEMP_DIR"

echo ""
echo "完成！"
