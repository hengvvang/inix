{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  gtk4,
  gtk4-layer-shell,
  dbus,
  glib,
  wayland,
  openssl,
  sqlite,
  gdk-pixbuf,
  librsvg,
  libsecret,
}:

rustPlatform.buildRustPackage rec {
  pname = "sherlock-launcher";
  version = "0.1.14-2";

  src = fetchFromGitHub {
    owner = "Skxxtz";
    repo = "sherlock";
    rev = "v${version}";
    hash = "sha256-k5v1eeRxwCpU7+nBU6/q8I6O2e0kXojyhNTeZ3k/Qxo=";
  };

  cargoHash = "sha256-fct2xHZmrPMn/HXPtMaYraODT0Yi/wZEPw5X8KwhnGk=";

  nativeBuildInputs = [
    pkg-config
    glib
  ];

  buildInputs = [
    gtk4
    gtk4-layer-shell
    dbus
    glib
    wayland
    openssl
    sqlite
    gdk-pixbuf
    librsvg
    libsecret
  ];

  # 构建前的准备工作
  preBuild = ''
    # 确保资源文件被正确编译
    export PKG_CONFIG_PATH="${glib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
  '';

  # 一些依赖需要动态链接
  preFixup = ''
    patchelf --add-rpath ${lib.makeLibraryPath buildInputs} $out/bin/sherlock || true
  '';

  # 测试在构建环境中可能会失败，所以跳过
  doCheck = false;

  meta = with lib; {
    description = "A lightweight and efficient application launcher for Wayland built with Rust and GTK4";
    longDescription = ''
      Sherlock is a versatile application launcher designed specifically for Wayland compositors.
      Built with Rust and GTK4, it provides a fast, highly configurable, and feature-rich way to
      search and launch applications. It includes features like custom commands, fallback behaviors,
      application aliases, async widgets, category-based search, shortcuts, context menus, and more.
    '';
    homepage = "https://github.com/Skxxtz/sherlock";
    changelog = "https://github.com/Skxxtz/sherlock/blob/main/docs/patchnotes/v${version}.md";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ hengvvang ]; # 添加你自己作为维护者
    mainProgram = "sherlock";
    platforms = platforms.linux;

    # 明确说明这是针对 Wayland 的
    broken = false;
  };
}
