{ config, lib, pkgs, ... }:

{
  # 系统 profiles 模块入口 - 对应 home/profiles
  imports = [
    ./stylix
    ./fonts        # ✅ 字体配置模块
    # ./desktop    # 未来扩展
    # ./security   # 未来扩展
  ];
}
