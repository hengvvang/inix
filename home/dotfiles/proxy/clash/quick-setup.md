# 更新你的 hosts/laptop/configuration.nix

# 在 mySystem 部分添加订阅链接：
mySystem = {
  # ...其他配置...
  
  services.network.proxy.clash = {
    enable = true;
    tunMode = true;
    subscriptionUrl = "你的订阅链接";  # 在这里替换为实际的订阅链接
    autoStart = true;                 # 系统启动时自动启动
    updateInterval = "daily";         # 每天自动更新订阅
  };
};

# 更新你的 hosts/laptop/home.nix

# 添加用户配置：
myHome = {
  # ...其他配置...
  
  dotfiles.proxy.clash = {
    enable = true;
    configMethod = "homemanager";  # 或 "direct" 或 "external"
  };
};
