#!/bin/bash

echo "=== Bash配置测试 ==="
echo

echo "1. 测试别名:"
echo "   ll -> $(alias ll 2>/dev/null || echo '未找到')"
echo "   la -> $(alias la 2>/dev/null || echo '未找到')"
echo "   .. -> $(alias .. 2>/dev/null || echo '未找到')"
echo

echo "2. 测试函数:"
echo "   mkcd -> $(type mkcd 2>/dev/null | grep -q 'function' && echo '已定义' || echo '未找到')"
echo "   up -> $(type up 2>/dev/null | grep -q 'function' && echo '已定义' || echo '未找到')"
echo "   path -> $(type path 2>/dev/null | grep -q 'function' && echo '已定义' || echo '未找到')"
echo

echo "3. 测试环境变量:"
echo "   STARSHIP_CONFIG: ${STARSHIP_CONFIG:-未设置}"
echo "   EDITOR: ${EDITOR:-未设置}"
echo "   HISTSIZE: ${HISTSIZE:-未设置}"
echo

echo "4. 测试Shell选项:"
echo "   histappend: $(shopt histappend 2>/dev/null || echo '未设置')"
echo "   autocd: $(shopt autocd 2>/dev/null || echo '未设置')"
echo

echo "5. 测试Starship:"
if command -v starship &> /dev/null; then
    echo "   Starship 已安装: $(starship --version)"
else
    echo "   Starship 未安装"
fi

echo
echo "=== 配置测试完成 ==="
