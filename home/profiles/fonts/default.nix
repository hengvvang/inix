{ config, lib, pkgs, ... }:

{
  imports = [
    ./cyberPunk.nix
    ./vintage.nix
    ./zen.nix
  ];

  options.myHome.profiles.fonts = {
    enable = lib.mkEnableOption "字体配置支持";

    preset = lib.mkOption {
      type = lib.types.enum [ "cyberPunk" "vintage" "zen" ];
      default = "zen";
      description = ''
        字体风格主题配置:
        - cyberPunk: 赛博朋克风格，科技感十足的未来字体组合
        - vintage: 复古风格，经典优雅的传统美学
        - zen: 禅意主题，宁静专注的字体配置
      '';
    };
  };
}
