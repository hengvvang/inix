#!/usr/bin/env bash

# Sherlock Launcher 测试脚本
# 用于验证自定义包是否正确构建和工作

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Sherlock Launcher 测试脚本${NC}"
echo "=================================="

# 1. 检查构建
echo -e "${YELLOW}1. 检查包构建状态...${NC}"

cd /home/hengvvang/config.d

if nix build .#sherlock-launcher --quiet >/dev/null 2>&1; then
    echo -e "${GREEN}✓ 包构建成功${NC}"
else
    echo -e "${RED}✗ 包构建失败${NC}"
    echo "请运行 'nix build .#sherlock-launcher' 查看详细错误"
    exit 1
fi

# 2. 检查可执行文件
echo -e "${YELLOW}2. 检查可执行文件...${NC}"

SHERLOCK_PATH=$(nix build .#sherlock-launcher --print-out-paths 2>/dev/null)/bin/sherlock

if [ -f "$SHERLOCK_PATH" ]; then
    echo -e "${GREEN}✓ 可执行文件存在: $SHERLOCK_PATH${NC}"
else
    echo -e "${RED}✗ 找不到可执行文件${NC}"
    exit 1
fi

# 3. 检查版本
echo -e "${YELLOW}3. 检查版本信息...${NC}"

VERSION_OUTPUT=$($SHERLOCK_PATH --version 2>/dev/null || echo "无法获取版本")
echo -e "${BLUE}版本信息: ${GREEN}$VERSION_OUTPUT${NC}"

# 4. 检查帮助信息
echo -e "${YELLOW}4. 检查帮助信息...${NC}"

if $SHERLOCK_PATH --help >/dev/null 2>&1; then
    echo -e "${GREEN}✓ 帮助信息正常${NC}"
else
    echo -e "${YELLOW}⚠ 帮助信息可能有问题${NC}"
fi

# 5. 检查依赖
echo -e "${YELLOW}5. 检查动态库依赖...${NC}"

missing_deps=()
if command -v ldd >/dev/null 2>&1; then
    # 检查是否有缺失的动态库
    ldd_output=$(ldd "$SHERLOCK_PATH" 2>/dev/null || echo "")
    if echo "$ldd_output" | grep -q "not found"; then
        missing_deps=($(echo "$ldd_output" | grep "not found" | awk '{print $1}'))
        echo -e "${RED}✗ 缺失的动态库:${NC}"
        for dep in "${missing_deps[@]}"; do
            echo -e "  ${RED}- $dep${NC}"
        done
    else
        echo -e "${GREEN}✓ 所有动态库依赖都已满足${NC}"
    fi
else
    echo -e "${YELLOW}⚠ 无法检查动态库依赖 (ldd 不可用)${NC}"
fi

# 6. 大小检查
echo -e "${YELLOW}6. 检查二进制文件大小...${NC}"

if [ -f "$SHERLOCK_PATH" ]; then
    SIZE=$(du -h "$SHERLOCK_PATH" | cut -f1)
    echo -e "${BLUE}二进制文件大小: ${GREEN}$SIZE${NC}"
fi

# 7. 提供使用建议
echo ""
echo -e "${BLUE}测试完成！${NC}"
echo "=================================="

if [ ${#missing_deps[@]} -eq 0 ]; then
    echo -e "${GREEN}✓ 包已成功构建并可以使用${NC}"
    echo ""
    echo -e "${YELLOW}使用方法:${NC}"
    echo "1. 直接运行: $SHERLOCK_PATH"
    echo "2. 添加到系统包: 在 NixOS 配置中包含此包"
    echo "3. 初始化配置: $SHERLOCK_PATH init"
    echo ""
    echo -e "${YELLOW}快捷键设置示例 (Hyprland):${NC}"
    echo 'bind = SUPER, SPACE, exec, sherlock'
else
    echo -e "${RED}✗ 包存在依赖问题，可能无法正常运行${NC}"
    echo "请检查构建配置或系统环境"
fi

echo ""
echo -e "${BLUE}官方文档: ${YELLOW}https://github.com/Skxxtz/sherlock${NC}"
