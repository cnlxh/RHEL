```textile
作者：李晓辉

微信联系：Lxh_Chat

联系邮箱: 939958092@qq.com
```

# 重新生成机器ID

```bash
echo "" > /etc/machine-id
cat >> /etc/profile << EOF
systemd-machine-id-setup && sed -i '$d' /etc/profile
EOF
```

# 重新生成UDEV规则

```bash
rm -rf /etc/udev/rules.d/*
```

# 重新生成SSH密钥

```bash
rm -rf /etc/ssh/ssh_host_*
```

# Linux 图形化自动登录

此处使得root用户可以自动登录，需要重新启动服务器验证
```bash
sudo sed -i '/\[daemon\]/a AutomaticLoginEnable=True\nAutomaticLogin=root' /etc/gdm/custom.conf
```

# 允许root通过SSH登录

```bash
sudo sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i '/^#PermitRootLogin/a PermitRootLogin yes' /etc/ssh/sshd_config
```
