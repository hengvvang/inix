#!/usr/bin/env bash

# 更新 Sherlock Launcher 包的脚本
# 这个脚本会帮助你获取正确的源代码哈希值和 Cargo 哈希值

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Sherlock Launcher 包更新脚本${NC}"
echo "======================================"

# 获取当前版本
CURRENT_VERSION=$(grep 'version = ' /home/hengvvang/config.d/pkgs/sherlock-launcher/default.nix | sed 's/.*version = "\(.*\)";/\1/')
echo -e "${BLUE}当前版本: ${YELLOW}$CURRENT_VERSION${NC}"

# 1. 使用 nix-prefetch-github 获取源代码哈希
echo -e "${YELLOW}1. 获取源代码哈希值...${NC}"

echo -e "${BLUE}运行 nix-prefetch-github 来获取源代码哈希...${NC}"
if command -v nix-prefetch-github >/dev/null 2>&1; then
    # 直接使用 nix-prefetch-github
    result=$(nix-prefetch-github Skxxtz sherlock --rev "v$CURRENT_VERSION" 2>/dev/null || true)
else
    # 使用 nix-shell 运行
    result=$(nix-shell -p nix-prefetch-github --run "nix-prefetch-github Skxxtz sherlock --rev v$CURRENT_VERSION" 2>/dev/null || true)
fi

if [ -n "$result" ]; then
    src_hash=$(echo "$result" | grep '"hash":' | sed 's/.*"hash": *"\([^"]*\)".*/\1/')
    echo -e "${GREEN}源代码哈希: $src_hash${NC}"
else
    echo -e "${RED}无法获取源代码哈希，请手动更新${NC}"
    src_hash="sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
fi

# 2. 获取 Cargo 哈希 - 使用更智能的方法
echo -e "${YELLOW}2. 获取 Cargo 哈希值...${NC}"

package_file="/home/hengvvang/config.d/pkgs/sherlock-launcher/default.nix"

# 临时设置为 lib.fakeHash 来获取真实哈希
sed -i 's/cargoHash = "sha256-[A-Za-z0-9+/=]*";/cargoHash = lib.fakeHash;/' "$package_file"

echo -e "${BLUE}运行 nix build 来获取 Cargo 哈希...${NC}"
cd /home/hengvvang/config.d

# 捕获构建输出并提取哈希
cargo_hash_output=$(nix build .#sherlock-launcher 2>&1 || true)

if echo "$cargo_hash_output" | grep -q "got:"; then
    cargo_hash=$(echo "$cargo_hash_output" | grep "got:" | tail -1 | sed 's/.*got: *\(sha256-[A-Za-z0-9+/=]*\).*/\1/')
    echo -e "${GREEN}Cargo 哈希: $cargo_hash${NC}"

    # 更新 cargo 哈希
    sed -i "s/cargoHash = lib.fakeHash;/cargoHash = \"$cargo_hash\";/" "$package_file"
else
    echo -e "${RED}无法自动获取 Cargo 哈希，请手动构建${NC}"
    echo "错误信息: $cargo_hash_output"
    cargo_hash="sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB="
    # 恢复原来的占位符
    sed -i 's/cargoHash = lib.fakeHash;/cargoHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";/' "$package_file"
fi

# 3. 更新源代码哈希
if [ "$src_hash" != "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=" ]; then
    echo -e "${YELLOW}3. 更新源代码哈希...${NC}"
    sed -i "s/hash = \"sha256-[A-Za-z0-9+/=]*\";/hash = \"$src_hash\";/" "$package_file"
    echo -e "${GREEN}✓ 源代码哈希已更新${NC}"
fi

# 4. 显示摘要
echo ""
echo -e "${BLUE}更新摘要:${NC}"
echo "================================"
echo -e "版本:       ${GREEN}$CURRENT_VERSION${NC}"
echo -e "源代码哈希: ${GREEN}$src_hash${NC}"
echo -e "Cargo 哈希:  ${GREEN}$cargo_hash${NC}"
echo ""
echo -e "${YELLOW}接下来的步骤:${NC}"
echo "1. 检查包定义文件是否正确更新"
echo "2. 运行 'nix build .#sherlock-launcher' 来测试构建"
echo "3. 如果构建成功，你就可以使用这个自定义包了"

echo ""
echo -e "${GREEN}脚本执行完成！${NC}"
