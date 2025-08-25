{ config, pkgs, lib, inputs, outputs, userMapping, hostMapping, ... }:

{
  imports = [
    outputs.home
  ];

  config = {
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
    home.username = userMapping.user1;
    home.homeDirectory = "/home/${userMapping.user1}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    myHome = {
      pkgs = {
        enable = true;
        user1.enable = true;
      };

      develop = {
        enable = true;
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = false;    # 轻量级配置，不安装额外模板工具
          cache = true;         # 启用构建缓存优化
        };
        rust.enable = true;
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp.enable = true;
      };

      profiles = {
        enable = true;
        fonts = {
          preset = "bauhaus";
        };
      };
    };
  };
}
