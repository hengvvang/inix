{ config, lib, pkgs, ... }:

{
  options = {
    myHome.development.languages.typescript.enable = lib.mkEnableOption "TypeScript 开发环境";
  };

  config = lib.mkIf config.myHome.development.languages.typescript.enable {
    # TypeScript 开发环境
    home.packages = with pkgs; [
      nodejs
      typescript
    ];
  };
}