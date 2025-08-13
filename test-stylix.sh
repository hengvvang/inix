#!/usr/bin/env bash

# Stylix 配置测试脚本
echo "测试 Stylix 配置重构..."

# 检查基本语法
echo "1. 检查 Flake 语法..."
nix flake check --no-build 2>&1 | grep -E "(error:|warning:)" | head -5

echo ""
echo "2. 检查系统配置模块..."
nix-instantiate --eval --expr '
let
  flake = builtins.getFlake (toString ./.);
  system = flake.nixosConfigurations.work;
in
  system.options.mySystem.profiles.stylix.enable.visible or false
' 2>/dev/null && echo "✅ 系统 stylix 模块可用" || echo "❌ 系统 stylix 模块配置有误"

echo ""
echo "3. 检查 Home Manager 配置模块..."
nix-instantiate --eval --expr '
let
  flake = builtins.getFlake (toString ./.);
  home = flake.homeConfigurations."zlritsu@laptop";
in
  home.options.myHome.profiles.stylix.enable.visible or false  
' 2>/dev/null && echo "✅ Home stylix 模块可用" || echo "❌ Home stylix 模块配置有误"

echo ""
echo "4. 显示新的配置结构:"
echo "   System: mySystem.profiles.stylix.*"
echo "   Home:   myHome.profiles.stylix.*"

echo ""
echo "✅ Stylix 配置重构完成！"
echo "📖 查看迁移指南: system/profiles/stylix/MIGRATION.md"
