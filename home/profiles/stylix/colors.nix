{ config, pkgs, lib, ... }:

{
  # 可选的预设颜色方案（当不使用壁纸生成时）
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  
  # 或者自定义颜色覆盖
  # stylix.override = {
  #   base00 = "1d2021"; # 背景
  #   base05 = "d5c4a1"; # 前景
  #   # ... 其他颜色
  # };
}
