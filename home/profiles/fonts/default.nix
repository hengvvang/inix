{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts = {
    enable = lib.mkEnableOption "字体配置支持";

    preset = lib.mkOption {
      type = lib.types.enum [ "cyberPunk" "vintage" "forest" "sakura" "ocean" "zen" "aurora" ];
      default = "nordic";
      description = ''
        字体风格主题配置:
        - cyberPunk: 赛博朋克风格，科技感十足的未来字体组合
        - vintage: 复古风格，经典优雅的传统美学
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
    ./vintage.nix
    ./forest.nix
    ./sakura.nix
    ./ocean.nix
    ./zen.nix
    ./aurora.nix
  ];
}
