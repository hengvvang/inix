{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.security.enable) {
    # Docker 安全配置
    virtualisation.docker.daemon.settings = lib.mkIf config.mySystem.services.docker.enable {
      # 用户命名空间
      userns-remap = "default";
      
      # 安全选项
      selinux-enabled = false;  # 如果使用 SELinux 设为 true
      
      # 限制容器能力
      no-new-privileges = true;
      
      # 内容信任
      content-trust = false;  # 生产环境建议设为 true
      
      # 禁用传统注册表 v1
      disable-legacy-registry = true;
      
      # 限制日志大小
      log-opts = {
        max-size = "10m";
        max-file = "3";
      };
      
      # 资源限制
      default-ulimits = {
        nofile = {
          name = "nofile";
          hard = 1024;
          soft = 1024;
        };
        nproc = {
          name = "nproc";
          hard = 1024;
          soft = 1024;
        };
      };
    };

    # AppArmor 配置（如果启用）
    security.apparmor = {
      enable = true;
      packages = [ pkgs.apparmor-profiles ];
    };

    # 用户命名空间配置
    users.users.dockremap = {
      isSystemUser = true;
      group = "dockremap";
      home = "/var/lib/dockremap";
      createHome = true;
    };
    
    users.groups.dockremap = {};

    # 子 UID/GID 配置
    environment.etc."subuid".text = ''
      dockremap:165536:65536
    '';
    
    environment.etc."subgid".text = ''
      dockremap:165536:65536
    '';

    # 安全扫描工具
    environment.systemPackages = with pkgs; [
      # 安全扫描工具
      trivy                 # 容器安全扫描
      docker-bench-security # Docker安全基准测试
    ];

    # 容器运行时安全策略
    environment.etc."docker/seccomp-profile.json".text = ''
      {
        "defaultAction": "SCMP_ACT_ERRNO",
        "archMap": [
          {
            "architecture": "SCMP_ARCH_X86_64",
            "subArchitectures": [
              "SCMP_ARCH_X86",
              "SCMP_ARCH_X32"
            ]
          }
        ],
        "syscalls": [
          {
            "names": [
              "accept",
              "accept4",
              "access",
              "alarm",
              "bind",
              "brk",
              "chdir",
              "chmod",
              "chown",
              "close",
              "connect",
              "dup",
              "dup2",
              "execve",
              "exit",
              "exit_group",
              "fchdir",
              "fchmod",
              "fchown",
              "fcntl",
              "fork",
              "fstat",
              "futex",
              "getcwd",
              "getdents",
              "getegid",
              "geteuid",
              "getgid",
              "getgroups",
              "getpeername",
              "getpgrp",
              "getpid",
              "getppid",
              "getrlimit",
              "getsid",
              "getsockname",
              "getsockopt",
              "getuid",
              "listen",
              "lseek",
              "lstat",
              "madvise",
              "mkdir",
              "mmap",
              "mprotect",
              "munmap",
              "nanosleep",
              "open",
              "openat",
              "pipe",
              "poll",
              "read",
              "readlink",
              "recv",
              "recvfrom",
              "recvmsg",
              "rename",
              "rmdir",
              "rt_sigaction",
              "rt_sigprocmask",
              "rt_sigreturn",
              "select",
              "send",
              "sendmsg",
              "sendto",
              "setgid",
              "setgroups",
              "setpgid",
              "setsid",
              "setsockopt",
              "setuid",
              "shutdown",
              "socket",
              "socketpair",
              "stat",
              "symlink",
              "time",
              "uname",
              "unlink",
              "wait4",
              "write"
            ],
            "action": "SCMP_ACT_ALLOW"
          }
        ]
      }
    '';

    # 定期安全检查任务
    systemd.services.docker-security-audit = {
      description = "Docker 定期安全审计";
      
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      
      script = ''
        echo "Docker 安全审计 - $(date)" >> /var/log/docker-security.log
        
        # 检查特权容器
        PRIVILEGED=$(${pkgs.docker}/bin/docker ps --filter "label=privileged=true" --format "{{.Names}}" || true)
        if [ -n "$PRIVILEGED" ]; then
          echo "警告: 发现特权容器: $PRIVILEGED" >> /var/log/docker-security.log
        fi
        
        # 检查 root 用户运行的容器
        ROOT_CONTAINERS=$(${pkgs.docker}/bin/docker ps --format "{{.Names}}" | xargs -I {} ${pkgs.docker}/bin/docker exec {} whoami 2>/dev/null | grep -c "^root$" || true)
        if [ "$ROOT_CONTAINERS" -gt 0 ]; then
          echo "警告: 发现 $ROOT_CONTAINERS 个以 root 运行的容器" >> /var/log/docker-security.log
        fi
        
        echo "安全审计完成" >> /var/log/docker-security.log
      '';
    };

    # 定期安全审计计时器
    systemd.timers.docker-security-audit = {
      description = "Docker 定期安全审计计时器";
      wantedBy = [ "timers.target" ];
      
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "30m";
      };
    };

    # 安全日志目录
    systemd.tmpfiles.rules = [
      "f /var/log/docker-security.log 0640 root root -"
    ];
  };
}
