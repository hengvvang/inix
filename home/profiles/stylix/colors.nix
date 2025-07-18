{ config, pkgs, lib, ... }:

{
  # 自定义颜色配置
  config = lib.mkIf config.myHome.profiles.stylix.enable {
    # 当启用自定义颜色时，使用 Base16 色彩方案
    stylix = lib.mkIf (config.myHome.profiles.stylix.colors.enable or false) {
      # 根据选择的方案应用不同配置
      base16Scheme = 
        if config.myHome.profiles.stylix.colors.scheme == "warm-white" then {
          # 🤍 Base16 配色方案 - 简约白色暖色调
          scheme = "Warm White Theme";
          author = "Stylix Custom";
          base00 = "fefefe";  # 背景 - 纯白色
          base01 = "f5f5f5";  # 较深背景 - 浅灰白
          base02 = "e8e8e8";  # 选择背景 - 中灰白
          base03 = "d0d0d0";  # 注释 - 灰色
          base04 = "868686";  # 暗前景 - 中灰
          base05 = "444444";  # 默认前景 - 深灰
          base06 = "2a2a2a";  # 亮前景 - 更深灰
          base07 = "1a1a1a";  # 最亮前景 - 黑色
          
          # 暖色调强调色
          base08 = "d73027";  # 红色 - 温暖的红
          base09 = "e67e22";  # 橙色 - 暖橙
          base0A = "f39c12";  # 黄色 - 暖黄
          base0B = "27ae60";  # 绿色 - 柔和绿
          base0C = "16a085";  # 青色 - 暖青
          base0D = "3498db";  # 蓝色 - 柔和蓝
          base0E = "8e44ad";  # 紫色 - 优雅紫
          base0F = "e74c3c";  # 棕色 - 暖棕红
        } 
        else if config.myHome.profiles.stylix.colors.scheme == "cool-blue" then {
          # 🩵 Base16 配色方案 - 冷静蓝色主题
          scheme = "Cool Blue Theme";
          author = "Stylix Custom";
          base00 = "f8fafc";  # 背景 - 冰雪白
          base01 = "f1f5f9";  # 较深背景 - 浅蓝白
          base02 = "e2e8f0";  # 选择背景 - 蓝灰白
          base03 = "cbd5e1";  # 注释 - 蓝灰
          base04 = "64748b";  # 暗前景 - 中蓝灰
          base05 = "334155";  # 默认前景 - 深蓝灰
          base06 = "1e293b";  # 亮前景 - 更深蓝灰
          base07 = "0f172a";  # 最亮前景 - 深蓝黑
          
          # 冷色调强调色
          base08 = "dc2626";  # 红色 - 清凉红
          base09 = "ea580c";  # 橙色 - 活力橙
          base0A = "d97706";  # 黄色 - 金黄
          base0B = "16a34a";  # 绿色 - 清新绿
          base0C = "0891b2";  # 青色 - 海洋青
          base0D = "2563eb";  # 蓝色 - 经典蓝
          base0E = "7c3aed";  # 紫色 - 深紫
          base0F = "be185d";  # 棕色 - 玫瑰红
        }
        else if config.myHome.profiles.stylix.colors.scheme == "forest-green" then {
          # 🌿 Base16 配色方案 - 森林绿色主题
          scheme = "Forest Green Theme";
          author = "Stylix Custom";
          base00 = "f7fdf7";  # 背景 - 薄荷白
          base01 = "f0fdf4";  # 较深背景 - 浅绿白
          base02 = "dcfce7";  # 选择背景 - 绿白
          base03 = "bbf7d0";  # 注释 - 浅绿
          base04 = "4ade80";  # 暗前景 - 中绿
          base05 = "166534";  # 默认前景 - 深绿
          base06 = "14532d";  # 亮前景 - 更深绿
          base07 = "052e16";  # 最亮前景 - 深绿黑
          
          # 自然色调强调色
          base08 = "dc2626";  # 红色 - 自然红
          base09 = "ea580c";  # 橙色 - 秋叶橙
          base0A = "ca8a04";  # 黄色 - 阳光黄
          base0B = "16a34a";  # 绿色 - 森林绿
          base0C = "0d9488";  # 青色 - 薄荷青
          base0D = "0369a1";  # 蓝色 - 天空蓝
          base0E = "7c2d12";  # 紫色 - 木质棕
          base0F = "a16207";  # 棕色 - 大地棕
        }
        else if config.myHome.profiles.stylix.colors.scheme == "sunset-orange" then {
          # 🧡 Base16 配色方案 - 日落橙色主题
          scheme = "Sunset Orange Theme";
          author = "Stylix Custom";
          base00 = "fffbf5";  # 背景 - 奶油白
          base01 = "fef7ed";  # 较深背景 - 浅橙白
          base02 = "fed7aa";  # 选择背景 - 橙白
          base03 = "fdba74";  # 注释 - 浅橙
          base04 = "fb923c";  # 暗前景 - 中橙
          base05 = "9a3412";  # 默认前景 - 深橙
          base06 = "7c2d12";  # 亮前景 - 更深橙
          base07 = "431407";  # 最亮前景 - 深橙棕
          
          # 暖夕阳色调强调色
          base08 = "dc2626";  # 红色 - 夕阳红
          base09 = "ea580c";  # 橙色 - 日落橙
          base0A = "d97706";  # 黄色 - 金色
          base0B = "65a30d";  # 绿色 - 暮绿
          base0C = "0891b2";  # 青色 - 暮青
          base0D = "2563eb";  # 蓝色 - 暮蓝
          base0E = "7c3aed";  # 紫色 - 暮紫
          base0F = "a16207";  # 棕色 - 夕阳棕
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
