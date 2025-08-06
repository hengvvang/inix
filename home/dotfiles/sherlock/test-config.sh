#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nix

# Sherlock Dotfiles Configuration Test
# 测试所有配置方法的语法正确性

echo "🔍 Testing Sherlock Dotfiles Configuration..."
echo

# Test main configuration
echo "📝 Testing main configuration..."
if nix-instantiate --parse /home/hengvvang/config.d/home/dotfiles/sherlock/default.nix >/dev/null 2>&1; then
    echo "✅ Main configuration syntax: OK"
else
    echo "❌ Main configuration syntax: FAILED"
    exit 1
fi

# Test each configuration method
for method in external homemanager direct xdirect; do
    echo "📝 Testing $method configuration..."
    config_file="/home/hengvvang/config.d/home/dotfiles/sherlock/$method/default.nix"
    
    if [[ -f "$config_file" ]]; then
        if nix-instantiate --parse "$config_file" >/dev/null 2>&1; then
            echo "✅ $method configuration syntax: OK"
        else
            echo "❌ $method configuration syntax: FAILED"
            exit 1
        fi
    else
        echo "❌ $method configuration file not found"
        exit 1
    fi
done

# Test external configuration files
echo "📝 Testing external configuration files..."
external_dir="/home/hengvvang/config.d/home/dotfiles/sherlock/external/configs"

declare -A expected_files=(
    ["config.toml"]="TOML configuration"
    ["themes/tahoe-auto.css"]="CSS theme"
    ["fallback.json"]="JSON fallback launchers"
    ["sherlock_alias.json"]="JSON aliases"
    ["sherlockignore"]="Ignore list"
    ["sherlock_actions.json"]="JSON actions"
)

for file in "${!expected_files[@]}"; do
    full_path="$external_dir/$file"
    if [[ -f "$full_path" ]]; then
        echo "✅ ${expected_files[$file]}: EXISTS"
    else
        echo "❌ ${expected_files[$file]}: MISSING ($full_path)"
        exit 1
    fi
done

echo
echo "🎉 All Sherlock dotfiles configurations are valid!"
echo "📊 Configuration Summary:"
echo "   • Main configuration: ✅"
echo "   • External mode: ✅ (macOS Tahoe theme)"
echo "   • HomeManager mode: ✅"
echo "   • Direct mode: ✅"
echo "   • XDirect mode: ✅ (minimal)"
echo "   • External configs: ✅ (6 files)"
echo
echo "🚀 Usage: Set myHome.dotfiles.sherlock.enable = true; and choose method"
echo "💡 Recommended: method = \"external\" for macOS Tahoe styling"
