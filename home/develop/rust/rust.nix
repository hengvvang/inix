{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基本 Rust 配置
    (lib.mkIf (config.myHome.develop.enable && config.myHome.develop.rust.enable) {
      home.packages = with pkgs; [
        # Rust 核心工具链
        rustc                # Rust 编译器
        cargo                # Rust 包管理器和构建工具
        rust-analyzer        # Rust 语言服务器
        rustfmt              # 代码格式化工具
        clippy               # Rust linter
      ];
    })
    
    # Rust 嵌入式开发配置
    (lib.mkIf (config.myHome.develop.enable && config.myHome.develop.rust.enable && config.myHome.develop.rust.embedded.enable) {
      home.packages = with pkgs; [
        # ARM 工具链
        (pkgs.buildEnv {
          name = "arm-embedded-toolchain";
          paths = [ gcc-arm-embedded ];
          ignoreCollisions = true;
          pathsToLink = [ "/bin" "/include" "/lib" "/libexec" ];
        })
        # 嵌入式特定工具
        openocd              # 片上调试器
        minicom              # 串口终端
        picocom              # 轻量串口工具
        
        # 嵌入式开发工具
        binutils            # 二进制工具
      ];
    })
  ];
}
