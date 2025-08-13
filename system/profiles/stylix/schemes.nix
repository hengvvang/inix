# Stylix 颜色方案预设
{ pkgs, ... }:

{
  # 常用颜色方案映射
  schemes = {
    # Gruvbox 系列
    gruvbox-dark-hard = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    gruvbox-dark-medium = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    gruvbox-dark-soft = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    gruvbox-light = "${pkgs.base16-schemes}/share/themes/gruvbox-light-hard.yaml";
    
    # Catppuccin 系列
    catppuccin-latte = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    catppuccin-frappe = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    catppuccin-macchiato = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    catppuccin-mocha = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    
    # Solarized 系列  
    solarized-dark = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
    solarized-light = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
    
    # 其他热门主题
    nord = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    dracula = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    tokyo-night = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    tokyo-night-light = "${pkgs.base16-schemes}/share/themes/tokyo-night-light.yaml";
    one-dark = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    one-light = "${pkgs.base16-schemes}/share/themes/one-light.yaml";
    github-dark = "${pkgs.base16-schemes}/share/themes/github.yaml";
    monokai = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
  };
}
