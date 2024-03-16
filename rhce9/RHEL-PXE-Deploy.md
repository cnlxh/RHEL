# PXE 系统部署指南

```text
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

|服务端机器名|服务端IP|系统版本|
|-|-|-|
|lxh-server|192.168.8.200|RHEL9.3|

这里介绍一下如何通过网络来安装Linux系统，在安装过程中，同时支持BIOS和UEFI，网络安装linux的大概流程如下：

先分析客户端PXE流程

# 客户端 PXE 流程分析

- **客户端启动**
  - 发起 DHCP 请求
  - 获得 IP 地址、网关和 DNS 信息
  - 获得 PXE 引导文件名
- **下载引导文件**
  - 如果是 BIOS，使用 TFTP 下载 BIOS 引导文件`pxelinux.0`
  - 如果是 UEFI，使用 TFTP 下载 UEFI 引导文件`BOOTX64.EFI`
  - 引导文件的配置文件指向相应的内核和文件系统
- **安装 Linux**
  - 内核引导
  - 挂载文件系统
  - 从 HTTP 服务器获取镜像
  - 从 HTTP 服务器获取ks自动应答文件
  - 执行安装过程

下面正式开始部署过程：

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
[root@lxh-server ~]# vim /etc/dhcp/dhcpd.conf
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

**启动DHCP服务**

```bash
[root@lxh-server ~]# systemctl enable dhcpd --now
```

## 检查DHCP OPTION

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

## 启动DHCP服务

```bash
[root@lxh-server ~]# systemctl restart dhcpd
```

## 为DHCP开通防火墙

```bash
[root@servera ~]# firewall-cmd --add-service=dhcp --permanent
success
[root@servera ~]# firewall-cmd --reload
success
```

# 部署HTTP服务器

## HTTPD软件安装

HTTP服务器用于在网络安装期间的光盘资料托管，其中ks.cfg是kickstart自动应答文件

```bash
[root@lxh-server ~]# dnf install httpd -y
```

## 准备安装资料

将ISO或光盘挂载到/mnt，给网站提供素材

```bash
[root@lxh-server ~]# mount /dev/cdrom /mnt
[root@lxh-server ~]# cp -a /mnt/* /var/www/html/
[root@lxh-server ~]# cp /mnt/.discinfo /mnt/.treeinfo /var/www/html/
[root@lxh-server ~]# cp -a ks.cfg /var/www/html/
[root@lxh-server ~]# restorecon -RvF /var/www/
```

## 启动HTTPD服务

```bash
[root@lxh-server ~]# systemctl enable httpd --now
```

## 为HTTP开通防火墙

```bash
[root@servera ~]# firewall-cmd --add-service=http --permanent
success
[root@servera ~]# firewall-cmd --reload
success
```


# 部署TFTP服务器

TFTP服务器用于在DHCP获得IP地址后，在硬件环境下获取基础文件，通过 TFTP 从服务器上下载引导程序，而无需本地存储介质

## 安装TFTP-SERVER

```bash
[root@lxh-server ~]# dnf install tftp-server -y
```

## 拷贝ISOLINUX启动资料

将启动过程中会用到的资料从光盘拷贝到TFTP服务器

```bash
[root@lxh-server ~]# mount /dev/cdrom /mnt
[root@lxh-server ~]# cp /mnt/isolinux/* /var/lib/tftpboot/
```
## 准备BIOS引导文件

安装后会生成`pxelinux.0`文件，用于BIOS引导

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
  menu default
  kernel vmlinuz
  append initrd=initrd.img inst.stage2=http://192.168.8.200 inst.ks=http://192.168.8.200/ks.cfg quiet
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
        linuxefi vmlinuz inst.stage2=http://192.168.8.200 inst.ks=http://192.168.8.200/ks.cfg quiet
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
## 为TFTP开通防火墙

```bash
[root@lxh-server ~]# firewall-cmd --add-service=tftp --permanent
[root@lxh-server ~]# firewall-cmd --reload
```

# 测试PXE部署效果

将客户端置于相同的网络中，并从网卡启动客户端，客户端会从我们的DHCP获得IP，从TFTP下载kernel等信息，从http下载安装过程中的软件