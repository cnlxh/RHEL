```textile
作者：李晓辉

微信联系：Lxh_Chat

联系邮箱: 939958092@qq.com
```

本文主要是阐述IPA SERVER的部署注意事项、安装流程等信息，本次采用IPA SERVER 4.12版本

# 先决条件

1. 内存不得小于2G
1. 必须具有静态主机名，不能是localhost 或 localhost6，必须是FQDN格式，且主机名必须可被解析
1. 反向解析的结果必须要能正确的解析为主机名

**设置主机名**

```bash
hostnamectl hostname lxh-ipa-master.lxh.cn
```

**添加解析**

```bash
cat > /etc/hosts <<'EOF'
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.8.100 lxh-ipa-master.lxh.cn lxh-ipa-master
192.168.8.200 lxh-ipa-slave.lxh.cn lxh-ipa-slave
EOF
```

# IPA 主节点部署

## 安装IPA SERVER

这个安装过程可能比较长，涉及下载和安装400多个软件包，耐心等待

```bash
dnf install freeipa-server-dns -y
```

## 配置IPA SERVER

`ipa-server-install`命令可以配置IPA SERVER的详细配置，如果有参数上的问题，可以`ipa-server-install --help`或者`man ipa-server-install`

我们本次的配置直接让它自动生成服务所需的DNS条目

```bash
ipa-server-install --setup-dns --auto-reverse --mkhomedir
```

输出和参数配置

```text
[root@lxh-ipa-master ~]# ipa-server-install --setup-dns --auto-reverse --mkhomedir

The log file for this installation can be found in /var/log/ipaserver-install.log
==============================================================================
This program will set up the IPA Server.
Version 4.12.0

This includes:
  * Configure a stand-alone CA (dogtag) for certificate management
  * Configure the NTP client (chronyd)
  * Create and configure an instance of Directory Server
  * Create and configure a Kerberos Key Distribution Center (KDC)
  * Configure Apache (httpd)
  * Configure DNS (bind)
  * Configure SID generation
  * Configure the KDC to enable PKINIT

To accept the default shown in brackets, press the Enter key.

Enter the fully qualified domain name of the computer
on which you're setting up server software. Using the form
<hostname>.<domainname>
Example: master.example.com


Server host name [lxh-ipa-master.lxh.cn]: //在这里回车

Warning: skipping DNS resolution of host lxh-ipa-master.lxh.cn
The domain name has been determined based on the host name.

Please confirm the domain name [lxh.cn]: //在这里回车

The kerberos protocol requires a Realm name to be defined.
This is typically the domain name converted to uppercase.

Please provide a realm name [LXH.CN]: //在这里回车
Certain directory server operations require an administrative user.
This user is referred to as the Directory Manager and has full access
to the Directory for system management tasks and will be added to the
instance of directory server created for IPA.
The password must be at least 8 characters long.

Directory Manager password: //在这里输入密码
Password (confirm):

The IPA server requires an administrative user, named 'admin'.
This user is a regular system account used for IPA server administration.

IPA admin password: //在这里输入密码
Password (confirm):

Checking DNS domain lxh.cn., please wait ...
DNS check for domain lxh.cn. failed: All nameservers failed to answer the query lxh.cn. IN SOA: Server 114.114.114.114 UDP port 53 answered SERVFAIL.
Do you want to configure DNS forwarders? [yes]: //这里配置外网DNS请求转发器
Following DNS servers are configured in /etc/resolv.conf: 114.114.114.114
Do you want to configure these servers as DNS forwarders? [yes]:
All detected DNS servers were added. You can enter additional addresses now:
Enter an IP address for a DNS forwarder, or press Enter to skip:
DNS forwarders: 114.114.114.114
Checking DNS forwarders, please wait ...
DNS server 114.114.114.114 does not support DNSSEC: answer to query '. SOA' is missing DNSSEC signatures (no RRSIG data)
Please fix forwarder configuration to enable DNSSEC support.

DNS server 114.114.114.114: answer to query '. SOA' is missing DNSSEC signatures (no RRSIG data)
Please fix forwarder configuration to enable DNSSEC support.
WARNING: DNSSEC validation will be disabled
Checking DNS domain 8.168.192.in-addr.arpa., please wait ...
Reverse zone 8.168.192.in-addr.arpa. will be created
Using reverse zone(s) 8.168.192.in-addr.arpa.
Trust is configured but no NetBIOS domain name found, setting it now.
Enter the NetBIOS name for the IPA domain.
Only up to 15 uppercase ASCII letters, digits and dashes are allowed.
Example: EXAMPLE.


NetBIOS domain name [LXH]: //在这里回车

Do you want to configure chrony with NTP server or pool address? [no]: yes //在这里输入yes，并配置NTP服务器
Enter NTP source server addresses separated by comma, or press Enter to skip: ntp.aliyun.com
Enter a NTP source pool address, or press Enter to skip:

The IPA Master Server will be configured with:
Hostname:       lxh-ipa-master.lxh.cn
IP address(es): 192.168.8.100
Domain name:    lxh.cn
Realm name:     LXH.CN

The CA will be configured with:
Subject DN:   CN=Certificate Authority,O=LXH.CN
Subject base: O=LXH.CN
Chaining:     self-signed

BIND DNS server will be configured to serve IPA domain with:
Forwarders:       114.114.114.114
Forward policy:   only
Reverse zone(s):  8.168.192.in-addr.arpa.

NTP server:     ntp.aliyun.com
Continue to configure the system with these values? [no]: //如果这里输出的参数满意，就在这里输入yes回车

```

输入yes回车之后，会进行较长时间的配置过程，请耐心等待，直到出现以下内容完成配置

```text
Setup complete

Next steps:
        1. You must make sure these network ports are open:
                TCP Ports:
                  * 80, 443: HTTP/HTTPS
                  * 389, 636: LDAP/LDAPS
                  * 88, 464: kerberos
                  * 53: bind
                UDP Ports:
                  * 88, 464: kerberos
                  * 53: bind
                  * 123: ntp

        2. You can now obtain a kerberos ticket using the command: 'kinit admin'
           This ticket will allow you to use the IPA tools (e.g., ipa user-add)
           and the web user interface.

Be sure to back up the CA certificates stored in /root/cacert.p12
These files are required to create replicas. The password for these
files is the Directory Manager password
The ipa-server-install command was successful
```

## 开通防火墙

```bash
firewall-cmd --permanent --add-port={80/tcp,443/tcp,389/tcp,636/tcp,88/tcp,88/udp,464/tcp,464/udp,53/tcp,53/udp,123/tcp,123/udp}
firewall-cmd --permanent --add-service={freeipa-4,dns}
firewall-cmd --reload
```

## 测试dashboard

在客户端上，需要在hosts文件中，添加IP到FQDN的解析

Windows的Hosts： C:\Windows\System32\drivers\etc\hosts

用浏览器就可以打开https://FQDN


# IPA 辅助节点部署

这里要注意，**将辅助节点的DNS设置为主节点的IP地址**，方便发现LDAP信息

**设置主机名**

```bash
hostnamectl hostname lxh-ipa-slave.lxh.cn
```

**添加解析**

```bash
cat > /etc/hosts <<'EOF'
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.8.100 lxh-ipa-master.lxh.cn lxh-ipa-master
192.168.8.200 lxh-ipa-slave.lxh.cn lxh-ipa-slave
EOF
```


## 安装IPA SERVER

这个安装过程可能比较长，涉及下载和安装400多个软件包，耐心等待

```bash
dnf install freeipa-server-dns -y
```

## 将辅助节点加入到域中

输入以下命令，将机器加入到主域，如果这一步失败，看看是否修改了DNS为主LDAP服务器

这个命令会自动发现所需的配置

```bash
ipa-client-install --mkhomedir
```

输出和配置

```text
This program will set up IPA client.
Version 4.12.0

Discovery was successful!
Do you want to configure chrony with NTP server or pool address? [no]: yes //这里输入yes，并配置NTP服务器
Enter NTP source server addresses separated by comma, or press Enter to skip: ntp.aliyun.com
Enter a NTP source pool address, or press Enter to skip:
Client hostname: lxh-ipa-slave.lxh.cn
Realm: LXH.CN
DNS Domain: lxh.cn
IPA Server: lxh-ipa-master.lxh.cn
BaseDN: dc=lxh,dc=cn
NTP server: ntp.aliyun.com

Continue to configure the system with these values? [no]: yes //自动发现了LDAP信息，确认没问题，就输入yes
Synchronizing time
Configuration of chrony was changed by installer.
Attempting to sync time with chronyc.
Time synchronization was successful.
User authorized to enroll computers: admin //输入管理员账号密码
Password for admin@LXH.CN:
Successfully retrieved CA cert
    Subject:     CN=Certificate Authority,O=LXH.CN
    Issuer:      CN=Certificate Authority,O=LXH.CN
    Valid From:  2024-07-05 05:28:19+00:00
    Valid Until: 2044-07-05 05:28:19+00:00

Enrolled in IPA realm LXH.CN
Created /etc/ipa/default.conf
Configured /etc/sssd/sssd.conf
Systemwide CA database updated.
Hostname (lxh-ipa-slave.lxh.cn) does not have A/AAAA record.
Missing reverse record(s) for address(es): 192.168.8.200.
Adding SSH public key from /etc/ssh/ssh_host_ed25519_key.pub
Adding SSH public key from /etc/ssh/ssh_host_ecdsa_key.pub
Adding SSH public key from /etc/ssh/ssh_host_rsa_key.pub
SSSD enabled
Configured /etc/openldap/ldap.conf
Configured /etc/ssh/ssh_config
Configured /etc/ssh/sshd_config.d/04-ipa.conf
Configuring lxh.cn as NIS domain.
Configured /etc/krb5.conf for IPA realm LXH.CN
Client configuration complete.
The ipa-client-install command was successful
```

## 将辅助节点加入到ipaserver组

**授权在客户端上安装副本**

```bash
kinit admin
Password for admin@LXH.CN:
```

```
ipa hostgroup-add-member ipaservers --hosts lxh-ipa-slave.lxh.cn
```

```text
  Host-group: ipaservers
  Description: IPA server hosts
  Member hosts: lxh-ipa-master.lxh.cn, lxh-ipa-slave.lxh.cn
-------------------------
Number of members added 1
-------------------------
```

## 开通防火墙

```bash
firewall-cmd --permanent --add-port={80/tcp,443/tcp,389/tcp,636/tcp,88/tcp,88/udp,464/tcp,464/udp,53/tcp,53/udp,123/tcp,123/udp}
firewall-cmd --permanent --add-service={freeipa-4,dns}
firewall-cmd --reload
```

## 配置为辅助节点

这个过程需要较久的时间，请耐心等待

```bash
ipa-replica-install --setup-dns --forwarder 114.114.114.114 --setup-ca
```

## 查询所有的IPA服务器列表

```bash
ipa-replica-manage list
```
输出
```text
lxh-ipa-master.lxh.cn: master
lxh-ipa-slave.lxh.cn: master
```

# 强制数据同步一次

```bash
ipa-replica-manage force-sync --from lxh-ipa-master.lxh.cn
```

## 测试dashboard

在客户端上，需要在hosts文件中，添加IP到FQDN的解析

Windows的Hosts： C:\Windows\System32\drivers\etc\hosts

用浏览器就可以打开https://FQDN

# 测试IPA服务器

在master上创建一个用户，去另一个上面查询

```bash
[root@lxh-ipa-master ~]# ipa user-add lxh
First name: xiaohui
Last name: li
----------------
Added user "lxh"
----------------
  User login: lxh
  First name: xiaohui
  Last name: li
  Full name: xiaohui li
  Display name: xiaohui li
  Initials: xl
  Home directory: /home/lxh
  GECOS: xiaohui li
  Login shell: /bin/sh
  Principal name: lxh@LXH.CN
  Principal alias: lxh@LXH.CN
  Email address: lxh@lxh.cn
  UID: 1826200003
  GID: 1826200003
  Password: False
  Member of groups: ipausers
  Kerberos keys available: False
```

去另一个slave服务器看看

```bash
[root@lxh-ipa-slave ~]# ipa user-find lxh
--------------
1 user matched
--------------
  User login: lxh
  First name: xiaohui
  Last name: li
  Home directory: /home/lxh
  Login shell: /bin/sh
  Principal name: lxh@LXH.CN
  Principal alias: lxh@LXH.CN
  Email address: lxh@lxh.cn
  UID: 1826200003
  GID: 1826200003
  Account disabled: False
----------------------------
Number of entries returned 1
----------------------------
```
