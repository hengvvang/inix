# 嵌入式开发和现代化工具配置

## 🔧 嵌入式开发环境

### Rust 嵌入式开发
- **工具链**: `rustup` + 嵌入式目标 (thumbv7em, thumbv6m, riscv32)
- **开发工具**: `cargo-embed`, `cargo-flash`, `cargo-binutils`
- **调试工具**: `probe-rs-tools`, `gdb-multiarch`

### C/C++ 嵌入式开发
- **工具链**: `gcc-arm-embedded` (ARM Cortex)
- **调试器**: `openocd`, `gdb-multitarget`
- **烧录工具**: `stlink`, `dfu-util`, `avrdude`

### 硬件工具
- **串口通信**: `minicom`, `picocom`, `screen`
- **逻辑分析**: `sigrok-cli`, `pulseview`
- **仿真器**: `qemu`

## 🚀 现代化 Linux 开发工具

### 系统监控工具 (现代化替代品)
| 传统工具 | 现代化替代 | 说明 |
|---------|-----------|------|
| `top/htop` | `btop`, `bottom` | 更美观的系统监控 |
| `du` | `dust`, `duf` | 现代化磁盘使用分析 |
| `ps` | `procs` | 现代化进程查看器 |
| `ls` | `lsd`, `exa` | 带图标和颜色的文件列表 |
| `cat` | `bat` | 语法高亮的文件查看器 |
| `grep` | `ripgrep` | 更快的文本搜索 |
| `find` | `fd` | 更友好的文件查找 |

### 网络工具
- **网络监控**: `bandwhich` (带宽使用)
- **现代化网络工具**: `gping` (图形化ping), `dog` (现代dig), `xh` (现代HTTP客户端)

### 开发辅助工具
- **基准测试**: `hyperfine` (命令行性能测试)
- **代码统计**: `tokei`, `loc` (代码行数统计)
- **Git 增强**: `delta` (更好的diff), `git-absorb` (自动修复commits)

### 终端增强
- **提示符**: `starship` (跨shell现代化提示符)
- **终端复用**: `zellij` (现代化tmux替代)
- **智能导航**: `zoxide` (智能cd), `broot` (交互式目录导航)

### 容器和云原生工具
- **Docker分析**: `dive` (镜像分析), `lazydocker` (Docker TUI)
- **容器监控**: `ctop`

## 📝 配置特色

### 智能别名系统
```bash
# 嵌入式开发
ce          # cargo embed
cfl         # cargo flash  
serial      # minicom -D (串口连接)
embed-setup # 嵌入式环境检查

# 现代化工具
ls          # lsd (现代化ls)
cat         # bat (语法高亮)
ping        # gping (图形化ping)
top         # btop (现代化top)

# 开发快捷键
cr/cb/ct    # cargo run/build/test
pyformat    # black + isort (Python格式化)
gdiff       # git diff with delta
```

### 自动环境配置
- **Rust**: 自动配置 CARGO_HOME, RUSTUP_HOME
- **嵌入式目标**: 自动安装 ARM Cortex 和 RISC-V 目标
- **构建优化**: ccache 缓存, Ninja 构建系统
- **PATH管理**: 自动添加开发工具到PATH

### 项目级别环境管理
使用 `direnv` 支持项目级别的环境配置:

```bash
# 在项目目录创建 .envrc
echo "use flake" > .envrc      # 使用 flake.nix
echo "use nix" > .envrc        # 使用 shell.nix
```

### 实用脚本
- **`setup-dev-env`**: 一键设置完整开发环境
- **`embed-setup`**: 检查嵌入式开发环境
- **`dev-info`**: 查看开发环境信息

## 🎯 使用场景

### 嵌入式开发工作流
1. 使用 `embed-setup` 检查环境
2. 使用 `serial /dev/ttyUSB0` 连接串口
3. 使用 `ce` (cargo embed) 进行开发调试
4. 使用 `cfl` (cargo flash) 烧录固件

### 日常开发工作流
1. 使用 `z <项目名>` 智能跳转到项目
2. 使用现代化工具进行开发 (`ls`, `cat`, `grep` 等)
3. 使用 `lg` (lazygit) 进行Git操作
4. 使用 `btop` 监控系统性能

这套配置提供了完整的现代化Linux开发环境，特别针对嵌入式开发进行了优化！
