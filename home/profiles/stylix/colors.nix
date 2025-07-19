{ config, pkgs, lib, ... }:

{
  # 自定义颜色配置
  config = lib.mkIf config.myHome.profiles.stylix.enable {
    # 当启用自定义颜色时，使用 Base16 色彩方案
    stylix = lib.mkIf (config.myHome.profiles.stylix.colors.enable or false) {
      # 根据选择的方案应用不同配置
      base16Scheme = 
        # 🎨 自定义主题系列
        if config.myHome.profiles.stylix.colors.scheme == "warm-white" then {
          scheme = "Warm White Theme";
          author = "Stylix Custom";
          base00 = "fefefe"; base01 = "f5f5f5"; base02 = "e8e8e8"; base03 = "d0d0d0";
          base04 = "868686"; base05 = "444444"; base06 = "2a2a2a"; base07 = "1a1a1a";
          base08 = "d73027"; base09 = "e67e22"; base0A = "f39c12"; base0B = "27ae60";
          base0C = "16a085"; base0D = "3498db"; base0E = "8e44ad"; base0F = "e74c3c";
        } 
        else if config.myHome.profiles.stylix.colors.scheme == "cool-blue" then {
          scheme = "Cool Blue Theme";
          author = "Stylix Custom";
          base00 = "f8fafc"; base01 = "f1f5f9"; base02 = "e2e8f0"; base03 = "cbd5e1";
          base04 = "64748b"; base05 = "334155"; base06 = "1e293b"; base07 = "0f172a";
          base08 = "dc2626"; base09 = "ea580c"; base0A = "d97706"; base0B = "16a34a";
          base0C = "0891b2"; base0D = "2563eb"; base0E = "7c3aed"; base0F = "be185d";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "forest-green" then {
          scheme = "Forest Green Theme";
          author = "Stylix Custom";
          base00 = "f7fdf7"; base01 = "f0fdf4"; base02 = "dcfce7"; base03 = "bbf7d0";
          base04 = "4ade80"; base05 = "166534"; base06 = "14532d"; base07 = "052e16";
          base08 = "dc2626"; base09 = "ea580c"; base0A = "ca8a04"; base0B = "16a34a";
          base0C = "0d9488"; base0D = "0369a1"; base0E = "7c2d12"; base0F = "a16207";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "sunset-orange" then {
          scheme = "Sunset Orange Theme";
          author = "Stylix Custom";
          base00 = "fffbf5"; base01 = "fef7ed"; base02 = "fed7aa"; base03 = "fdba74";
          base04 = "fb923c"; base05 = "9a3412"; base06 = "7c2d12"; base07 = "431407";
          base08 = "dc2626"; base09 = "ea580c"; base0A = "d97706"; base0B = "65a30d";
          base0C = "0891b2"; base0D = "2563eb"; base0E = "7c3aed"; base0F = "a16207";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "lavender-purple" then {
          scheme = "Lavender Purple Theme";
          author = "Stylix Custom";
          base00 = "faf5ff"; base01 = "f3e8ff"; base02 = "e9d5ff"; base03 = "d8b4fe";
          base04 = "a855f7"; base05 = "6b21a8"; base06 = "581c87"; base07 = "3b0764";
          base08 = "dc2626"; base09 = "ea580c"; base0A = "d97706"; base0B = "16a34a";
          base0C = "0891b2"; base0D = "2563eb"; base0E = "7c3aed"; base0F = "be185d";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "dark-elegant" then {
          scheme = "Dark Elegant Theme";
          author = "Stylix Custom";
          base00 = "0f0f0f"; base01 = "1a1a1a"; base02 = "2d2d2d"; base03 = "4a4a4a";
          base04 = "6a6a6a"; base05 = "b4b4b4"; base06 = "d4d4d4"; base07 = "f4f4f4";
          base08 = "ff6b6b"; base09 = "ff9f43"; base0A = "ffd93d"; base0B = "6bcf7f";
          base0C = "4ecdc4"; base0D = "74b9ff"; base0E = "a29bfe"; base0F = "fd79a8";
        }
        
        # 🌹 Rose Pine 系列
        else if config.myHome.profiles.stylix.colors.scheme == "rose-pine" then {
          scheme = "Rosé Pine";
          author = "Emilia Dunfelt";
          base00 = "191724"; base01 = "1f1d2e"; base02 = "26233a"; base03 = "6e6a86";
          base04 = "908caa"; base05 = "e0def4"; base06 = "e0def4"; base07 = "524f67";
          base08 = "eb6f92"; base09 = "f6c177"; base0A = "ebbcba"; base0B = "31748f";
          base0C = "9ccfd8"; base0D = "c4a7e7"; base0E = "f6c177"; base0F = "524f67";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "rose-pine-moon" then {
          scheme = "Rosé Pine Moon";
          author = "Emilia Dunfelt";
          base00 = "232136"; base01 = "2a273f"; base02 = "393552"; base03 = "6e6a86";
          base04 = "908caa"; base05 = "e0def4"; base06 = "e0def4"; base07 = "56526e";
          base08 = "eb6f92"; base09 = "f6c177"; base0A = "ea9a97"; base0B = "3e8fb0";
          base0C = "9ccfd8"; base0D = "c4a7e7"; base0E = "f6c177"; base0F = "56526e";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "rose-pine-dawn" then {
          scheme = "Rosé Pine Dawn";
          author = "Emilia Dunfelt";
          base00 = "faf4ed"; base01 = "fffaf3"; base02 = "f2e9de"; base03 = "9893a5";
          base04 = "797593"; base05 = "575279"; base06 = "575279"; base07 = "cecacd";
          base08 = "b4637a"; base09 = "ea9d34"; base0A = "d7827e"; base0B = "286983";
          base0C = "56949f"; base0D = "907aa9"; base0E = "ea9d34"; base0F = "cecacd";
        }
        
        # 😺 Catppuccin 系列
        else if config.myHome.profiles.stylix.colors.scheme == "catppuccin-latte" then {
          scheme = "Catppuccin Latte";
          author = "Catppuccin Org";
          base00 = "eff1f5"; base01 = "e6e9ef"; base02 = "ccd0da"; base03 = "bcc0cc";
          base04 = "acb0be"; base05 = "4c4f69"; base06 = "dc8a78"; base07 = "7287fd";
          base08 = "d20f39"; base09 = "fe640b"; base0A = "df8e1d"; base0B = "40a02b";
          base0C = "179299"; base0D = "1e66f5"; base0E = "8839ef"; base0F = "dd7878";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "catppuccin-frappe" then {
          scheme = "Catppuccin Frappé";
          author = "Catppuccin Org";
          base00 = "303446"; base01 = "292c3c"; base02 = "414559"; base03 = "51576d";
          base04 = "626880"; base05 = "c6d0f5"; base06 = "f2d5cf"; base07 = "babbf1";
          base08 = "e78284"; base09 = "ef9f76"; base0A = "e5c890"; base0B = "a6d189";
          base0C = "81c8be"; base0D = "8caaee"; base0E = "ca9ee6"; base0F = "eebebe";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "catppuccin-macchiato" then {
          scheme = "Catppuccin Macchiato";
          author = "Catppuccin Org";
          base00 = "24273a"; base01 = "1e2030"; base02 = "363a4f"; base03 = "494d64";
          base04 = "5b6078"; base05 = "cad3f5"; base06 = "f4dbd6"; base07 = "b7bdf8";
          base08 = "ed8796"; base09 = "f5a97f"; base0A = "eed49f"; base0B = "a6da95";
          base0C = "8bd5ca"; base0D = "8aadf4"; base0E = "c6a0f6"; base0F = "f0c6c6";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "catppuccin-mocha" then {
          scheme = "Catppuccin Mocha";
          author = "Catppuccin Org";
          base00 = "1e1e2e"; base01 = "181825"; base02 = "313244"; base03 = "45475a";
          base04 = "585b70"; base05 = "cdd6f4"; base06 = "f5e0dc"; base07 = "b4befe";
          base08 = "f38ba8"; base09 = "fab387"; base0A = "f9e2af"; base0B = "a6e3a1";
          base0C = "94e2d5"; base0D = "89b4fa"; base0E = "cba6f7"; base0F = "f2cdcd";
        }
        
        # 🔥 热门预设主题系列
        else if config.myHome.profiles.stylix.colors.scheme == "tokyo-night" then {
          scheme = "Tokyo Night";
          author = "enkia";
          base00 = "1a1b26"; base01 = "16161e"; base02 = "2f3549"; base03 = "444b6a";
          base04 = "787c99"; base05 = "a9b1d6"; base06 = "cbccd1"; base07 = "d5d6db";
          base08 = "c0caf5"; base09 = "a9b1d6"; base0A = "0db9d7"; base0B = "9ece6a";
          base0C = "b4f9f8"; base0D = "2ac3de"; base0E = "bb9af7"; base0F = "f7768e";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "tokyo-night-light" then {
          scheme = "Tokyo Night Light";
          author = "enkia";
          base00 = "d5d6db"; base01 = "cbccd1"; base02 = "dcd7ba"; base03 = "9699a3";
          base04 = "4c505e"; base05 = "343b58"; base06 = "1a1b26"; base07 = "1a1b26";
          base08 = "8c4351"; base09 = "965027"; base0A = "8f5e15"; base0B = "485e30";
          base0C = "166775"; base0D = "34548a"; base0E = "5a4a78"; base0F = "8c4351";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "tokyo-night-storm" then {
          scheme = "Tokyo Night Storm";
          author = "enkia";
          base00 = "24283b"; base01 = "1f2335"; base02 = "414868"; base03 = "565f89";
          base04 = "9699a3"; base05 = "c0caf5"; base06 = "cbccd1"; base07 = "d5d6db";
          base08 = "f7768e"; base09 = "ff9e64"; base0A = "e0af68"; base0B = "9ece6a";
          base0C = "7dcfff"; base0D = "7aa2f7"; base0E = "bb9af7"; base0F = "f7768e";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "ayu-light" then {
          scheme = "Ayu Light";
          author = "Khue Nguyen";
          base00 = "fafafa"; base01 = "f3f4f5"; base02 = "f8f9fa"; base03 = "abb0b6";
          base04 = "828c99"; base05 = "5c6773"; base06 = "242936"; base07 = "1c212b";
          base08 = "f07178"; base09 = "fa8d3e"; base0A = "f2cc60"; base0B = "86b300";
          base0C = "4cbf99"; base0D = "36a3d9"; base0E = "a37acc"; base0F = "e6ba7e";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "ayu-mirage" then {
          scheme = "Ayu Mirage";
          author = "Khue Nguyen";
          base00 = "1f2430"; base01 = "191e2a"; base02 = "272d38"; base03 = "707a8c";
          base04 = "8a9199"; base05 = "cccac2"; base06 = "d9d7ce"; base07 = "f3f4f5";
          base08 = "f28779"; base09 = "ffad66"; base0A = "ffd173"; base0B = "d5ff80";
          base0C = "95e6cb"; base0D = "5ccfe6"; base0E = "d4bfff"; base0F = "f29e74";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "ayu-dark" then {
          scheme = "Ayu Dark";
          author = "Khue Nguyen";
          base00 = "0a0e14"; base01 = "0d1016"; base02 = "15191f"; base03 = "272d38";
          base04 = "3e4b59"; base05 = "e6e1cf"; base06 = "e6e1cf"; base07 = "f3f4f5";
          base08 = "f07178"; base09 = "ff8f40"; base0A = "ffb454"; base0B = "b8cc52";
          base0C = "95e6cb"; base0D = "59c2ff"; base0E = "d2a6ff"; base0F = "e6b673";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "material-darker" then {
          scheme = "Material Darker";
          author = "Nate Peterson";
          base00 = "212121"; base01 = "303030"; base02 = "353535"; base03 = "4a4a4a";
          base04 = "b2ccd6"; base05 = "eeffff"; base06 = "eeffff"; base07 = "ffffff";
          base08 = "f07178"; base09 = "f78c6c"; base0A = "ffcb6b"; base0B = "c3e88d";
          base0C = "89ddff"; base0D = "82aaff"; base0E = "c792ea"; base0F = "ff5370";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "material-palenight" then {
          scheme = "Material Palenight";
          author = "Whizkydee";
          base00 = "292d3e"; base01 = "444267"; base02 = "32374d"; base03 = "676e95";
          base04 = "8796b0"; base05 = "959dcb"; base06 = "959dcb"; base07 = "ffffff";
          base08 = "f07178"; base09 = "f78c6c"; base0A = "ffcb6b"; base0B = "c3e88d";
          base0C = "89ddff"; base0D = "82aaff"; base0E = "c792ea"; base0F = "ff5370";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "github-light" then {
          scheme = "Github Light";
          author = "defunkt";
          base00 = "ffffff"; base01 = "f5f5f5"; base02 = "c8c8fa"; base03 = "969896";
          base04 = "e8e8e8"; base05 = "333333"; base06 = "ffffff"; base07 = "ffffff";
          base08 = "ed6a43"; base09 = "0086b3"; base0A = "795da3"; base0B = "183691";
          base0C = "183691"; base0D = "795da3"; base0E = "a71d5d"; base0F = "333333";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "github-dark" then {
          scheme = "Github Dark";
          author = "defunkt";
          base00 = "0d1117"; base01 = "161b22"; base02 = "21262d"; base03 = "30363d";
          base04 = "6e7681"; base05 = "c9d1d9"; base06 = "f0f6fc"; base07 = "ffffff";
          base08 = "f85149"; base09 = "ff7b72"; base0A = "d29922"; base0B = "56d364";
          base0C = "39c5cf"; base0D = "58a6ff"; base0E = "bc8cff"; base0F = "ffa198";
        }
        else if config.myHome.profiles.stylix.colors.scheme == "monokai" then {
          scheme = "Monokai";
          author = "Wimer Hazenberg";
          base00 = "272822"; base01 = "383830"; base02 = "49483e"; base03 = "75715e";
          base04 = "a59f85"; base05 = "f8f8f2"; base06 = "f5f4f1"; base07 = "f9f8f5";
          base08 = "f92672"; base09 = "fd971f"; base0A = "f4bf75"; base0B = "a6e22e";
          base0C = "a1efe4"; base0D = "66d9ef"; base0E = "ae81ff"; base0F = "cc6633";
        }
        
        else if config.myHome.profiles.stylix.colors.scheme == "lavender-purple" then {
          # 💜 Base16 配色方案 - 薰衣草紫色主题
          scheme = "Lavender Purple Theme";
          author = "Stylix Custom";
          base00 = "faf5ff";  # 背景 - 淡紫白
          base01 = "f3e8ff";  # 较深背景 - 浅紫白
          base02 = "e9d5ff";  # 选择背景 - 紫白
          base03 = "d8b4fe";  # 注释 - 浅紫
          base04 = "a855f7";  # 暗前景 - 中紫
          base05 = "6b21a8";  # 默认前景 - 深紫
          base06 = "581c87";  # 亮前景 - 更深紫
          base07 = "3b0764";  # 最亮前景 - 深紫黑
          
          # 优雅紫色调强调色
          base08 = "dc2626";  # 红色 - 优雅红
          base09 = "ea580c";  # 橙色 - 暖橙
          base0A = "d97706";  # 黄色 - 金黄
          base0B = "16a34a";  # 绿色 - 薄荷绿
          base0C = "0891b2";  # 青色 - 天青
          base0D = "2563eb";  # 蓝色 - 经典蓝
          base0E = "7c3aed";  # 紫色 - 薰衣草紫
          base0F = "be185d";  # 棕色 - 玫瑰棕
        }
        else if config.myHome.profiles.stylix.colors.scheme == "dark-elegant" then {
          # 🖤 Base16 配色方案 - 优雅深色主题
          scheme = "Dark Elegant Theme";
          author = "Stylix Custom";
          base00 = "0f0f0f";  # 背景 - 深黑
          base01 = "1a1a1a";  # 较深背景 - 中黑
          base02 = "2d2d2d";  # 选择背景 - 浅黑
          base03 = "4a4a4a";  # 注释 - 深灰
          base04 = "6a6a6a";  # 暗前景 - 中灰
          base05 = "b4b4b4";  # 默认前景 - 浅灰
          base06 = "d4d4d4";  # 亮前景 - 更浅灰
          base07 = "f4f4f4";  # 最亮前景 - 近白
          
          # 优雅深色调强调色
          base08 = "ff6b6b";  # 红色 - 柔和红
          base09 = "ff9f43";  # 橙色 - 暖橙
          base0A = "ffd93d";  # 黄色 - 亮黄
          base0B = "6bcf7f";  # 绿色 - 柔和绿
          base0C = "4ecdc4";  # 青色 - 薄荷青
          base0D = "74b9ff";  # 蓝色 - 柔和蓝
          base0E = "a29bfe";  # 紫色 - 柔和紫
          base0F = "fd79a8";  # 棕色 - 粉红
        }
        else if config.myHome.profiles.stylix.colors.scheme != "auto" then
          "${pkgs.base16-schemes}/share/themes/${config.myHome.profiles.stylix.colors.scheme}.yaml"
        else null;
    };
  };
}
