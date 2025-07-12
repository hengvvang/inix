{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基本 Rust 配置
    (lib.mkIf (config.myHome.develop.enable && config.myHome.develop.rust.enable) {
      home.packages = with pkgs; [
        # Rust 核心工具链
        rustup               # Rust 版本管理工具（包含 cargo、rustc、rust-analyzer 等）
        # 注意：rustfmt、clippy、rust-analyzer 等工具通过 rustup 组件安装
        # 可以使用：rustup component add rustfmt clippy rust-analyzer
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
        probe-rs-tools
        
        # 嵌入式开发工具
        binutils            # 二进制工具
      ];
    })
  ];
}
