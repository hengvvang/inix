# AppImage 服务配置

简化的 AppImage 应用支持配置。

## 启用服务

在您的系统配置中添加：

```nix
{
  mySystem.services.containers.appimage.enable = true;
}
```

## 功能说明

- **自动支持**: 启用后可直接运行 AppImage 文件
- **命令行工具**: 提供 `appimage-run` 命令
- **双击运行**: 支持在文件管理器中双击运行
- **简单配置**: 无需复杂设置，开箱即用

## 使用方法

1. 下载 AppImage 文件
2. 添加执行权限：`chmod +x app.AppImage`
3. 双击运行或使用命令：`./app.AppImage`

## 示例

```bash
# 下载并运行 AppImage
wget https://example.com/app.AppImage
chmod +x app.AppImage
./app.AppImage

# 或使用 appimage-run
appimage-run app.AppImage
```
