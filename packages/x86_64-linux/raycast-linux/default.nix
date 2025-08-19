{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  makeDesktopItem,
  copyDesktopItems,
}:

let
  pname = "raycast-linux";
  version = "0.1.0-alpha";
  
  src = fetchurl {
    url = "https://github.com/ByteAtATime/raycast-linux/releases/download/v${version}/raycast-linux_0.1.0_amd64.AppImage";
    hash = "sha256-ipcMteSXm5KC66/y2ndL7RefQ1bCfzq1SprX7GK8QHA=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };

in appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps
    
    # 安装桌面文件
    cp ${appimageContents}/raycast-linux.desktop $out/share/applications/ || true
    
    # 安装图标
    cp ${appimageContents}/raycast-linux.png $out/share/icons/hicolor/512x512/apps/ || true
    
    # 如果没有找到图标，创建一个默认的桌面项
    if [ ! -f "$out/share/applications/raycast-linux.desktop" ]; then
      cat > $out/share/applications/raycast-linux.desktop << EOF
[Desktop Entry]
Type=Application
Name=Raycast Linux
Comment=Raycast-compatible launcher for Linux
Exec=raycast-linux
Icon=raycast-linux
Categories=Utility;Launcher;
Keywords=launcher;search;productivity;
EOF
    fi
  '';

  meta = with lib; {
    description = "An open-source, Raycast-inspired launcher for Linux";
    longDescription = ''
      Raycast for Linux is an extensible command palette launcher that recreates
      most of Raycast's core features on Linux, including extension support,
      clipboard history, snippets, AI integration, and more.
    '';
    homepage = "https://github.com/ByteAtATime/raycast-linux";
    license = licenses.mit;
    maintainers = with maintainers; [ ]; # 可以添加维护者
    platforms = platforms.linux;
    mainProgram = "raycast-linux";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
