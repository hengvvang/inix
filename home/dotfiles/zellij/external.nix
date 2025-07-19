{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "external") {
    # 安装zellij包
    home.packages = with pkgs; [ zellij ];
    
    # 使用外部配置文件
    home.file.".config/zellij/config.kdl".source = ./configs/config.kdl;
    
    # 可选：布局文件
    home.file.".config/zellij/layouts".source = ./configs/layouts;
    
    # 可选：主题文件
    home.file.".config/zellij/themes".source = ./configs/themes;
    
    # Shell集成
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # Zellij 会话管理
      function zj
          set session_name (basename (pwd))
          if test (count $argv) -gt 0
              set session_name $argv[1]
          end
          zellij attach -c $session_name
      end
      
      # 快速会话函数
      function zj-dev
          zellij attach -c dev -l dev
      end
      
      function zj-work
          zellij attach -c work -l work
      end
    '';
    
    # Bash集成
    programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
      # Zellij 会话管理函数
      zj() {
          local session_name=$(basename $(pwd))
          if [ $# -gt 0 ]; then
              session_name="$1"
          fi
          zellij attach -c "$session_name"
      }
      
      # 快速开发会话
      zj-dev() {
          zellij attach -c dev -l dev
      }
    '';
  };
}
