# 用户变量系统使用说明

## 概述

在 `flake.nix` 中定义了简化的用户变量系统，只需要定义用户名，然后在用户配置文件中通过变量引用。

## 在 flake.nix 中定义变量

```nix
userVars = {
  # 只定义用户名映射
  userName = {
    hengvvang = "hengvvang";
    zlritsu = "zlritsu";
  };
};
```

## 在用户配置中使用变量

在 `users/username/default.nix` 中：

```nix
{ config, pkgs, lib, inputs, outputs, userVars, ... }:
{
  config = {
    # 使用变量配置用户信息
    home.username = userVars.userName.hengvvang;
    home.homeDirectory = "/home/${userVars.userName.hengvvang}";
    
    # 使用变量配置 Git
    programs.git = {
      enable = true;
      userName = userVars.userName.hengvvang;
      userEmail = "${userVars.userName.hengvvang}@example.com";
    };
  };
}
```

## 优势

1. **集中管理**：所有用户名在 `flake.nix` 中统一定义
2. **自动化**：用户配置通过变量自动生成 homeDirectory、email 等
3. **一致性**：确保所有地方使用的用户名保持一致
4. **易于维护**：修改用户名只需要在一个地方更改

## 扩展

如果需要为不同用户定义不同的邮箱后缀或其他个性化配置，可以在 `userVars` 中添加更多字段：

```nix
userVars = {
  userName = {
    hengvvang = "hengvvang";
    zlritsu = "zlritsu";
  };
  # 可选：添加其他配置
  emailDomain = {
    hengvvang = "example.com";
    zlritsu = "company.com";
  };
};
```

然后在用户配置中使用：
```nix
userEmail = "${userVars.userName.hengvvang}@${userVars.emailDomain.hengvvang}";
```
