# devenv 使用指南

devenv 已集成到你的开发环境配置中，提供项目级别的开发环境管理。

## 快速开始

### 1. 创建新项目

```bash
# 初始化新的 devenv 项目
devenv init

# 或者使用预设模板
cp ~/.config/nixpkgs/home/develop/devenv/templates/rust.nix ./devenv.nix
```

### 2. 进入项目环境

```bash
# 进入项目目录，direnv 会自动激活环境
cd your-project

# 或手动激活
devenv shell
```

### 3. 启动开发服务

```bash
# 启动所有配置的进程
devenv up

# 运行测试
devenv test
```

## 预设模板

配置中包含以下语言的预设模板：

- **Rust**: `~/.config/nixpkgs/home/develop/devenv/templates/rust.nix`
- **Python**: `~/.config/nixpkgs/home/develop/devenv/templates/python.nix`
- **TypeScript**: `~/.config/nixpkgs/home/develop/devenv/templates/typescript.nix`
- **C/C++**: `~/.config/nixpkgs/home/develop/devenv/templates/cpp.nix`

## 项目配置示例

### Rust Web 项目

```nix
{ pkgs, ... }:

{
  packages = with pkgs; [
    cargo-watch
    diesel-cli
    sea-orm-cli
  ];

  languages.rust.enable = true;

  services.postgres = {
    enable = true;
    initialDatabases = [{ name = "myapp"; }];
  };

  processes.server.exec = "cargo watch -x 'run --bin server'";

  enterShell = ''
    echo "🚀 Rust Web 服务已就绪！"
    echo "数据库: postgresql://postgres@localhost/myapp"
  '';
}
```

### Python Django 项目

```nix
{ pkgs, ... }:

{
  languages.python = {
    enable = true;
    version = "3.11";
    venv.enable = true;
    venv.requirements = "./requirements.txt";
  };

  services = {
    postgres.enable = true;
    redis.enable = true;
  };

  processes = {
    runserver.exec = "python manage.py runserver";
    celery.exec = "celery -A myproject worker -l info";
  };

  scripts.migrate.exec = "python manage.py migrate";

  enterShell = ''
    echo "🐍 Django 开发环境已就绪！"
    migrate
  '';
}
```

## 常用命令

```bash
# 项目管理
devenv init              # 初始化新项目
devenv shell             # 进入开发环境
devenv up                # 启动所有进程
devenv down              # 停止所有进程

# 环境管理
direnv allow             # 允许 .envrc 文件
direnv reload            # 重新加载环境

# 调试
devenv info              # 显示环境信息
devenv gc                # 清理垃圾收集
```

## 自动化集成

项目配置了以下自动化工具：

- **direnv**: 自动环境切换
- **pre-commit**: Git 提交前钩子
- **cachix**: 构建缓存加速

当你进入包含 `devenv.nix` 的目录时，环境会自动激活！
