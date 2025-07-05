{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors.enable = lib.mkEnableOption "编辑器配置";

  config = lib.mkIf config.myHome.apps.editors.enable {
    # 编辑器层默认配置：常用编辑器默认开启
    myHome.apps.editors = {
      vim.enable = lib.mkDefault true;        # Vim - 基础编辑器，默认开启
      vscode.enable = lib.mkDefault true;     # VSCode - 现代IDE，默认开启
      micro.enable = lib.mkDefault false;     # Micro - 轻量编辑器，可选
      zed.enable = lib.mkDefault false;       # Zed - 新兴编辑器，可选
    };
  };

  imports = [
    ./vim.nix
    ./micro.nix
    ./zed.nix
    ./vscode.nix
  ];
}
