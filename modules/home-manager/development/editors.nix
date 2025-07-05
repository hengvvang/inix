{ config, lib, pkgs, ... }:

{
  # 代码编辑器配置
  
  # Micro 编辑器 - 现代化的终端文本编辑器
  programs.micro = {
    enable = true;
    
    # Micro 编辑器设置
    settings = {
      # 主题设置
      colorscheme = "material-tc";
      
      # 文件操作
      mkparents = true;        # 自动创建父目录
      autosu = true;           # 自动保存
      
      # 显示设置
      softwrap = true;         # 软换行
      
      # 缩进设置
      tabsize = 2;             # Tab 大小
      tabstospaces = true;     # Tab 转空格
      autoindent = true;       # 自动缩进
      
      # 导航设置
      tabmovement = true;      # Tab 移动
      
      # 界面设置
      ruler = true;            # 显示标尺
      statusline = true;       # 显示状态行
      
      # 语法高亮
      syntax = true;
      
      # 文件类型检测
      filetype = true;
    };
  };

  # Helix 编辑器 - 现代化的模态编辑器
  programs.helix = {
    enable = true;
    
    # Helix 编辑器设置
    settings = {
      # 主题设置
      theme = "onedark";
      
      # 编辑器设置
      editor = {
        # 行号设置
        line-number = "relative";
        
        # 光标设置
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        
        # 缩进设置
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        
        # 软换行
        soft-wrap.enable = true;
        
        # 自动配对
        auto-pairs = true;
        
        # 自动补全
        auto-completion = true;
        
        # 智能大小写搜索
        search.smart-case = true;
      };
    };
    
    # 语言服务器配置
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixpkgs-fmt";
        }
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "typescript";
          auto-format = true;
        }
        {
          name = "javascript";
          auto-format = true;
        }
        {
          name = "python";
          auto-format = true;
        }
        {
          name = "c";
          auto-format = true;
        }
        {
          name = "cpp";
          auto-format = true;
        }
      ];
    };
  };
}
