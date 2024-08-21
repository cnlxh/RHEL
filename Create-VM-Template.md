```textile
作者：李晓辉

微信联系：Lxh_Chat

联系邮箱: 939958092@qq.com
```

```bash
#!/bin/bash

# 清除主机名和本地解析
echo "localhost" > /etc/hostname
cat > /etc/hosts <<-'EOF'
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
EOF

# 清除SSH密钥
rm -rf /etc/ssh/ssh_host_*

# 清除机器ID
rm -rf /etc/machine-id
touch /etc/machine-id

# 清除日志文件
rm -rf /var/log/*

# 清除网络UDEV规则
rm -rf /etc/udev/rules.d/70-persistent-net.rules

# 清除云初始化配置
cloud-init clean

# 清除临时文件和缓存
rm -rf /tmp/*
rm -rf /var/tmp/*

# 清除用户 crontab 任务
crontab -r
rm -rf /var/spool/cron/*

# 清除 root 和用户的文件
rm -rf /root/.ssh/*
rm -rf /home/*/.ssh/*
rm -rf /home/*/*
rm -rf /root/*


# 清理包缓存 (操作系统特定)
if [ -f /etc/redhat-release ]; then
    rm -rf /etc/sysconfig/network-scripts/ifcfg-*
    rm -rf /etc/NetworkManager/system-connections/*
    dnf clean all
    rm -rf /var/cache/dnf/*
    firewall-cmd --reset-to-defaults
    firewall-cmd --reload
elif [ -f /etc/lsb-release ]; then
    rm -rf /etc/netplan/*.yaml
    apt-get clean
    rm -rf /var/cache/apt/archives/*
    ufw reset
fi

# 同步文件系统并清除用户历史记录

rm -rf /root/.bash_history
rm -rf /home/*/.bash_history
sync
history -c
```
