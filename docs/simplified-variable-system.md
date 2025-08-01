# 简化变量系统说明

## 🎯 重构目标

去除 `userVars` 和 `systemVars` 嵌套命名空间，使用更简洁的 `users` 和 `hosts` 直接定义变量，减少嵌套层级。

## 📋 变量定义

### flake.nix 中的简化变量
```nix
# 简化的变量配置 - 去除嵌套命名空间
users = {
  user1 = "hengvvang";
  user2 = "zlritsu";
};

hosts = {
  host1 = "laptop";
  host2 = "work";
  host3 = "daily";
};
```

## 🔧 变量使用方法

### 1. flake.nix 中的配置生成
```nix
# 系统配置
nixosConfigurations = {
  ${hosts.host1} = lib.nixosSystem { ... };  # laptop
  ${hosts.host2} = lib.nixosSystem { ... };  # work
};

darwinConfigurations = {
  ${hosts.host3} = lib.darwinSystem { ... };  # daily
};

# Home Manager 配置
homeConfigurations = {
  "${users.user1}@${hosts.host1}" = makeHomeConfig "x86_64-linux" (./users + "/${users.user1}") hosts.host1;
  "${users.user2}@${hosts.host1}" = makeHomeConfig "x86_64-linux" (./users + "/${users.user2}") hosts.host1;
  # ...
};
```

### 2. 用户配置中使用
```nix
# users/hengvvang/default.nix
{ config, pkgs, lib, inputs, outputs, users, hosts, ... }:
{
  config = {
    home.username = users.user1;
    home.homeDirectory = "/home/${users.user1}";
    programs.git = {
      userName = users.user1;
      userEmail = "${users.user1}@example.com";
    };
  };
}
```

### 3. 系统配置中使用
```nix
# hosts/laptop/default.nix
{ config, lib, pkgs, inputs, outputs, users, hosts, ... }:
{
  nix.settings.trusted-users = [ users.user1 users.user2 ];
  
  users.users.${users.user1} = {
    isNormalUser = true;
    description = users.user1;
    # ...
  };
}
```

## ✅ 重构优势

1. **减少嵌套**: 从 `userVars.userName.hengvvang` 简化为 `users.user1`
2. **语义清晰**: `users.user1` 比 `userVars.userName.hengvvang` 更直观
3. **灵活解耦**: `user1`, `host1` 等通用名称与具体名称解耦
4. **易于扩展**: 添加 `user3`, `host4` 等新变量非常简单

## 🔍 验证结果

```bash
# 查看变量
$ nix eval .#users
{ user1 = "hengvvang"; user2 = "zlritsu"; }

$ nix eval .#hosts  
{ host1 = "laptop"; host2 = "work"; host3 = "daily"; }

# 查看生成的配置
$ nix eval .#homeConfigurations --apply 'configs: builtins.attrNames configs'
[ "hengvvang@daily" "hengvvang@laptop" "hengvvang@work" "zlritsu@daily" "zlritsu@laptop" "zlritsu@work" ]
```

## 🚀 使用示例

要修改用户名，只需要：
```nix
users = {
  user1 = "newuser";  # 修改这里
  user2 = "zlritsu";
};
```

要添加新用户：
```nix
users = {
  user1 = "hengvvang";
  user2 = "zlritsu";
  user3 = "newuser";  # 添加新用户
};
```

所有相关配置会自动使用新的变量值！
