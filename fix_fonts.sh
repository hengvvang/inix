#!/bin/bash

# 修复字体配置文件中的 fontconfig 问题
files=("bauhaus" "forest" "nordic" "tokyo" "vintage" "sakura" "ocean" "zen")

for file in "${files[@]}"; do
    echo "Processing $file.nix"
    
    # 读取文件内容，移除无效的 fontconfig 选项
    sed -i '
        /# 字体渲染优化/,/};/{
            /# 字体渲染优化/d
            /subpixel = {/,/};/d
            /antialias = true;/d
            /hinting = {/,/};/d
        }
        /# 高清渲染设置/,/};/{
            /# 高清渲染设置/d
            /subpixel = {/,/};/d
            /# 清晰度优化/d
            /antialias = true;/d
            /hinting = {/,/};/d
        }
        /# 抗锯齿设置/,/};/{
            /# 抗锯齿设置/d
            /antialias = true;/d
            /hinting = {/,/};/d
        }
        /# 字体替换规则/,/localConf/{
            /# 字体替换规则/d
            /localConf = '"'"''"'"'/,/'"'"''"'"';/d
        }
    ' "home/profiles/fonts/$file.nix"
done

echo "All font files processed"
