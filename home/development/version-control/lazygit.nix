{ config, lib, pkgs, ... }:
{
  # Lazygit - 优雅的 Git 终端界面
  programs.lazygit = {
    enable = true;
    
    # Lazygit 基础配置
    settings = {
      # 界面配置
      gui = {
        showFileTree = true;
        mouseEvents = true;
      };
      
      # Git 配置
      git = {
        commit.signOff = false;
      };
    };
  };
}
