{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts = {
    enable = lib.mkEnableOption "字体配置支持";
    
    preset = lib.mkOption {
      type = lib.types.enum [ "cyberPunk" "nordic" "bauhaus" "vintage" "tokyo" "forest" "sakura" "ocean" "zen" "aurora" ];
      default = "nordic";
      description = ''
        字体风格主题配置:
        - cyberPunk: 赛博朋克风格，科技感十足的未来字体组合
        - nordic: 北欧风格，简约干净的斯堪的纳维亚美学
        - bauhaus: 包豪斯风格，几何现代主义的设计哲学
        - vintage: 复古风格，经典优雅的传统美学
        - tokyo: 东京风格，日式简约与现代的融合
        - forest: 森林风格，自然有机的温暖字体搭配
        - sakura: 樱花主题，优雅的日式美学字体配置
        - ocean: 海洋主题，深邃宁静的字体配置
        - zen: 禅意主题，宁静专注的字体配置
        - aurora: 极光主题，绚烂多彩的字体配置
      '';
    };
  };

  imports = [
    ./cyberPunk.nix
    ./nordic.nix
    ./bauhaus.nix
    ./vintage.nix
    ./tokyo.nix
    ./forest.nix
    ./sakura.nix
    ./ocean.nix
    ./zen.nix
    ./aurora.nix
  ];
}