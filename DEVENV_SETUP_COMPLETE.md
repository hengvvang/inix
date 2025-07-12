# devenv 配置完成！

devenv 已成功集成到你的 Nix 配置中。以下是使用方法：

## 🚀 快速开始

### 1. 应用配置
```bash
# 切换到新配置
home-manager switch --flake .#"hengvvang@laptop"
```

### 2. 创建项目
```bash
# 使用预设模板创建项目
mkdir my-rust-project && cd my-rust-project
cp ~/.config/nixpkgs/home/develop/devenv/templates/rust.nix ./devenv.nix

# 允许 direnv 加载环境
direnv allow

# 或者手动初始化
devenv init
```

### 3. 进入开发环境
```bash
# 进入目录自动激活（direnv）
cd my-rust-project

# 或手动激活
devenv shell
```

### 4. 启动开发服务
```bash
# 启动所有进程
devenv up

# 运行测试
devenv test
```

## 📁 可用模板

- **Rust**: `~/.config/nixpkgs/home/develop/devenv/templates/rust.nix`
- **Python**: `~/.config/nixpkgs/home/develop/devenv/templates/python.nix`  
- **TypeScript**: `~/.config/nixpkgs/home/develop/devenv/templates/typescript.nix`
- **C/C++**: `~/.config/nixpkgs/home/develop/devenv/templates/cpp.nix`

## 🔧 已安装工具

- `devenv` - 项目环境管理
- `direnv` - 自动环境切换  
- `nix-direnv` - Nix 支持
- `cachix` - 构建缓存
- `cookiecutter` - 项目模板
- `pre-commit` - Git 钩子
- `just` - 现代 make
- `watchexec` - 文件监控

## 📖 更多信息

查看详细文档：`~/.config/nixpkgs/home/develop/devenv/README.md`

享受现代化的开发环境！🎉
