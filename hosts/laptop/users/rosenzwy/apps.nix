{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.twilight
    # pkgs.qutebrowser
    pkgs.google-chrome
    # pkgs.firefox

    # inputs.zed-editor.packages.${pkgs.system}.default
    pkgs.zed-editor
    pkgs.vscode


    pkgs.qq
    pkgs.wechat
    pkgs.discord
    pkgs.element-desktop
    pkgs.telegram-desktop

    # pkgs.clash-verge-rev
    # pkgs.mihomo
    # pkgs.clash-nyanpasu

    pkgs.vlc
    pkgs.satty
    pkgs.lutris
    pkgs.spotify
    pkgs.wpsoffice-cn
    pkgs.libreoffice-qt6
    # pkgs.blender           # 3D 建模
    # pkgs.gimp              # 图像编辑
    # pkgs.inkscape          # 矢量图编辑
    # pkgs.davinci-resolve   # 视频编辑 (需要 unfree)
    pkgs.kdePackages.kdenlive
  ] ++ (with pkgs;[
    #
    # toolkits
    #
    nh                    # NixOS/Home Manager 助手
    nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
    nix-tree             # 查看 Nix store 依赖关系
    nixos-rebuild        # NixOS 系统重建工具
    nvd                  # Nix 版本差异比较工具

    eza
    bat
    zoxide
    fd
    ripgrep
    difftastic
    delta
    # tealdeer
    #tldr
    tree
    broot
    navi
    dust
    gping
    httpie
    hurl
    fzf
    skim
    htop
    btop
    bottom
    trippy
    unzip
    zip
    p7zip
    fastfetch
    onefetch
    hyperfine         # 基准测试工具
    procs   # ps
    pstree            # 进程树
    duf
    ncdu
    # 开发辅助
    watchexec         # 文件监控执行
    tokei             # 代码统计
    dog               # 现代 dig (DNS 查询)
    nmap              # 网络扫描
    tcpdump           # 网络包分析
    iperf3            # 网络性能测试
    bandwhich         # 网络带宽监控
    sniffnet          # 网络流量监控
    visidata          # 表格数据查看器
    killall           # 批量结束进程
    choose            # 更好的 cut
    sd                # 现代 sed
    jq                # JSON 处理
    yq                # YAML 处理
    rsync             # 文件同步
    hexyl             # 十六进制查看器
    ast-grep
    calcure
    czkawka
  ]) ++ (with pkgs; [
    #
    # develop
    #
    mise
    just
    devenv
    # rust
    rustup
    # rustc
    # cargo
    # rustfmt
    # clippy
    # rust-analyzer
    mdbook
    # python
    uv
    ty
    ruff
    pyrefly
  ]);
}
