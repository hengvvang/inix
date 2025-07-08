{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.develop.embedded.toolchain.enable {
    home.packages = with pkgs; [
    # ARM 工具链 - 使用 buildEnv 来解决文件冲突
    (pkgs.buildEnv {
      name = "arm-embedded-toolchain";
      paths = [ gcc-arm-embedded ];
      ignoreCollisions = true;
      # 排除与系统 gcc 冲突的手册页面
      pathsToLink = [ "/bin" "/include" "/lib" "/libexec" ];
    })
    openocd              # 片上调试器
    
    # 串口工具
    minicom              # 串口终端
    picocom              # 轻量串口工具
    
    # 二进制分析
    binutils             # 二进制工具集
    hexdump              # 十六进制查看
    ];
  };
}
