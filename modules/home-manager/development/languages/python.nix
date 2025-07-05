{ config, lib, pkgs, ... }:

{
  # Python 核心开发环境
  home.packages = with pkgs; [
    # Python 运行时
    python3                        # Python 3 解释器
    python3Packages.pip           # pip 包管理器
    python3Packages.virtualenv    # 虚拟环境管理
    
    # 开发工具
    python3Packages.ipython       # 增强 Python REPL
    python3Packages.poetry        # 现代 Python 包管理
    
    # 代码质量
    python3Packages.black         # 代码格式化
    python3Packages.flake8        # 代码检查
    python3Packages.isort         # import 排序
    
    # 测试框架
    python3Packages.pytest       # 测试框架
    python3Packages.pytest-cov   # 测试覆盖率
    
    # 常用开发库
    python3Packages.requests      # HTTP 客户端
    python3Packages.click         # CLI 构建
  ];
  
  # Python 开发别名
  home.shellAliases = {
    # Python 快捷命令
    py = "python3";
    py2 = "python2";  # 如果需要 Python 2
    ipy = "ipython";
    
    # 包管理
    pip-install = "pip install --user";
    pip-upgrade = "pip install --upgrade";
    pip-list = "pip list --user";
    
    # 虚拟环境
    venv-create = "python3 -m venv venv";
    venv-activate = "source venv/bin/activate";
    venv-deactivate = "deactivate";
    
    # Poetry 项目管理
    poetry-init = "poetry init";
    poetry-install = "poetry install";
    poetry-add = "poetry add";
    poetry-shell = "poetry shell";
    
    # 代码质量
    py-format = "black .";
    py-sort = "isort .";
    py-lint = "flake8 .";
    py-check = "black . && isort . && flake8 .";
    
    # 测试
    py-test = "pytest";
    py-test-cov = "pytest --cov=.";
    
    # 清理
    py-clean = "find . -name '*.pyc' -delete && find . -name '__pycache__' -delete && find . -name '*.egg-info' -exec rm -rf {} +";
    
    # 项目初始化
    py-init = "poetry init && mkdir -p src tests && touch src/__init__.py tests/__init__.py";
  };
}

