# 基于RHEL9的PXE系统部署指南

```text
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

|服务端机器名|服务端IP|
|-|-|
|lxh-server|192.168.8.200|


# 系统注册

这一步是为了向系统添加软件仓库，因为在此过程中，会涉及到多次软件安装

```bash
[root@lxh-server ~]# subscription-manager register --username xxxxxxxx --auto-attach --force
Registering to: subscription.rhsm.redhat.com:443/subscription
...
Status:       Subscribed
```

# 部署DHCP 服务器

## DHCP 软件安装

DHCP 给所有的客户机提供:

1. IP地址
2. TFTP服务器指引，用于下载引导文件

```bash
[root@lxh-server ~]# dnf install dhcp-server -y
```

## 创建DHCP 配置文件

默认情况下，/etc/dhcp/dhcpd.conf是空的，里面会有一个样例文件位置，可以用样例文件对真实的配置文件做一个覆盖，来给我们提供帮助

```bash
[root@lxh-server ~]# cp /usr/share/doc/dhcp-server/dhcpd.conf.example /etc/dhcp/dhcpd.conf
cp: overwrite '/etc/dhcp/dhcpd.conf'? y
```

完整的配置文件如下：

关于if的语句，下方有启动不同类型电脑的说明

```text
option domain-name "xiaohui.cn";
option domain-name-servers 192.168.8.200;
option architecture-type code 93 = unsigned integer 16;

default-lease-time 600;
max-lease-time 7200;

log-facility local7;

subnet 192.168.8.0 netmask 255.255.255.0 {
  range 192.168.8.100 192.168.8.200;
  option routers 192.168.8.2;
}

class "pxeclients" {
  match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
  next-server 192.168.8.200;
  if option architecture-type = 00:00 {
    filename "pxelinux.0";
  }
  else {
    filename "BOOTX64.EFI";
  }
}

```

**启动服务**

```bash
[root@lxh-server ~]# systemctl enable dhcpd --now
```

**启动基于BIOS的电脑**

从网卡启动后，电脑会自动发起DHCP广播，我们的DHCP服务器会给客户端回应一个地址，DHCP分发的历史都保存在`/var/lib/dhcpd/dhcpd.leases`

我们需要注意`vendor-class-identifier`这一行，这个 vendor-class-identifier 中的 `00000` 表示的是未指定的体系结构，而不是具体的体系结构类型。通常情况下，`00000` 用于表示 BIOS 引导的客户端。

```text
[root@lxh-server ~]# cat /var/lib/dhcpd/dhcpd.leases
lease 192.168.8.100 {
  starts 1 2024/03/11 05:44:20;
  ends 1 2024/03/11 05:54:20;
  cltt 1 2024/03/11 05:44:20;
  binding state active;
  next binding state free;
  rewind binding state free;
  hardware ethernet 00:50:56:2c:dc:a0;
  uid "\000VM\370\353c\276\220\326:\264$\215\362\033M\346";
  set vendor-class-identifier = "PXEClient:Arch:00000:UNDI:002001";
}
```

**启动基于UEFI的电脑**

先删除服务器上的租约文件，防止信息干扰

```bash
[root@lxh-server ~]# rm -rf /var/lib/dhcpd/dhcpd.leases
[root@lxh-server ~]# touch /var/lib/dhcpd/dhcpd.leases
[root@lxh-server ~]# systemctl restart dhcpd
```
我们需要注意`vendor-class-identifier`这一行，这个 vendor-class-identifier 中的 `00007` 代表的是UEFI x86-64架构

```text
[root@lxh-server ~]# cat /var/lib/dhcpd/dhcpd.leases
lease 192.168.8.100 {
  starts 1 2024/03/11 05:49:43;
  ends 1 2024/03/11 05:59:43;
  cltt 1 2024/03/11 05:49:43;
  binding state active;
  next binding state free;
  rewind binding state free;
  hardware ethernet 00:50:56:2c:dc:a0;
  uid "\000VM\370\353c\276\220\326:\264$\215\362\033M\346";
  set vendor-class-identifier = "PXEClient:Arch:00007:UNDI:003000";
}
```

## 启动DHCPD服务

```bash
[root@lxh-server ~]# systemctl restart dhcpd
```

## 开通防火墙

```bash
[root@lxh-server ~]# firewall-cmd --add-service=dhcp --permanent
[root@lxh-server ~]# firewall-cmd --reload
```

# 部署HTTP服务器

HTTP服务器用于在网络安装期间的光盘资料托管，其中ks.cfg是kickstart自动应答文件

```bash
[root@lxh-server ~]# dnf install httpd -y
```

```bash
[root@lxh-server ~]# mount /dev/cdrom /mnt
[root@lxh-server ~]# cp -a /mnt/* /var/www/html/
[root@lxh-server ~]# cp -a ks.cfg /var/www/html/
[root@lxh-server ~]# restorecon -RvF /var/www/
```
```bash
[root@lxh-server ~]# systemctl enable httpd --now
```


# 部署TFTP服务器

## 安装TFTP-SERVER

```bash
[root@lxh-server ~]# dnf install tftp-server -y
```

## 拷贝ISOLINUX启动资料

将启动文件从光盘拷贝到TFTP服务器

```bash
[root@lxh-server ~]# mount /dev/cdrom /mnt
[root@lxh-server ~]# cp /mnt/isolinux/* /var/lib/tftpboot/
```
## 准备BIOS引导文件

安装后会生成

```bash
[root@lxh-server ~]# dnf install syslinux -y
[root@lxh-server ~]# find / -name pxelinux.0
/usr/share/syslinux/pxelinux.0
[root@lxh-server ~]# cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
```

## 准备BIOS引导配置文件

```bash
[root@lxh-server tftpboot]# mkdir /var/lib/tftpboot/pxelinux.cfg
[root@lxh-server tftpboot]# cp /var/lib/tftpboot/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default
[root@lxh-server tftpboot]# vim /var/lib/tftpboot/pxelinux.cfg/default
...
label linux
  menu label ^Install Red Hat Enterprise Linux 9.3
  kernel vmlinuz
  append initrd=initrd.img inst.stage2=http://192.168.8.200 inst.ks=http://192.168.8.200/ks.cg quiet
```
```bash
[root@lxh-server tftpboot]# chmod 755 /var/lib/tftpboot -R
```
## 准备UEFI引导文件

```bash
[root@lxh-server ~]# cp -r /mnt/EFI/BOOT/* /var/lib/tftpboot/
[root@lxh-server ~]# chmod 755 /var/lib/tftpboot -R
```
## 准备UEFI引导配置文件

```bash
[root@lxh-server ~]# vim /var/lib/tftpboot/grub.cfg
```

```text
set default="0"
...
menuentry 'Install Red Hat Enterprise Linux 9.3' --class fedora --class gnu-linux --class gnu --class os {
        linuxefi vmlinuz inst.stage2=http://192.168.8.200 inst.ks=http://192.168.8.200/ks.cg quiet
        initrdefi initrd.img
}
```
```bash
[root@lxh-server tftpboot]# chmod 755 /var/lib/tftpboot -R
```
## 启动TFTP服务

```bash
[root@lxh-server ~]# systemctl enable tftp --now
```
## 开通防火墙

```bash
[root@lxh-server ~]# firewall-cmd --add-service=tftp --permanent
[root@lxh-server ~]# firewall-cmd --reload
```
