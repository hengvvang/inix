{ config, lib, pkgs, ... }:

{
  options.myHome.develop.typescript = {
    enable = lib.mkEnableOption "TypeScript 开发环境";
  };

  config = lib.mkIf config.myHome.develop.typescript.enable {
    # TypeScript 开发环境配置
    home.packages = with pkgs; [
      nodejs                   # Node.js 运行时
      typescript               # TypeScript 编译器
      nodePackages.ts-node     # TypeScript 执行环境
      nodePackages.eslint      # 使用 eslint 替代 tslint (tslint 已弃用)
    ];
  };
}
