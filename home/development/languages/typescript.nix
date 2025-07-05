{ config, lib, pkgs, ... }:

{
  # TypeScript 开发环境
  home.packages = with pkgs; [
    nodejs
    typescript
  ];
}