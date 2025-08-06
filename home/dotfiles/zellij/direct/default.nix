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
