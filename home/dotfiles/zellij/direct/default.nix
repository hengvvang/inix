{ config, lib, pkgs, ... }:

{
  imports = [
    ./zellij-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "direct") {
    # 直接安装zellij包
    home.packages = with pkgs; [ 
        zellij
        wl-clipboard
    ];

    # 直接文件写入 - 演示用简化配置

    #  home.file  ==>  /home/userName/    就是你当前用户的家目录  |  也就是 cd ~ 命令进入的用户目录
    #  home.file.".config/zellij/config.kdl" ==> /home/userName/.config/zellij/config.kdl
    home.file.".config/zellij/config.kdl".text = ''
    '';
    
    # Fish shell集成
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # 简单的zellij启动函数
      function zj
          if test (count $argv) -eq 0
              zellij attach -c default
          else
              zellij attach -c $argv[1]
          end
      end
    '';
  };
}
