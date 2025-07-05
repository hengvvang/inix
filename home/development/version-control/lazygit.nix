{ config, lib, pkgs, ... }:
{
  options = {
    myHome.development.versionControl.lazygit.enable = lib.mkEnableOption "Lazygit 终端 Git UI";
  };

  config = lib.mkIf config.myHome.development.versionControl.lazygit.enable {
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
  };
}
