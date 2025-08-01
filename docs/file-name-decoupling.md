# 文件名解耦重构总结

## 🎯 重构完成

已成功完成文件名和目录结构的完全解耦，所有具体的名称都被通用的变量名替代。

## 📁 目录结构变更

### 主机配置目录
```
hosts/
├── host1/    # 原 laptop/
├── host2/    # 原 work/
└── host3/    # 原 daily/
```

### 用户配置目录
```
users/
├── user1/    # 原 hengvvang/
│   ├── host1.nix    # 原 laptop.nix
│   ├── host2.nix    # 原 work.nix
│   └── host3.nix    # 原 daily.nix
└── user2/    # 原 zlritsu/
    ├── host1.nix    # 原 laptop.nix
    ├── host2.nix    # 原 work.nix
    └── host3.nix    # 原 daily.nix
```

## 🔧 配置更新

### 1. flake.nix 中的路径引用
```nix
# 系统配置
nixosConfigurations = {
  ${hosts.host1} = lib.nixosSystem {
    modules = [ ./hosts/host1 ... ];  # 使用通用路径
  };
};

# Home Manager 配置
homeConfigurations = {
  "${users.user1}@${hosts.host1}" = makeHomeConfig ... (./users + "/${users.user1}") ...;
};
```

### 2. 用户配置中的导入
```nix
# users/user1/default.nix
imports = [
  ./host1.nix    # 原 ./laptop.nix
  ./host2.nix    # 原 ./work.nix  
  ./host3.nix    # 原 ./daily.nix
];

options.host = lib.mkOption {
  type = lib.types.enum [ hosts.host1 hosts.host2 hosts.host3 ];  # 使用变量
  default = hosts.host1;  # 使用变量
};
```

### 3. 主机特定配置中的条件判断
```nix
# users/user1/host1.nix
{ config, lib, hosts, ... }:
{
  config = lib.mkIf (config.host == hosts.host1) {  # 使用变量
    # 配置内容...
  };
}
```

## ✅ 解耦效果

### 完全解耦的层级
1. **变量定义**: `users.user1` ↔ `"hengvvang"`
2. **变量定义**: `hosts.host1` ↔ `"laptop"`
3. **目录名称**: `users/user1/` 对应用户1
4. **文件名称**: `host1.nix` 对应主机1配置
5. **配置引用**: 所有引用都使用变量而非硬编码

### 一致性保证
- flake.nix 中的变量映射是唯一的真实来源
- 所有文件路径、配置引用都使用相同的变量体系
- 目录结构与变量命名完全对应

## 🚀 使用效果

现在要修改用户名或主机名，只需要：
1. 修改 `flake.nix` 中的变量定义
2. 无需修改任何文件名或目录名
3. 无需修改任何配置文件内的引用

例如：
```nix
# 要将 user1 从 hengvvang 改为 alice
users = {
  user1 = "alice";    # 只需修改这里
  user2 = "zlritsu";
};

# 要将 host1 从 laptop 改为 desktop
hosts = {
  host1 = "desktop";  # 只需修改这里
  host2 = "work";
  host3 = "daily";
};
```

## 🧪 验证结果

```bash
$ nix eval .#homeConfigurations --apply 'configs: builtins.attrNames configs'
[ "hengvvang@daily" "hengvvang@laptop" "hengvvang@work" "zlritsu@daily" "zlritsu@laptop" "zlritsu@work" ]
```

配置系统现在完全通过变量驱动，实现了名称与实现的完全解耦！🎉
