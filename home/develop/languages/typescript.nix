{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.develop.languages.typescript.enable {
    # TypeScript 开发环境
    home.packages = with pkgs; [
      nodejs
      typescript
    ];
  };
}