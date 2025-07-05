{ config, lib, pkgs, ... }:

{
  # JavaScript/TypeScript 核心开发环境
  home.packages = with pkgs; [
    # 运行时环境
    nodejs                           # Node.js JavaScript 运行时
    nodePackages.npm                 # npm 包管理器
    nodePackages.yarn                # Yarn 包管理器
    
    # TypeScript 支持
    nodePackages.typescript          # TypeScript 编译器
    nodePackages.ts-node             # TypeScript 直接运行
    nodePackages.typescript-language-server  # TypeScript LSP
    
    # 代码质量工具
    nodePackages.eslint              # JS/TS 代码检查
    nodePackages.prettier            # 代码格式化
    
    # 开发工具
    nodePackages.nodemon             # 文件变化自动重启
    nodePackages.live-server         # 开发服务器
  ];
  
  # 常用别名
  home.shellAliases = {
    # npm 快捷命令
    nr = "npm run";
    ni = "npm install";
    nu = "npm update";
    
    # 常用脚本
    dev = "npm run dev";
    build = "npm run build";
    test = "npm test";
    start = "npm start";
    
    # 代码质量
    lint = "eslint .";
    format = "prettier --write .";
    
    # TypeScript
    tsc = "npx tsc";
    tsw = "npx tsc --watch";
    
    # 依赖管理
    clean-deps = "rm -rf node_modules package-lock.json yarn.lock && npm install";
    deps-check = "npm outdated";
    
    # 项目初始化
    init-js = "npm init -y";
    init-ts = "npm init -y && npm install -D typescript @types/node ts-node";
  };
}

