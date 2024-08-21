```textile
作者：李晓辉
微信联系：Lxh_Chat
联系邮箱: 939958092@qq.com
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
