
```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# 课程环境硬件需求

|CPU|内存|硬盘|操作系统|软件版本|
|-|-|-|-|-|
|10代i5以上|至少16G，推荐32G|至少100G SSD|Windows10 x64|至少VMware Workstaion 17或同级版本的Fustion<br>7z解压缩软件用于解压虚拟机|

# 课堂环境介绍

![class-env-intro](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/class-env-intro.png)

在本课程中，实践操作学习活动需使⽤的主要计算机系统为 workstation。学员还会使⽤另外两台计算机来完成这些活动：servera 和 serverb。这三个系统都在 lab.example.com DNS 域内。

## 虚拟机账号密码

|角色|账号|密码|
|-|-|-|
|foundation|root<br>kiosk|Asimov<br>redhat|
|所有其他虚拟机|root<br>student|redhat<br>student|

## 虚拟机角色说明

|计算机名称|IP 地址|⻆⾊|
|-|-|-|
|bastion.lab.example.com|172.25.250.254|⽤于将学员专⽤⽹络连接到课堂服务器的⽹关系统（必须始终处于运⾏状态）|
|classroom.example.com|172.25.254.254|托管所需课堂资料的服务器|
|workstation.lab.example.com|172.25.250.9|供学员使⽤的图形⼯作站|
|servera.lab.example.com|172.25.250.10|受管服务器“A”|
|serverb.lab.example.com|172.25.250.11|受管服务器“B”|

bastion 的主要功能是充当连接学员计算机的⽹络和课堂⽹络之间的路由器。如果 bastion 宕机，则其他学员计算机将仅可访问个别学员⽹络中的系统。

课堂中有⼏个系统提供⽀持服务。content.example.com 和 materials.example.com 这两台服务器提供动⼿实践活动中使⽤的软件和实验材料。为确保正确使⽤实验环境，classroom和 bastion 都必须始终处于运⾏状态。

## 课程虚拟机环境操作指南

[点我前往课程环境操作指南](https://gitee.com/cnlxh/rhel/blob/master/rhce9/RHCE9.0-VMs-Usage-Guide.md)

# 第一章 红帽企业 Linux ⼊⻔

## Linux 的优点是什么？

1. Linux 是开源软件，开源意味着你可以彻底了解程序或系统的⼯作⽅式，并可以加以修改做到加速创新

2. Linux 提供命令⾏接⼝ (CLI)，不仅访问便捷，⽽且具备强⼤的脚本化功能，例如bash

3. Linux 是⼀种模块化操作系统，设计为可以轻松替换或删除组件，需要时，可以对系统组件进⾏升级和更新

## 什么是开源软件？

开源软件是任何⼈都可以使⽤、研究、修改和共享其源代码的软件。当版权持有者根据开源许可证提供软件时，将向⽤⼾授予运⾏程序的权限，以及查看、修改、编译源代码并以免版税的形式将源代码重新分发给他⼈的权限。开源许可能够促进协作、共享、透明化和快速创新，因为它⿎励更多⼈员对软件进⾏修改和改进，在更⼴阔的范围内分享增强。

开源对⽤⼾有诸多好处：

- 控制：查看代码的⽤途，并进⾏改进。

- 培训：从实际代码中学习，并开发更实⽤的应⽤。

- 安全：检查敏感代码，并加以修复，甚⾄⽆需原始开发⼈员的帮助。

- 稳定：信赖代码可在原始开发⼈员缺位时继续存活

## 开源许可证的类型

**公共版权许可证**
```text
许可证要求分发源代码的任何⼈（不论有⽆更改）必须将⾃由传递下去，让他⼈也能复制、更改和分发代码。
```

**宽松式许可证**
```text
宽松式许可证能最⼤限度提⾼源代码可重⽤性。只要保留版权和许可声明，你就可以将源代码⽤于任何⽤途，包括根据更严格或专有的许可证重⽤该代码
```

## 什么是 Linux 发⾏版？

Linux 发⾏版是⼀种可安装的操作系统，由 Linux 内核以及提供⽀持的⽤⼾程序和库构建⽽成。发⾏版具有⼀些共同的特征：

- 发⾏版由 Linux 内核和⽀持⽤⼾空间程序组成。

- 发⾏版可以较⼩并且⽤途单⼀，也可包含数以千计的开源程序。

- 发⾏版提供⼀种安装和更新软件及其组件的途径。

- 发⾏版提供商为软件提供⽀持，并且理想情况下也参与开发社区。

## 红帽企业 Linux ⽣态系统

![fedora-centos-rhel](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/fedora-centos-rhel.png)

**fedora**

Fedora 是⼀个开发和发布免费、完整、基于 Linux 的操作系统的社区项⽬,不提供支持，Bug较多

**EPEL**

Fedora 项⽬特别兴趣⼩组 (SIG) 构建并维护⼀个由社区⽀持的软件包存储库，名为 Extra Packages for Enterprise Linux (EPEL)。提供了RHEL系统中默认没有的一些额外软件包

**CentOS Stream**

CentOS Stream 是 RHEL 的上游项⽬，不提供支持。Fedora测试好的软件会提交到CentOS Stream中，而CentOS Stream中测试好的软件会提交到RHEL中

**红帽企业 Linux**

红帽企业 Linux (RHEL) 是红帽提供的、受商业⽀持的⽣产就绪型Linux 发⾏版。拥有庞⼤的⽀持合作伙伴⽣态系统，提供硬件和软件认证、咨询服务、培训以及为期多年的⽀持和维护保障。

---

所以RHEL的由来关系是： fedora---> CentOS Stream---> RHEL

以上三者之间的区别如下所示：

![fedora-centos-rhel-dff](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/fedora-centos-rhel-diff.png)

## RHEL 操作系统下载

下载可能需要有开发者订阅，此订阅是免费注册的，具体链接如下：

RHEL 开发者订阅注册：https://developers.redhat.com/register

RHEL 下载链接：https://access.redhat.com/downloads/content/rhel

# 第二章 访问命令⾏

## Bash Shell 简介

红帽企业 Linux 中为⽤⼾提供的默认 shell 是bash，bash shell 在概念上类似于 Microsoft Windows cmd.exe 命令⾏解释器。但
是，bash 具有复杂的脚本语⾔，与 Windows PowerShell 更加相似。

## Bash 用户提示符

以下提示符表示，lixiaohui用户作为普通身份 `$` 登录到了host1这台主机，并位于 `~` 的位置，而 `~` 代表每个人自己的家目录，也是每个用户登录到系统的默认位置，除root这个超级管理员外，每个人的家目录是/home/USERNAME中，其中USERNAME是指每个人的用户名

```bash
[lixiaohui@host1 ~]$
```

以下提示符表示，超级用户root作为特权身份 `#` 登录到了host1这台主机，并位于 `~` 的位置，而 `~` 代表每个人自己的家目录，也是每个用户登录到系统的默认位置，需要注意超级用户root的家目录是独特的/root，而不在/home中

```bash
[root@host1 ~]#
```

## Shell 基础知识

在 shell 提⽰符下输⼊的命令由三个基本部分组成：

- 命令是要运⾏的程序的名称。其后可能跟着⼀个或多个选项，⽤于调整命令的⾏为或作⽤。

- 选项通常以⼀个或两个破折号开头（例如，-a 或 --all），以将其与参数区分。

- 命令后⾯可能也会跟着⼀个或多个参数，这些参数通常⽤于指明应在其中运⾏命令的⽬标。

以下例子是列出 `/` 下包括隐藏文件在内的所有文件
|命令|选项|参数|
|-|-|-|
|ls|-a|/|

以下例子是切到到user1的身份

```bash
su - user1
```
## 切换本地控制台终端

**需要注意的是，实际工作中，大多数任务都是通过SSH来登录的，很少情况下才会在控制台做切换，此处仅作了解**

终端是⼀个基于⽂本的界⾯，可以向计算机系统输⼊命令以及显⽰计算机系统的输出。

你可以在Linux 控制台中同时按 Ctrl+Alt 和功能键（F1 到 F6）来切换虚拟控制台，在不同的控制台完成登陆后，执行不同的任务

在红帽企业 Linux 9 中，如果图形环境可⽤，则登录屏幕将会在称为 tty1 的第⼀个虚拟控制台中运⾏。第⼆（tty2）到第六（tty6）虚拟控制台上则提供另外五个⽂本登录提⽰符。

## 远程登录系统

**⼤多数 Linux 系统提供ssh命令来远程登录Linux，这才是实际工作中常用的**

ssh 命令通过加密连接来防⽌通信被窃听或劫持密码和内容，具体的实现原理在RH124后续章节介绍

在第一次连接陌生的机器时，会提示你 `yes/no`，如果确认机器无误，输入yes回车即可连接，任务完毕后，输入 `exit` 退出SSH会话

- 以lixiaohui的身份登录host2这台机器，需要输入host2上的lixiaohui用户的密码

```bash
[lixiaohui@host1 ~]$ ssh lixiaohui@host2
lixiaohui@host2's password: `password`
```
- 用SSH私钥免密登录远程host2

```bash
[lixiaohui@host1 ~]$ ssh -i secret.pem lixiaohui@host2
[lixiaohui@host2 ~]$
```

## Bash 基本技巧

如上所述，Bash 一般分为 `命令+选项+参数` 输入完毕后回车即可执行

### 多个命令连接

以下案例中，ls /home是列出/home的内容，echo hello是在屏幕中输出hello字符串，用分号 **`;`** 连接在一起，可以一起执行
```bash
[lixiaohui@host1 ~]$ ls /home;echo hello
lixiaohui  readme.txt
hello
```

### 获取时间

我们注意到不同的选项有不同的结果

```bash
[lixiaohui@host1 ~]$ date
Wed Jan 31 10:53:33 PM CST 2024
[lixiaohui@host1 ~]$ date +%R
22:53
[lixiaohui@host1 ~]$ date +%x
01/31/2024
```

### 更改用户的密码

普通用户改自己的密码需要输入当前密码才可以改，而且普通用户无法给别人改密码

超级用户root可以给别人改密码，且不需要当前密码

```bash
[lixiaohui@host1 ~]$ passwd
Changing password for user lixiaohui.
Current password:
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ passwd user1
passwd: Only root can specify a user name.
```

```bash
[lixiaohui@host1 ~]$ su - root
Password:
Last login: Wed Jan 31 22:48:06 CST 2024 from 172.25.254.1 on pts/0
[root@host1 ~]#
[root@host1 ~]# passwd lixiaohui
Changing password for user lixiaohui.
New password:
BAD PASSWORD: The password is a palindrome
Retype new password:
passwd: all authentication tokens updated successfully.
```

### 识别文件类型

linux中的文件并不能简单依靠后缀名来区分文件类型，因为Linux中的所有内容都被成为文件（一切皆文件），所以系统中有一个file命令可以帮助我们识别文件类型

```bash
[lixiaohui@host1 ~]$ file /etc/passwd
/etc/passwd: ASCII text
[lixiaohui@host1 ~]$ file /bin/passwd
/bin/passwd: setuid ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=a467cb9c8fa7306d41b96a820b0178f3a9c66055, for GNU/Linux 3.2.0, stripped
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ file /home
/home: directory
```

### 查看文件内容

`cat more less head tail` 等命令可以用来查看文件内容

1. cat 用于全文输出，通常用于小型文件, 命令后可以跟多个文件用于一起输出

```bash
[lixiaohui@host1 ~]$ cat /readme.txt /mnt/test.txt
This is a vm for RedHat Training，Created by Xiaohui Li, Contact me via WeiXin: Lxh_Chat, QQ: 939958092

test file
```

2. 文件较长时就不推荐用cat了，less 命令⼀次显⽰⽂件的⼀个⻚⾯，可以按上下键一行一行查看，也可以按下up和down键来一页一页查看，按q结束查看

```bash
[lixiaohui@host1 ~]$ less /etc/passwd
```

3. head 和 tail 命令分别显⽰⽂件的开头和结尾部分。默认情况下，这两个命令显⽰⽂件的 10 ⾏，但它们都有⼀个 -n 选项，允许指定不同的⾏数。

查看文件开头的10行或2行

```bash
[lixiaohui@host1 ~]$ head /etc/passwd
[lixiaohui@host1 ~]$ head -n 2 /etc/passwd
```
查看文件结尾的10行或2行

```bash
[lixiaohui@host1 ~]$ tail /etc/passwd
[lixiaohui@host1 ~]$ tail -n 2 /etc/passwd
```

### 统计文件信息

wc 命令可计算⽂件中⾏、字和字符的数量。使⽤ -l、-w 或 -c 选项，分别可以仅显⽰⾏数、字数或字符数。

```bash
[lixiaohui@host1 ~]$  wc /etc/passwd
45  104 2494 /etc/passwd
[lixiaohui@host1 ~]$ wc -l /etc/passwd
45 /etc/passwd
```

### Tab 补全

通过 Tab 补全，⽤⼾可在提⽰符下键⼊⾜够的内容以使其唯⼀后快速补全命令或⽂件名。如果键⼊的字符不唯⼀，则按 Tab 键两次可显⽰以所键⼊字符为开头的所有命令。

**命令和参数补齐**

```bash
[lixiaohui@host1 ~]$ pasTab+Tab # 手工输入了pas字符串，并快速按下两次TAB键，会自动找出所有以pas开头的命令，结果有多个匹配
 passwd       paste        pasuspender
[lixiaohui@host1 ~]$ passTab # 手工输入了pass字符串，并快速按下一次TAB键, 会自动找出所有以pass开头的命令，结果只有一个匹配，会自动补齐剩下的字符串
[lixiaohui@host1 ~]$ passwd
 Changing password for user lixiaohui.
 Current password:
 ```
```bash
[root@host ~]# useradd --Tab+Tab ## 手工输入useradd --后快速按下两次TAB，可以用于补齐参数

--badnames              --gid                   --no-log-init
```

**路径补齐**

Tab 补全可以帮助在键⼊⽂件名作为命令的参数时将它们补全。按 Tab，尽可能将⽂件名补充完整。

```bash
[user@host ~]$ ls /etc/pasTab # 手工输入了/etc/pas字符串，并快速按下一次TAB键，就会自动补齐/etc/passwd
[user@host ~]$ ls /etc/passwdTab # 自动补齐/etc/passwd字符串，并快速按下一次TAB键，就会自动补齐/etc/passwd开头的所有文件路径和名称
passwd   passwd-
```

### 编写长命令

具有多个选项和参数的命令可能会很快变得很⻓，不美观也不方便管理，可以使⽤反斜杠字符 (\)，它称为 转义字符，它可以在不向系统发送回车的情况下，以多行显示，方便管理也美观

以下例子中，我们统计了/etc/passwd、/etc/fstab、/readme.txt的行数

我们需要注意从第一个转义符回车开始，系统会自动添加一个`>`来表示命令的延续，请不要手工输入这个延续符号

```bash
[lixiaohui@host1 ~]$ wc -l /etc/passwd \
> -l /etc/fstab \
> -l /readme.txt

  45 /etc/passwd
  17 /etc/fstab
   1 /readme.txt
  63 total
```

### 操作命令历史记录

history 命令显⽰之前执⾏的命令的列表，带有命令编号作为前缀。默认提供1000条历史记录

```bash
[lixiaohui@host1 ~]$ set | grep -i histsize
HISTSIZE=1000
```

```bash
[lixiaohui@host1 ~]$ history
 ...output omitted...
   23  clear
   24  who
   25  pwd
   26  ls /etc
   27  uptime
   28  ls -l
   29  date
   30  history
```

**重复调用历史输入过的命令**

1. 字符匹配法

这种方法会自动从history命令的输出中自下向上匹配开头的字符串是否匹配，匹配到第一个就执行

```bash
[lixiaohui@host1 ~]$ !ls
 ls -l
 total 0
 drwxr-xr-x. 2 student student 6 Feb 27 19:24 Desktop
```

2. 数字法匹配

这种方法需要你知道准确的history命令行编号

```bash
[lixiaohui@host1 ~]$ !26
 ls /etc
 abrt                     hosts
```

3. 快捷键匹配

在bash中，按下`ctrl r` 后，输入的任何字符串都会从history中，自下向上匹配，如果显示的内容不符合要求，可以再多输入一些内容，它会再次匹配

以下例子中，我按下了ctrl r，然后输入了一个w字符串，它自动识别到了`wc -l /etc/passwd -l /etc/fstab -l /readme.txt`

```bash
[lixiaohui@host1 ~]$
(reverse-i-search)`w': wc -l /etc/passwd -l /etc/fstab -l /readme.txt
```

### 快速访问上一次参数

同时使⽤ Esc+. 或 Alt+. 组合键，在光标的当前位置插⼊上⼀命令的最后⼀个单词，Alt+. 组合键尤其⽅便，因为你可
以按住 Alt 键，再反复按 . 键来轻松地循环更早的命令。

```bash
[lixiaohui@host1 ~]$ ls /etc/passwd
/etc/passwd
[lixiaohui@host1 ~]$ cat /etc/passwd # 此处的/etc/passwd并非是我手工输入，是按下alt和英文句号的自动效果
```

### bash 命令行快捷键

|快捷键|描述|
|-|-|
|Ctrl+A|跳到命令⾏的开头|
|Ctrl+E|跳到命令⾏的末尾|
|Ctrl+U|将光标处到命令⾏开头的内容清除|
|Ctrl+K|将光标处到命令⾏末尾的内容清除|
|Ctrl+LeftArrow|跳到命令⾏中前⼀字的开头|
|Ctrl+RightArrow|跳到命令⾏中下⼀字的末尾|
|Ctrl+R|在历史记录列表中搜索某⼀模式的命令|

# 第三章 从命令⾏管理⽂件


## ⽂件系统层次结构

Linux 系统中的所有⽂件存储在⽂件系统中，它们被组织到⼀棵上下颠倒的树中，称为⽂件系统层次结构。这个层次结构是上下颠倒的树，因为树根在顶部，树根下⽅延伸出⽬录和⼦⽬录的分⽀。

`/` ⽬录是`根⽬录`，位于⽂件系统层次结构的顶部。`/` 字符还⽤作⽂件名中的⽬录分隔符。例如，如果 etc 是 `/` ⽬录的⼦⽬录，则可将该⽬录指代为 `/etc`。类似地，如果 `/etc` ⽬录包含⼀个名为issue 的⽂件，可以将该⽂件指代为 `/etc/issue`。

![linux-file-tree](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/linux-file-tree.png)


## 红帽企业 Linux 重要⽬录

|位置|⽤途|
|-|-|
|/boot|开始启动过程所需的⽂件|
|/dev|供系统⽤于访问硬件的特殊设备⽂件|
|/etc|特定于系统的配置⽂件|
|/home|供普通⽤⼾存储其个⼈数据和配置⽂件的主⽬录|
|/root|管理超级⽤⼾ root 的主⽬录|
|/run|⾃上⼀次系统启动以来启动的进程的运⾏时数据。这些数据包括进程 ID ⽂件和锁定⽂件。此⽬录中的内容在重启时重新创建。此⽬录合并了早期版本的红帽企业Linux 中的 /var/run 和 /var/lock ⽬录。|
|/tmp|供临时⽂件使⽤的全局可写空间。10 天内未曾访问、更改或修改的⽂件将⾃动从该⽬录中删除。/var/tmp ⽬录也是⼀个临时⽬录 ，其中的⽂件如果在 30 天内未曾访问、更改或修改过，将被⾃动删除|
|/usr|安装的软件、共享的库（包括⽂件）和只读程序数据。/usr ⽬录中的重要⼦⽬录包括下列命令：<br> 1. /usr/bin：⽤⼾命令<br>2. /usr/sbin：系统管理命令<br>3. /usr/local：本地⾃定义软件|
|/var|特定于系统的可变数据应在系统启动之间保持永久性。动态变化的⽂件（如数据库、缓存⽬录、⽇志⽂件、打印机后台处理⽂档和⽹站内容）可以在 /var 下找到|

## 绝对路径和相对路径

1. 绝对路径

绝对路径是⼀个完全限定名称，⽤于指定⽂件在⽂件系统层次结构中的确切位置。绝对路径从根 (/)⽬录开始，并包括到达特定⽂件所必须遍历的每个⼦⽬录，以下是绝对路径的用法，路径的第一个字符是 `/`

绝对路径名输入起来可能会太⻓，但是绝对有效和准确

```bash
cat /etc/passwd
rm -rf /etc/lixiaohui/testfile
```

用绝对路径创建文件

touch 命令用于创建空白文件，当目标文件已经存在时，touch将会更新此文件的时间戳

```bash
touch /tmp/lixiaohuitest
touch /mnt/lxh-testfile
```
2. 相对路径

大家先看这一段描述内容:

```text
我是李晓辉，我来自宇宙、银河系、地球、亚洲、中国、河南省、安阳市、经纬度为xxxx
```

描述准确无误，但是这是绝对路径，说起来太麻烦

大家再看这些描述

```text
我在中国 //我不需要说我在宇宙中，因为大家已经在宇宙中了
```

```text
你帮我从那个红色的桌子上拿一个充电宝过来 //我没有说从安阳市哪个街道哪个小区哪个楼哪个门牌号，因为我们都在这个屋子里
```

相对路径有一个基准，就是当前位置，在Linux中，当前位置用一个英文的句号来表示 `.` ，上一级路径用两个英文句号来表示 `..`

cd 命令用于切换工作路径，cd .表示进入当前路径，cd ..进入父目录，cd - 切换回进⼊当前⽬录之前所处的⽬录

```bash
cd /lixiaohui/project1/test/
# 下面这个命令将进入cd /lixiaohui/project1/路径
cd ..
# 下面这个命令将/etc/fstab赋值到当前路径中
cp /etc/fstab .
```

查询当前路径在系统中的绝对路径写法

```bash
[lixiaohui@host1 ~]$ pwd
 /home/lixiaohui
```

## 创建⽬录

```bash
mkdir /lxhfolder
mkdir /tmp/lixiaohui
```

mkdir -p 在父目录不存在时，直接将父目录自动创建

```bash
[lixiaohui@host1 ~]$ mkdir /tmp/lixiaohui/testfolder
mkdir: cannot create directory ‘/tmp/lixiaohui/testfolder’: No such file or directory
[lixiaohui@host1 ~]$ mkdir -p /tmp/lixiaohui/testfolder
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ ll -d /tmp/lixiaohui/testfolder
drwxr-xr-x. 2 lixiaohui lixiaohui 6 Feb  1 00:37 /tmp/lixiaohui/testfolder
```

## 复制⽂件和⽬录

cp 命令可复制⽂件到当前⽬录或其他指定⽬录

cp 可以不断的表示要复制走的文件，但是要求最后一个参数必须是目标文件夹

```bash
[lixiaohui@host1 ~]$ mkdir /home/lixiaohui/folder1
[lixiaohui@host1 ~]$ ls -l /home/lixiaohui/folder1
total 0
[lixiaohui@host1 ~]$ cp /etc/fstab /mnt/readme.txt /home/lixiaohui/folder1
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ ls -l /home/lixiaohui/folder1
total 8
-rw-r--r--. 1 lixiaohui lixiaohui 982 Feb  1 00:39 fstab
-rw-r--r--. 1 lixiaohui lixiaohui 105 Feb  1 00:39 readme.txt
```

cp 在复制文件夹时，必须带上 `-r` 这个参数做递归操作才能把文件夹复制走

```bash
[lixiaohui@host1 ~]$ cp /home/lixiaohui/folder1 /tmp/
cp: -r not specified; omitting directory '/home/lixiaohui/folder1'
[lixiaohui@host1 ~]$ ls -d /tmp/folder1
ls: cannot access '/tmp/folder1': No such file or directory
[lixiaohui@host1 ~]$ cp -r /home/lixiaohui/folder1 /tmp/
[lixiaohui@host1 ~]$ ls -d /tmp/folder1
/tmp/folder1
```

## 移动⽂件和⽬录

mv 命令可将⽂件从⼀个位置移动到另⼀个位置，如果源路径和目标路径是同样的路径，但目前文件名和源文件名不同，将是重命名效果

**文件移动**

```bash
[lixiaohui@host1 ~]$ touch /tmp/file1
[lixiaohui@host1 ~]$ mkdir /tmp/folder1
[lixiaohui@host1 ~]$ ls -l /tmp/folder1
total 0
[lixiaohui@host1 ~]$ mv /tmp/file1 /tmp/folder1/
[lixiaohui@host1 ~]$ ls -l /tmp/folder1/
total 0
-rw-r--r--. 1 lixiaohui lixiaohui 0 Feb  1 22:50 file1

```

**文件重命名**

```bash
[lixiaohui@host1 ~]$ ll /tmp/folder1/
total 0
-rw-r--r--. 1 lixiaohui lixiaohui 0 Feb  1 22:50 file1
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ mv /tmp/folder1/file1 /tmp/folder1/file2
[lixiaohui@host1 ~]$ ll /tmp/folder1/
total 0
-rw-r--r--. 1 lixiaohui lixiaohui 0 Feb  1 22:50 file2
```

## 删除⽂件和⽬录

1. rm 默认删除文件，但是不删除目录，可以加上`-r`递归选项来同时删除非空目录

2. rm 可以跟上`-i` 在删除具体文件时，问你是否删除，跟上`-f` 来不提示且强制删除

3. rm -rf 可以删除文件以及所有目录，此操作强制静默执行目录的递归删除

```bash
[lixiaohui@host1 ~]$ ll /tmp/folder1/
total 0
-rw-r--r--. 1 lixiaohui lixiaohui 0 Feb  1 22:50 file2
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ rm /tmp/folder1/file2
[lixiaohui@host1 ~]$ ll /tmp/folder1/file2
ls: cannot access '/tmp/folder1/file2': No such file or directory

[lixiaohui@host1 ~]$ touch /tmp/folder1/lxhtest
[lixiaohui@host1 ~]$ rm -i /tmp/folder1/lxhtest
rm: remove regular empty file '/tmp/folder1/lxhtest'? y

[lixiaohui@host1 ~]$ ls /tmp/folder1/
file1  file10  file2  file3  file4  file5  file6  file7  file8  file9  lxhtest
[lixiaohui@host1 ~]$ rm -rf /tmp/folder1/*
[lixiaohui@host1 ~]$ ll /tmp/folder1/
total 0

```

## 创建硬链接

每个文件在系统中都会有一个唯一的`索引节点编号`，也被称为`inode号码`，硬链接就是直接把硬盘中的数据`在多处显示`，而不是在硬盘中复制多份，所以，多次创建同一个文件的硬链接并`不会多次占用空间`，硬链接没有源文件和目标文件的说法，所以所谓的源文件被删除，所谓的目标文件依旧可用，因为它们是硬盘中的同一份数据的多个位置显示，删除文件只是取消在某处的显示，但由于硬链接对inode强依赖，而inode是而格式化分区时产生的，所以硬链接不能 `跨格式化`，也就是说不能跨设备实现，而且硬链接也不能对文件夹实现


以下例子中，所有的硬链接都具有相同的编号： `268964355`
```bash
[lixiaohui@host1 ~]$ touch /tmp/folder1/lxhfile1
[lixiaohui@host1 ~]$ ls -i /tmp/folder1/lxhfile1
268964355 /tmp/folder1/lxhfile1
[lixiaohui@host1 ~]$ ln /tmp/folder1/lxhfile1 /home/lixiaohui/lxhtest
[lixiaohui@host1 ~]$ ls -li /home/lixiaohui/lxhtest /tmp/folder1/lxhfile1
268964355 -rw-r--r--. 2 lixiaohui lixiaohui 0 Feb  1 23:04 /home/lixiaohui/lxhtest
268964355 -rw-r--r--. 2 lixiaohui lixiaohui 0 Feb  1 23:04 /tmp/folder1/lxhfile1

```

## 创建软链接

ln 命令 -s 选项可创建符号链接，也称为“软链接”

软连接可以`跨设备`、也可以做`目录软链接`，但是每次做软链接都是创建了一个文的链接文件，类似于Windows中的快捷方式，软连接严重依赖源文件，当源文件被删除，链接文件就会失效

```bash
[lixiaohui@host1 ~]$ ll -i /tmp/folder1/lxhfile1
268964355 -rw-r--r--. 2 lixiaohui lixiaohui 0 Feb  1 23:04 /tmp/folder1/lxhfile1
[lixiaohui@host1 ~]$ echo source date > /tmp/folder1/lxhfile1

[lixiaohui@host1 ~]$ ln -s /tmp/folder1/lxhfile1 /home/lixiaohui/lxhsoft
[lixiaohui@host1 ~]$ ll -i /tmp/folder1/lxhfile1 /home/lixiaohui/lxhsoft
268965142 lrwxrwxrwx. 1 lixiaohui lixiaohui 21 Feb  1 23:11 /home/lixiaohui/lxhsoft -> /tmp/folder1/lxhfile1
268964355 -rw-r--r--. 2 lixiaohui lixiaohui 12 Feb  1 23:11 /tmp/folder1/lxhfile1

[lixiaohui@host1 ~]$ rm -rf /tmp/folder1/lxhfile1
[lixiaohui@host1 ~]$ ll -i /home/lixiaohui/lxhsoft
268965142 lrwxrwxrwx. 1 lixiaohui lixiaohui 21 Feb  1 23:11 /home/lixiaohui/lxhsoft -> /tmp/folder1/lxhfile1
[lixiaohui@host1 ~]$ cat /home/lixiaohui/lxhsoft
cat: /home/lixiaohui/lxhsoft: No such file or directory

```

## 使⽤ Shell 扩展匹配⽂件名

下⽅是 Bash shell 执⾏的主要扩展：
- ⼤括号扩展，可以⽣成多个字符串
- 波形符扩展，扩展⾄⽤⼾主⽬录路径
- 变量扩展，将⽂本替换为 shell 变量中存储的值
- 命令替换，将⽂本替换为命令的输出
- 路径名扩展，帮助按模式匹配选择⼀个或多个⽂件

路径名扩展以前称为通配，是 Bash 最有⽤的功能之⼀。

### 路径名扩展和模式匹配

```bash
[lixiaohui@host1 ~]$ mkdir glob; cd glob
[lixiaohui@host1 glob]$ touch alfa bravo charlie delta echo able baker cast dog easy
[lixiaohui@host1 glob]$ ls
able  alfa  baker  bravo  cast  charlie  delta  dog  easy  echo
[lixiaohui@host1 glob]$ ls a*
able  alfa
[lixiaohui@host1 glob]$ ls *a*
able  alfa  baker  bravo  cast  charlie  delta  easy
[lixiaohui@host1 glob]$ ls [ac]*
able  alfa  cast  charlie
[lixiaohui@host1 glob]$ ls ????
able  alfa  cast  easy  echo
[lixiaohui@host1 glob]$ ls ?????
baker  bravo  delta

```

### ⼤括号扩展

```bash
[lixiaohui@host1 glob]$ echo {Sunday,Monday,Tuesday,Wednesday}.log
Sunday.log Monday.log Tuesday.log Wednesday.log
[lixiaohui@host1 glob]$ echo file{1..3}.txt
file1.txt file2.txt file3.txt
[lixiaohui@host1 glob]$ echo file{a..c}.txt
filea.txt fileb.txt filec.txt
[lixiaohui@host1 glob]$  echo file{a,b}{1,2}.txt
filea1.txt filea2.txt fileb1.txt fileb2.txt
[lixiaohui@host1 glob]$  echo file{a{1,2},b,c}.txt
filea1.txt filea2.txt fileb.txt filec.txt
[lixiaohui@host1 glob]$ mkdir ../RHEL{7,8,9}
[lixiaohui@host1 glob]$ ls ../RHEL*
../RHEL7:

../RHEL8:

../RHEL9:

```

### 波形符扩展

```bash
[lixiaohui@host1 glob]$ echo ~root
/root
[lixiaohui@host1 glob]$ echo ~lixiaohui
/home/lixiaohui
[lixiaohui@host1 glob]$ echo ~nonexistinguser
~nonexistinguser
[lixiaohui@host1 glob]$ pwd
/home/lixiaohui/glob
[lixiaohui@host1 glob]$ cd ~/glob/

```

### 变量扩展

变量名称只能包含字⺟（⼤写和⼩写）、数字和下划线。变量名称区分⼤⼩写，不能以数字开头。

变量的赋值和引用

```bash
[lixiaohui@host1 glob]$ username=lixiaohui
[lixiaohui@host1 glob]$ echo $username
lixiaohui

```
要预防因其他 shell 扩展⽽引起的错误，可以将变量的名称放在⼤括号中

```bash
[lixiaohui@host1 glob]$ username=lixiaohui
[lixiaohui@host1 glob]$ echo ${username}
lixiaohui

```

### 命令替换

命令替换允许命令的输出替换命令⾏上的命令本⾝。当命令括在括号中并且前⾯有美元符号 `$` 时，会发⽣命令替换。$(command) 形式可以互相嵌套多个命令扩展。

```bash
[lixiaohui@host1 glob]$  echo Today is $(date +%A).
Today is Thursday.
[lixiaohui@host1 glob]$ echo The time is $(date +%M) minutes past $(date +%l%p).
The time is 25 minutes past 11PM.

```

### 防⽌参数被扩展

在 Bash shell 中，许多字符有特殊含义。为防⽌命令⾏的某些部分上执⾏ shell 扩展，可以为字符和字符串加引号或执⾏转义。反斜杠 `\` 是 Bash shell 中的转义字符。它可以防⽌其后的字符被扩展

```bash
[lixiaohui@host1 glob]$ echo The value of $HOME is your home directory.
The value of /home/lixiaohui is your home directory.
[lixiaohui@host1 glob]$ echo The value of \$HOME is your home directory.
The value of $HOME is your home directory.
[lixiaohui@host1 glob]$ myhost=$(hostname -s); echo $myhost
host1
[lixiaohui@host1 glob]$ echo "***** hostname is ${myhost} *****"
***** hostname is host1 *****
[lixiaohui@host1 glob]$ echo "Will variable $myhost evaluate to $(hostname -s)?"
Will variable host1 evaluate to host1?
[lixiaohui@host1 glob]$ echo 'Will variable $myhost evaluate to $(hostname -s)?'
Will variable $myhost evaluate to $(hostname -s)?

```

# 第四章 在红帽企业 Linux 中获取帮助

## 常规命令帮助

```bash
[lixiaohui@host1 ~]$ useradd --help
[lixiaohui@host1 ~]$ useradd -h

```

## Man 手册

本地系统上通常可⽤的⽂档来源之⼀是系统⼿册⻚或 man page。软件包随附这些⻚⾯来提供⽂档，可以使⽤ man 命令从命令⾏访问它们。⻚⾯存储在 /usr/share/man ⽬录的⼦⽬录中。

man page 源⾃过去的 Linux 程序员⼿册，该⼿册篇幅很⻓，⾜以划分为多个章节。每个章节包含有关特定主题的信息

|章节|内容类型|描述|
|-|-|-|
|1|⽤⼾命令|可执⾏命令和 shell 程序|
|2|系统调⽤|从⽤⼾空间调⽤的内核例程|
|3|库函数|由程序库提供|
|4|特殊⽂件|例如设备⽂件|
|5|⽂件格式|⽤于许多配置⽂件和结构|
|6|游戏和屏保|过去的趣味程序章节|
|7|惯例、标准和其他|协议和⽂件系统|
|8|系统管理和特权命令|维护任务|
|9|Linux 内核 API|内部内核调⽤|

查看帮助的方法：

我们注意到，不是所有的命令都有所有的章节，而且也不一定要输入章节数字，没有数字就进入默认章节

```bash
[lixiaohui@host1 ~]$ man 5 useradd
No manual entry for useradd in section 5
[lixiaohui@host1 ~]$ man passwd
[lixiaohui@host1 ~]$ man 5 passwd

```

man 手册非常长，可以考虑以下办法快速查看内容：

1. `up和down`： 向上或向下滚一屏

2. `上下键`： 向上或向下滚一行

3. `/string`： 搜索特定的内容

4. `n`：在搜索后输入小写的n，可以以锁定的关键字查找下一个匹配项

5. `N`：在搜索后输入大写的N，可以以锁定的关键字查找上一个匹配项

6. `g`: 小写的g可以回到第一屏

7. `G`：大写G可以去掉最后一屏

8. `q`： 退出man帮助


### 根据关键字搜索 man

使⽤ man 命令 -k 选项可在 man page 的标题和描述中搜索关键字

使⽤ man 命令 -K（⼤写）选项可在全⽂⻚⾯中搜索关键字，⽽不仅仅是在标题和描述中搜索

如果man -k或者man -K不返回结果，可以执行mandb命令执行更新索引

```bash
[root@host1 ~]# man -k passwd
chgpasswd (8)        - update group passwords in batch mode
chpasswd (8)         - update passwords in batch mode
fgetpwent_r (3)      - get passwd file entry reentrantly
getpwent_r (3)       - get passwd file entry reentrantly
gpasswd (1)          - administer /etc/group and /etc/gshadow
grub2-mkpasswd-pbkdf2 (1) - Generate a PBKDF2 password hash.
htpasswd (1)         - Manage user files for basic authentication
lpasswd (1)          - Change group or user password
openssl-passwd (1ossl) - compute password hashes
pam_localuser (8)    - require users to be listed in /etc/passwd

```

# 第五章 创建、查看和编辑⽂本⽂件

## 重定向、追加、管道

### 标准输⼊、标准输出和标准错误

从 shell 提⽰符运⾏命令时，通常会从键盘读取其输⼊，并将输出发送到终端窗⼝。

进程使⽤称为⽂件描述符的编号通道来获取输⼊并发送输出。所有进程在开始时⾄少要有三个⽂件描述符。标准输⼊（通道 0）从键盘读取输⼊。标准输出（通道 1）将正常输出发送到终端。标准错误（通道 2）将错误消息发送到终端。

### 重定向

通过重定向，可以将消息保存到⽂件或直接丢弃，⽽不在终端上显⽰输出

/dev/null是一个特殊设备，所有重定向到这里的内容，将不做保存和处理，直接丢弃

重定向将会清空文件原有内容，并插入新内容，文件不存在时，会创建出来

```bash
[lixiaohui@host1 ~]$ echo hello
hello
[lixiaohui@host1 ~]$ echo hello > file1
[lixiaohui@host1 ~]$ cat file1
hello
[lixiaohui@host1 ~]$ echo hello > /dev/null

```

### 追加

保留原有内容并在后方插入新内容

```bash
[lixiaohui@host1 ~]$ echo hello line2 >> file1
[lixiaohui@host1 ~]$ cat file1
hello
hello line2

```

### 处理错误输出

shell中的错误，在操作重定向时，将会把错误内容默认输出到屏幕，可以使用`2>`来单独重定向错误信息

```bash
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui > file1
ls: cannot access '/nolixiaohui': No such file or directory
[lixiaohui@host1 ~]$ cat file1
/home/lixiaohui/:
file1
glob
lxhsoft
lxhtest
RHEL7
RHEL8
RHEL9
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui 2> file1
/home/lixiaohui/:
file1  glob  lxhsoft  lxhtest  RHEL7  RHEL8  RHEL9
[lixiaohui@host1 ~]$ cat file1
ls: cannot access '/nolixiaohui': No such file or directory

```

### 分别保存正确和错误

```bash
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui > correct.txt 2> error.txt
[lixiaohui@host1 ~]$ cat correct.txt
/home/lixiaohui/:
correct.txt
error.txt
file1
glob
lxhsoft
lxhtest
RHEL7
RHEL8
RHEL9
[lixiaohui@host1 ~]$ cat error.txt
ls: cannot access '/nolixiaohui': No such file or directory

```

### 正确和错误合并处理

```bash
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui
ls: cannot access '/nolixiaohui': No such file or directory
/home/lixiaohui/:
file1  glob  lxhsoft  lxhtest  RHEL7  RHEL8  RHEL9
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui > correct.txt
ls: cannot access '/nolixiaohui': No such file or directory
[lixiaohui@host1 ~]$ cat correct.txt
/home/lixiaohui/:
correct.txt
file1
glob
lxhsoft
lxhtest
RHEL7
RHEL8
RHEL9
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui 2> correct.txt
/home/lixiaohui/:
correct.txt  file1  glob  lxhsoft  lxhtest  RHEL7  RHEL8  RHEL9
[lixiaohui@host1 ~]$ cat correct.txt
ls: cannot access '/nolixiaohui': No such file or directory
[lixiaohui@host1 ~]$ ls /home/lixiaohui/ /nolixiaohui &> correct.txt
[lixiaohui@host1 ~]$ cat correct.txt
ls: cannot access '/nolixiaohui': No such file or directory
/home/lixiaohui/:
correct.txt
file1
glob
lxhsoft
lxhtest
RHEL7
RHEL8
RHEL9
```

### 构建管道

管道是⼀个或多个命令的序列，⽤竖线字符 (|) 分隔。管道将第⼀个命令的标准输出连接到下⼀个命令的标准输⼊。

计算文件一共有几行

wc -l 需要一系列内容才能计算内容一共有几行，wc 命令所需要的内容由管道将管道前命令的输出提供
```bash
[lixiaohui@host1 ~]$ cat /etc/passwd | wc -l
45

```

### tee 命令

重定向和追加有一个被迫选择的问题，要不输出到屏幕，要不输出到文件，而tee可以做到同时输出到文件和屏幕

```bash
[lixiaohui@host1 ~]$ echo hello > file1
[lixiaohui@host1 ~]$ echo hello | tee file1
hello
[lixiaohui@host1 ~]$ echo hello world | tee -a file1
hello world
[lixiaohui@host1 ~]$ cat file1
hello
hello world

```

## 使⽤ Vim 编辑⽂件

Linux上一般都会自带vi命令，而vim是vi的增强版，有语法高亮等高级特性，需要按照`vim-enhanced`软件包，安装好软件包之后，uid 大于 200的用户使用vi命令时，会自动调用vim命令实现高级特性，vi和vim是别名关系

### vim 模式

vim 编辑器有4个模式

1. 命令模式

```bash
[lixiaohui@host1 ~]$ vim file1 #回车后会进入命令模式
```

2. 编辑模式

在命令模式中可以输入各种命令，其中包括

> 1. 直接按下小写的`i`，会原地进入编辑模式
> 2. 编辑完成后按`esc`回到命令模式

3. 扩展命令模式

> 1. 输入`:q!` 可以不保存并退出文件
> 2. 输入`:wq` 可以保存并退出

4. 可视模式

> 1. 按下`esc`进入命令模式
> 2. 按下`v` 进入可视模式，按下上下左右键移动
> 3. 按下`Shift V`可以多行选择，按下上下左右键移动
> 4. 按下`Ctrl V`可以做文本块选择，按下上下左右键移动

### vim 基本命令


```bash
[lixiaohui@host1 ~]$ cp /etc/passwd /tmp/passwd
[lixiaohui@host1 ~]$ vim /tmp/passwd
```

先进入到具体有内容的文件中，执行以下命令：


1. `yy` 复制光标所在行
2. `p` 在光标所在行下方插入刚复制的内容
3. `x` 删除光标所在的单个字符
4. `dd` 删除光标所在行
5. `3dd` 删除包括光标所在行的向下3行
6. `3,5y` 复制第3到第5行
7. `3,5d` 删除第3到第5行
8. `/lixiaohui` 快速搜索lixiaohui字符串
9. `n`或`N`，搜索到之后，向下或向上查找
10. `u` 撤销你刚才修改的内容
11. `ctrl r` 撤销你刚才撤销的动作，也就是说把刚才撤销的东西再找回来
12. `:w` 只保存不退出
13. `:q!` 只退出不保存
14. `set nu` 显示行号
15. `set nonu` 取消行号显示

## 更改 Shell 环境

变量名称可以包含⼤写或⼩写字⺟、数字和下划线字符 (_)，但是不要数字开头

变量赋值与取消

```bash
[lixiaohui@host1 ~]$ username=lixiaohui
[lixiaohui@host1 ~]$ unset username

```

列出所有常规变量

```bash
[lixiaohui@host1 ~]$ set
BASH=/bin/bash
BASHOPTS=checkwinsize:cmdhist:complete_fullquote:expand_aliases:extglob:extquote:force_fignore:globasciiranges:histappend:interactive_comments:login_shell:progcomp:p
romptvars:sourcepath
BASHRCSOURCED=Y
BASH_ALIASES=()

```
将变量导出为环境变量以便于所有的shell会话都可以访问

```bash
[lixiaohui@host1 ~]$ username=lixiaohui
[lixiaohui@host1 ~]$ echo $username
lixiaohui
[lixiaohui@host1 ~]$ bash
[lixiaohui@host1 ~]$ echo $username

[lixiaohui@host1 ~]$ username=lixiaohui
[lixiaohui@host1 ~]$ export username=lixiaohui
[lixiaohui@host1 ~]$ bash
[lixiaohui@host1 ~]$ echo $username
lixiaohui

```

列出所有环境变量

```bash
[lixiaohui@host1 ~]$ env
```

**自动设置变量**

用等于号设置变量的方法在会话断开重连之后会失效，可以考虑放入文件中做持久化，/etc中的文件影响整个系统

1. /etc/profile
2. ~/.bash_profile
3. /etc/bashrc
4. ~/.bashrc

若要调整作⽤于所有⽤⼾帐⼾的设置，最佳⽅式是带有 .sh 扩展名的⽂件，并放入/etc/profile.d ⽬录

**Bash 别名**

将别名添加到⽤⼾的 ~/.bashrc ⽂件中，以便它们在任何交互式 shell 中可⽤。

```bash
[lixiaohui@host1 ~]$ alias lxh='echo lixiaohui'
[lixiaohui@host1 ~]$ lxh
lixiaohui

```
取消别名

```bash
[lixiaohui@host1 ~]$ alias lxh='echo lixiaohui'
[lixiaohui@host1 ~]$ lxh
lixiaohui
[lixiaohui@host1 ~]$ unalias lxh
[lixiaohui@host1 ~]$ lxh
bash: lxh: command not found...

```

# 第六章 管理本地⽤⼾和组

## 用户类型

1. **超级⽤⼾**

超级⽤⼾的名称为 root，其帐⼾的 UID 为 0，拥有所有权限

2. **系统⽤⼾**

系统⽤⼾帐⼾供提供⽀持服务进程使⽤，一般不具有特权，⽤⼾⽆法使⽤系统⽤⼾帐⼾以交互⽅式登录

3. **普通⽤⼾**

⼤多数⽤⼾都有⽤于处理⽇常⼯作的普通⽤⼾帐⼾，也不具有特权

文件和进程都属于某一用户，用来配合权限工作

```bash
[lixiaohui@host1 ~]$ id root
uid=0(root) gid=0(root) groups=0(root)
[lixiaohui@host1 ~]$ id lixiaohui
uid=1001(lixiaohui) gid=1001(lixiaohui) groups=1001(lixiaohui)
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ ll /readme.txt
-rw-r--r--. 1 root root 105 Nov 10 05:33 /readme.txt

[lixiaohui@host1 ~]$ ps aux | more
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  1.2  0.1 172312 16612 ?        Ss   00:52   0:01 /usr/lib/systemd/systemd rhgb
root           2  0.0  0.0      0     0 ?        S    00:52   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   00:52   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   00:52   0:00 [rcu_par_gp]

```

## 用户文件/etc/passwd

系统使⽤ `/etc/passwd` ⽂件存储有关本地⽤⼾的信息，该⽂件划分为七个以冒号分隔的字段

```bash
[lixiaohui@host1 ~]$ cat /etc/passwd
lixiaohui:x:1001:1001:Lxh:/home/lixiaohui:/bin/bash
```

- `lixiaohui` ：此⽤⼾的⽤⼾名。
- `x` ：⽤⼾的加密密码历来存储在这⾥，这现在是⼀个占位符。
- `1001` ：此⽤⼾帐⼾的 UID 编号。
- `1001` ：此⽤⼾帐⼾的主要组的 GID 编号。
- `Lxh` ：此⽤⼾的简短注释、描述或真实姓名。
- `/home/lixiaohui` ：⽤⼾的主⽬录，以及登录 shell 启动时的初始⼯作⽬录。
- `/bin/bash` ：此⽤⼾的默认 shell 程序，在登录时运⾏。⼀些帐⼾使⽤ /sbin/nologin shell
来禁⽌使⽤该帐⼾进⾏交互式登录。

## 组文件/etc/group

系统使⽤ `/etc/group` ⽂件存储有关本地组的信息，每个组条⽬被分为四个以冒号分隔的字段

```bash
[lixiaohui@host1 ~]$ cat /etc/group
lixiaohui:x:1001::user01,user02,user03
```

- `lixiaohui` ：此组的名称。
- `x` ：以前的组密码字段，现在是⼀个占位符。
- `10000` ：此组的 GID 编号 (1001)。
- `user01,user02,user03` ：属于此组成员的⽤⼾列表，作为⼀个补充组

## 主要组和补充组

**主要组**

每个⽤⼾有且`只有⼀个主要组`，在创建普通⽤⼾时，会创建⼀个`与⽤⼾同名的组`，作为该⽤⼾的主要组，该⽤⼾是这个`⽤⼾私有组`的唯⼀成员

```text
我入职了IT部门，我的主要职责是IT服务，lixiaohui用户在Linux上被创建的时候会同步创建lixiaohui的组，所以我的主要组或私有组是lixiaohui
```

**补充组**

补充组中的成员资格存储在 `/etc/group` ⽂件中。根据所在的组是否具有访问权限，将授予⽤⼾对⽂件的访问权限，不论这些组是主要组还是补充组

```text
我是IT部的人，所以我同时属于我的私有组lixiaohui，也属于IT部门，还属于公司全员
```

此时权限的分配变得简单，只需要分配到IT部门，我就会获得权限

## 获取超级用户访问权限

Linux 上的 `root 帐⼾`类似于 Microsoft Windows 上的本地 `Administrator` 帐⼾，。⼀旦 root ⽤⼾帐⼾被盗，系统将处于危险之中，所以我们不给用户超级用户权限，但是有时候一部分特权工作需要用户完成，例如HR需要执行useradd创建用户，此时HR将会用到下方的切换用户的方法

### su 直接切换身份

使用su - USERNAME的方法切换到目标用户身份下，普通用户的切换需要提供目标密码，而root用户切换到其他用户时无需密码

如果su后面省略⽤⼾名，则默认情况下会尝试切换到 root

```bash
[lixiaohui@host1 ~]$ su - lxh
Password:
[root@host1 ~]# su - lxh
Last login: Mon Feb  5 01:12:31 CST 2024 on pts/0
[lxh@host1 ~]$ su - root
Password:
Last login: Mon Feb  5 00:53:52 CST 2024 from 172.25.254.1 on pts/0

```

### su 与 su -

su命令后面也可以不写中横杠，区别如下：

1. su 命令将启动⾮登录 shell，su 以该⽤⼾⾝份启动shell，但使⽤的是原始⽤⼾的环境设置

2. su - 命令会启动登录 shell，会将 shell 环境设置为如同以该⽤⼾⾝份重新登录⼀样

一般来说，管理员应该运⾏ su - 以获得包含⽬标⽤⼾常规环境设置的 shell

```bash
[lxh@host1 ~]$ su root
Password:
[root@host1 lxh]# ls
[root@host1 lxh]# pwd
/home/lxh
[root@host1 lxh]# exit
exit

[lxh@host1 ~]$ su - root
Password:
Last login: Mon Feb  5 01:18:34 CST 2024 on pts/0
[root@host1 ~]# pwd
/root
[root@host1 ~]# ls
anaconda-ks.cfg
```

### 通过sudo 获得权限

su的命令要求你必须输入对方的密码，这是很不方便的，尤其是root密码不应该轻易共享，此时sudo就可以派上用场了

与 su 命令不同，sudo 通常要求⽤⼾输⼊⾃⼰的密码以进⾏⾝份验证，⽽不是输⼊他们正尝试访问的⽤⼾帐⼾的密码。也就是说，⽤⼾使⽤ sudo 命令以 root ⾝份运⾏命令时，不需要知道 root 密码。

**需要注意的是，系统默认授予了wheel组可以用sudo运行所有命令的权限**

**su、su - 和 sudo 命令之间的区别**

![su-su--sudo](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/su-su-sudo.png)

普通用户不具有用户创建权限

```bash
[lixiaohui@host1 ~]$ useradd zhangsan
useradd: Permission denied.
useradd: cannot lock /etc/passwd; try again later.

```

用root权限，授予`lixiaohui用户`可以创建用户和删除用户权限

先查询用户创建和删除的命令位置

```bash
[root@host1 ~]# which useradd
/usr/sbin/useradd
[root@host1 ~]# which userdel
/usr/sbin/userdel

```

**sudo 授权**

以下授权允许`lixiaohui用户`可以sudo运行useradd和userdel命令，但是不允许用sudo的方式运行ls命令

**手工修改此文件有语法错误的可能性，可以使用 `visudo` 命令去自动打开此文件修改，保存时，会去验证是否正确**

**如果不想修改主配置文件，可以修改`/etc/sudoers.d`路径下的文件，新建一个文件放进来即可**

```bash
[root@host1 ~]# vim /etc/sudoers
[root@host1 ~]# tail -n 1 /etc/sudoers
lixiaohui    ALL=(ALL)       /usr/sbin/useradd,/usr/sbin/userdel,!/bin/ls

```

以下授权允许`lixiaohui用户`可以sudo运行所有命令，且`不需要密码`

```bash
[root@host1 ~]# vim /etc/sudoers
[root@host1 ~]# tail -n 1 /etc/sudoers
lixiaohui       ALL=(ALL)       NOPASSWD: ALL

```
在配置了允许用户执行所有命令后，用户就可以执行 `sudo -i`来切换到超级用户身份执行命令了

以下授权允许`lxhgroup 组`可以sudo运行所有命令，且不需要密码

```bash
[root@host1 ~]# vim /etc/sudoers
[root@host1 ~]# tail -n 1 /etc/sudoers
@lxhgroup       ALL=(ALL)       NOPASSWD: ALL

```

**测试权限**

我们注意，在userdel时失败了一次，因为没有sudo命令开始，不经过我们的授权验证

```bash
[root@host1 ~]# su - lixiaohui
Last login: Mon Feb  5 01:25:52 CST 2024 on pts/0
[lixiaohui@host1 ~]$ sudo useradd zhangsan
...
[sudo] password for lixiaohui:

[lixiaohui@host1 ~]$ tail -n 1 /etc/passwd
zhangsan:x:1003:1003::/home/zhangsan:/bin/bash

[lixiaohui@host1 ~]$ userdel -r zhangsan
userdel: Permission denied.
userdel: cannot lock /etc/passwd; try again later.

[lixiaohui@host1 ~]$ sudo userdel -r zhangsan
[lixiaohui@host1 ~]$ tail -n 1 /etc/passwd
lxh:x:1002:1002::/home/lxh:/bin/bash

[lixiaohui@host1 ~]$ sudo ls
Sorry, user lixiaohui is not allowed to execute '/bin/ls' as root on host1.

```

## 管理本地⽤⼾

### 创建⽤⼾

默认会创建用户的家目录，将/bin/bash设置为用户shell，UID和GID从/etc/login.defs中获取，默认创建的第一个用户UID是1000

1. `-u`指定UID

2. `-s`指定shell，其中/sbin/nologin未不允许用户登录，但程序可以本地使用此用户

3. `-G`指定辅助组

4. `-g`执行主要组

```bash
[root@host1 ~]# useradd lixiaohui
[root@host1 ~]# grep lixiaohui /etc/passwd
lixiaohui:x:1001:1001::/home/lixiaohui:/bin/bash
[root@host1 ~]# ls -d /home/lixiaohui/
/home/lixiaohui/

[root@host1 ~]# useradd -u 2000 lxh -s /sbin/nologin
[root@host1 ~]# grep lxh /etc/passwd
lxh:x:2000:2000::/home/lxh:/sbin/nologin
[root@host1 ~]# su - lxh
This account is currently not available.

[root@host1 ~]# useradd -G group1 laoli
[root@host1 ~]# id laoli
uid=2001(laoli) gid=2003(laoli) groups=2003(laoli),2001(group1)
[root@host1 ~]# useradd -g group2 laozhang
[root@host1 ~]# id laozhang
uid=2002(laozhang) gid=2002(group2) groups=2002(group2)

```

### 修改用户

`usermod` 可以修改用户信息，其中

1. -a和-G 组合使用可以将用户添加到辅助组，而不从现有组中踢出此用户

只使用-G，会将用户从其他组中踢出

```bash
[root@host1 ~]# id lixiaohui
uid=1001(lixiaohui) gid=1001(lixiaohui) groups=1001(lixiaohui),2004(group3)
[root@host1 ~]# usermod -G group1 lixiaohui
[root@host1 ~]# id lixiaohui
uid=1001(lixiaohui) gid=1001(lixiaohui) groups=1001(lixiaohui),2001(group1)

```

组合使用，可以叠加多个组

```bash
[root@host1 ~]# id lixiaohui
uid=1001(lixiaohui) gid=1001(lixiaohui) groups=1001(lixiaohui),2001(group1)
[root@host1 ~]# usermod -aG group2 lixiaohui
[root@host1 ~]# id lixiaohui
uid=1001(lixiaohui) gid=1001(lixiaohui) groups=1001(lixiaohui),2001(group1),2002(group2)

```

2. -g 修改用户主要组

```bash
[root@host1 ~]# usermod -g group2 lixiaohui
[root@host1 ~]# id lixiaohui
uid=1001(lixiaohui) gid=2002(group2) groups=2002(group2),2001(group1)
```

3. 锁定用户不允许登录

```bash
[root@host1 ~]# usermod -L lixiaohui

```

4. 恢复用户登录

```bash
[root@host1 ~]# usermod -U lixiaohui

```

5. -s 修改登录的登录shell

/sbin/nolgin和/bin/false都是拒绝用户交互式登录的shell，/sbin/nologin更友好，因为它会提示因为什么拒绝

```bash
[root@host1 ~]# usermod -s /sbin/nologin lixiaohui

```

### 删除用户

`userdel` 可以删除用户，以下是注意事项：

1. 如果是暂时禁用用户，请使用usermod -L 锁定

2. 如果确定要删除用户，而且不想删除用户的家目录资料，可以执行`userdel USERNAME`

3. 如果确定要删除用户，而且连带用户家目录资料同步删除，可以执行`userdel -r USERNAME`

### 设置用户密码

`passwd`可以给用户设置密码

普通用户不允许在passwd后面加用户名，只能给自己设置，root用户可以在passwd后面加用户名给别人设置密码

```bash
[root@host1 ~]# passwd lixiaohui
[lixiaohui@host1 ~]$ passwd laoli
passwd: Only root can specify a user name.

```

## 管理本地组帐⼾

### 创建本地组

`groupadd `可以创建本地组，默认从/etc/login.defs中获取GID的范围，也可以在创建时指定-g来设置GID，-r 创建系统组

### 修改本地组

`groupmod` 命令可更改现有组的属性。groupmod 命令 -n 选项可指定组的新名称

### 删除本地组

`groupdel` 命令可删除组

## 管理⽤⼾密码

### /etc/shadow

加密后的哈希密码在 `/etc/shadow` ⽂件，只有 root ⽤⼾可以读取该⽂件， /etc/shadow ⽂件中具有九个以冒号分隔的字段：

```bash
[root@host1 ~]# tail -n 1 /etc/shadow
lixiaohui:!$6$n.2VAv1m5Y6IL1nN$uYKLCz1acTzn6yyjrCzK5nbuu2viRuLWqZEgrP1QG8YyUICH6rzSg7qgobT.GFTfXUIfYd7FD9rgHslWRal9M1:19758:1:30:7:31:19773:

```

- `lixiaohui` ：⽤⼾帐⼾的名称。
- `$6$n.2VAv1m5Y6IL1n` ：⽤⼾的加密哈希密码。
- `19758` ：上次更改密码时间距离纪元的天数；其中，纪元是 UTC 时区的 1970-01-01。
- `1` ：⾃上次更改密码以来到⽤⼾可再次更改密码之前必须经过的最短天数。
- `30` ：在密码过期之前不进⾏密码更改的最⻓天数。空字段表⽰密码永不过期。
- `7` ：在⽤⼾密码过期前提前多少天警告⽤⼾。
- `31 `：⾃密码过期之⽇起，在帐⼾⾃动锁定之前能够⽆活动的天数。
- `19773` ：密码到期之⽇距离纪元的天数。空字段表⽰密码永不过期。
- `最后⼀个字段`通常为空，预留给未来使⽤

### 加密哈希密码的格式

```text
$6$CSsXcYG1L/4ZfHr/$2W6evvJahUfzfHpc9X.45Jc6H30E
```
加密哈希密码字段中存储了三段信息：

1. 所⽤的哈希算法，6 表⽰ SHA-512 哈希，这是 RHEL 9 的默认算法；1 表⽰ MD5，⽽ 5则表⽰ SHA-256
2. salt，CSsXcYG1L/4ZfHr/
3. 加密哈希值，2W6evvJahUfzfHpc9X.45Jc6H30E

salt 添加随机数据到加密哈希，以创建唯⼀哈希来增强加密哈希密码。每段信息由美元符号 ($) 字符分隔

### 配置密码期限

![chage](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/chage.png)

1. 让用户于2024-03-01日过期

```bash
[root@host1 ~]# chage -E 2024-03-01 lixiaohui
```
2. 用户下次登陆前必须改密码

```bash
[root@host1 ~]#  chage -d 0 lixiaohui
```

# 控制对⽂件的访问

## Linux ⽂件系统权限概述

⽂件具有三个应⽤权限的⽤⼾类别。⽂件归某个⽤⼾所有，通常是⽂件的创建者。⽂件还归单个组所有，通常是创建该⽂件的⽤⼾的主要组，但是可以进⾏更改。

权限承载的主体有：

1. 所属⽤⼾（⽤⼾权限）

2. 所属组（组权限）系统上

3. ⾮所属⽤⼾和⾮所属组成员的所有其他⽤⼾（其他权限）

**最具体的权限具有优先权。用户权限覆盖组权限，后者⼜覆盖其他权限**

## 权限对⽂件和⽬录的影响

![permission-rwx](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/permission-rwx.png)

## 查看权限

看出不管是文件还是目录，都归当前用户以及当前用户组所有

```bash
[lixiaohui@host1 ~]$ touch lxhfile
[lixiaohui@host1 ~]$ mkdir lxhfolder
[lixiaohui@host1 ~]$ ll
total 0
-rw-r--r--. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile
drwxr-xr-x. 2 lixiaohui lixiaohui 6 Feb  5 23:49 lxhfolder

```

**文件类型**

ll 命令是ls -l的缩写，以下命令输出中第一个字母d代表这次的输出是文件夹

```bash
[lixiaohui@host1 ~]$ ll -d lxhfolder
drwxr-xr-x. 2 lixiaohui lixiaohui 6 Feb  5 23:49 lxhfolder

```

第一个字母还可以是以下的字母：

- `-`  是常规⽂件。
- `d`  是⽬录。
- `l`  是符号链接。
- `c`  是字符设备⽂件。
- `b`  是块设备⽂件。
- `p`  是命名管道⽂件。
- `s`  是本地套接字⽂件

**权限解释**

九个字符代表⽂件权限。这些字符解释为三组，每组三个字符：第⼀组是适⽤于⽂件所有者的权限，第⼆组⽤于⽂件的组所有者，最后⼀组则适⽤于所有其他（全局）⽤⼾

```bash
[lixiaohui@host1 ~]$ ll -d lxhfolder
drwxr-xr-x. 2 lixiaohui lixiaohui 6 Feb  5 23:49 lxhfolder

```

1. `d` ，代表文件类型
2. `rwx`，第一组三位字符是指此文件所属用户的权限为读、写、执行
3. `r-x`，第二组三位字符是指此文件所属组的权限为读、执行
4. `r-x`，第三组三位字符是指非所属用户和所属组的其他所有人的权限为读、执行
5. `.`，这代表常规已经显示完毕，如果写的是`+`，代表还有额外的acl权限
6. `2`，这代表文件的链接数量，每个目录的链接数最起码是2，指向自身(.)或上级(..)
7. `lixiaohui`，第一个`lixiaohui`是指此文件夹被`lixiaohui用户`所拥有
8. `lixiaohui`，第二个`lixiaohui`是指此文件夹被`lixiaohui组`所拥有

## 更改⽂件和⽬录权限


### 通过符号法更改权限
chmod 命令具有以下特性：可从命令⾏更改⽂件和⽬录权限。这可以解释为“更改模式”，因为⽂件的模式是⽂件权限的另⼀个名称

使⽤ chmod 命令修改⽂件和⽬录权限的格式如下：

```bash
chmod Who/What/Which file|directory
```

who 代表用户主体，可以是：

|who|主体|
|-|-|
|u|user|
|g|group|
|o|other|
|a|all|

what 代表从文件身上添加还是删除权限

|what|操作|
|-|-|
|+|添加|
|-|删除|
|=|等于|

which 代表具体的权限

|which|权限或模式|备注|
|-|-|-|
|r|读|-|
|w|写|-|
|x|执行|对于目录而言，必须要有x权限，不然无法进入|
|X|特殊的执行权限|仅仅给这个目录添加执行权限，而不影响下级文件的执行权限|


```bash
[lixiaohui@host1 ~]$ ll -d lxhfolder
drwxr-xr-x. 2 lixiaohui lixiaohui 6 Feb  5 23:49 lxhfolder
[lixiaohui@host1 ~]$ chmod go-rw lxhfile
[lixiaohui@host1 ~]$ ll lxhfile
-rw-------. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile
[lixiaohui@host1 ~]$ chmod a+x lxhfile
[lixiaohui@host1 ~]$ ll lxhfile
-rwx--x--x. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile
[lixiaohui@host1 ~]$ chmod a=rw lxhfile
[lixiaohui@host1 ~]$ ll lxhfile
-rw-rw-rw-. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile

```

可以使⽤ chmod 命令 -R 选项，以递归⽅式对整个⽬录树中的⽂件设置权限

```bash
[root@host1 ~]# mkdir folder1
[root@host1 ~]# touch folder1/file{1..10}
[root@host1 ~]# ll folder1
total 0
-rw-r--r--. 1 root root 0 Feb  6 00:15 file1
-rw-r--r--. 1 root root 0 Feb  6 00:15 file10
-rw-r--r--. 1 root root 0 Feb  6 00:15 file2
-rw-r--r--. 1 root root 0 Feb  6 00:15 file3
-rw-r--r--. 1 root root 0 Feb  6 00:15 file4
-rw-r--r--. 1 root root 0 Feb  6 00:15 file5
-rw-r--r--. 1 root root 0 Feb  6 00:15 file6
-rw-r--r--. 1 root root 0 Feb  6 00:15 file7
-rw-r--r--. 1 root root 0 Feb  6 00:15 file8
-rw-r--r--. 1 root root 0 Feb  6 00:15 file9
[root@host1 ~]# chmod -R a+wx folder1
[root@host1 ~]# ll folder1
total 0
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file1
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file10
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file2
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file3
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file4
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file5
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file6
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file7
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file8
-rwxrwxrwx. 1 root root 0 Feb  6 00:15 file9

```

### 通过⼋进制法更改权限

可以使⽤ chmod 命令，通过⼋进制法（⽽⾮符号法）来更改⽂件权限，具体格式：

```text
chmod ### file|directory
```

以上的三个#号是数字，每个数字分别代表用户、组、其他人，单个⼋进制数字可以表⽰ 0-7 的任何单个值，7代表最高所有权限都有

- `0`，没有权限
- `1`，执行权限
- `2`，写入权限
- `3`，写入和执行(1+2)
- `4`，读取权限
- `5`，执行和读取(1+4)
- `6`，写入和读取(2+4)
- `7`，写入和读取和执行(1+2+4)

```bash
[lixiaohui@host1 ~]$ ll
total 0
-rw-rw-rw-. 1 lixiaohui lixiaohui   0 Feb  5 23:49 lxhfile
drw-rw-rw-. 2 lixiaohui lixiaohui 137 Feb  6 00:12 lxhfolder
[lixiaohui@host1 ~]$ chmod 123 lxhfile
[lixiaohui@host1 ~]$ ll lxhfile
---x-w--wx. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile
[lixiaohui@host1 ~]$ chmod 456 lxhfile
[lixiaohui@host1 ~]$ ll lxhfile
-r--r-xrw-. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile
[lixiaohui@host1 ~]$ chmod 777 lxhfile
[lixiaohui@host1 ~]$ ll lxhfile
-rwxrwxrwx. 1 lixiaohui lixiaohui 0 Feb  5 23:49 lxhfile

```

## 更改文件或目录所有权

⽤⼾以及用户的私有组拥有其创建的⽂件，但是也可以用chown或chgrp来更改，这两个命令都可以用-R参数对文件夹进行递归修改，也就是对文件夹里的文件同步生效的意思

**只更改文件的拥有人**

将lxhfile2的拥有人改为laoli

```bash
[root@host1 ~]# touch lxhfile2
[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 root root 0 Feb  6 00:24 lxhfile2
[root@host1 ~]# chown laoli lxhfile2
[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 laoli root 0 Feb  6 00:24 lxhfile2

```

**只更改文件的所属组**

```bash
[root@host1 ~]# chown :lixiaohui lxhfile2
[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 laoli lixiaohui 0 Feb  6 00:24 lxhfile2

[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 laoli lixiaohui 0 Feb  6 00:24 lxhfile2
[root@host1 ~]#
[root@host1 ~]# chgrp root lxhfile2
[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 laoli root 0 Feb  6 00:24 lxhfile2

```

**同时更改文件的拥有人和所属组**

```bash
[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 laoli root 0 Feb  6 00:24 lxhfile2
[root@host1 ~]# chown lixiaohui:group1 lxhfile2
[root@host1 ~]# ll lxhfile2
-rw-r--r--. 1 lixiaohui group1 0 Feb  6 00:24 lxhfile2

```

## 管理默认权限和文件访问

### 特殊权限

特殊权限是除了⽤⼾、组和其他类型之外的第四种权限类型，所有的特殊权限都要求相应的权限主体有执行权限，如果没有执行权限，所有的特殊权限都会以大写的方式警告此权限无法生效

1. suid，chmod中的数字修改法中，用4表示
2. sgid，chmod中的数字修改法中，用2表示
3. sticky，，chmod中的数字修改法中，用1表示

```bash
[root@host1 ~]# chmod 1777 folder
```

|权限|对文件的影响|对⽬录的影响|
|-|-|-|
|u+s (suid)|以拥有⽂件的⽤⼾⾝份，⽽不是以运⾏⽂件的⽤⼾⾝份执⾏⽂件|⽆影响|
|g+s (sgid)|以拥有⽂件的组⾝份执⾏⽂件|⽬录中创建的⽂件的组所有者与⽬录的组所有者相匹配|
|o+t (sticky)|⽆影响|对⽬录具有写⼊访问权限的⽤⼾仅可以删除其所拥有的⽂件，⽽⽆法删除或强制保存到其他⽤⼾所拥有的⽂件|

**SUID**

这出现在程序或脚本场景中，不管谁执行程序，都以程序文件所属的用户身份和权限执行，而不是执行人的身份和权限

我们发现所有人对密码文件都没有修改权限，而root由于是特殊的超级管理员，只有root用户可以修改

```bash
[root@host1 ~]# ll /etc/shadow
----------. 1 root root 1433 Feb  6 00:23 /etc/shadow

```
/bin/passwd是用来改密码的，此程序已经被执行了`chmod u+s /bin/passwd`，所以用户权限上有一个小写的s，这就意味着所有人执行/bin/passwd时，都以root用户身份和权限修改/etc/shadow，所以才能改密码

```bash
[root@host1 ~]# ll /bin/passwd
-rwsr-xr-x. 1 root root 32648 Aug 10  2021 /bin/passwd

```

**SGID**

这出现在文件夹的场景下，我们要求不管谁向特定的文件夹写入文件，新产生的文件要自动归属于特定的组拥有，例如root用户写的代码必须自动归属于group1这个组

```bash
[root@host1 ~]# mkdir /lxh-sgid-folder
[root@host1 ~]# ll -d /lxh-sgid-folder
drwxr-xr-x. 2 root root 6 Feb  6 00:37 /lxh-sgid-folder
[root@host1 ~]# chmod a+w /lxh-sgid-folder
[root@host1 ~]# ll -d /lxh-sgid-folder
drwxrwxrwx. 2 root root 6 Feb  6 00:37 /lxh-sgid-folder
[root@host1 ~]# chgrp group1 /lxh-sgid-folder
[root@host1 ~]# ll -d /lxh-sgid-folder
drwxrwxrwx. 2 root group1 6 Feb  6 00:37 /lxh-sgid-folder

[root@host1 ~]# chmod g+s /lxh-sgid-folder/
[root@host1 ~]# ll -d /lxh-sgid-folder/
drwxrwsrwx. 2 root group1 6 Feb  6 00:38 /lxh-sgid-folder/
[root@host1 ~]# touch /lxh-sgid-folder/rootwrite
[root@host1 ~]# ll /lxh-sgid-folder/rootwrite
-rw-r--r--. 1 root group1 0 Feb  6 00:38 /lxh-sgid-folder/rootwrite

```

**sticky 权限**

这出现在公共目录使用场景，要求人们只能管理和删除自己的文件，删除别人的文件会报告`Operation not permitted`

```bash
[root@host1 ~]# mkdir /lxh-sticky
[root@host1 ~]# chmod 777 /lxh-sticky
[root@host1 ~]# ll -d /lxh-sticky
drwxrwxrwx. 2 root root 6 Feb  6 00:44 /lxh-sticky
[root@host1 ~]# chmod o+t /lxh-sticky
[root@host1 ~]# ll -d /lxh-sticky
drwxrwxrwt. 2 root root 6 Feb  6 00:44 /lxh-sticky
[root@host1 ~]# touch /lxh-sticky/rootfile
[root@host1 ~]# su - lixiaohui
Last login: Tue Feb  6 00:23:40 CST 2024 on pts/0
[lixiaohui@host1 ~]$ touch /lxh-sticky/lixiaohuifile
[lixiaohui@host1 ~]$ ll /lxh-sticky/
total 0
-rw-r--r--. 1 lixiaohui lixiaohui 0 Feb  6 00:45 lixiaohuifile
-rw-r--r--. 1 root      root      0 Feb  6 00:44 rootfile
[lixiaohui@host1 ~]$ rm -rf /lxh-sticky/*
rm: cannot remove '/lxh-sticky/rootfile': Operation not permitted
[lixiaohui@host1 ~]$ ll /lxh-sticky/
total 0
-rw-r--r--. 1 root root 0 Feb  6 00:44 rootfile

```

### 默认⽂件权限

在创建时，⽂件被分配初始权限。有两个因素会影响这些初始权限。其⼀是您要创建常规⽂件还是⽬录。其⼆是当前的 umask，它代表⽤⼾⽂件创建掩码

如果创建⽬录，则其初始⼋进制权限为 0777 (drwxrwxrwx)。如果您创建常规⽂件，则其初始⼋进制权限为 0666 (-rw-rw-rw-)，umask是从以上权限数字中，减去特定的数字，最终得到权限

如果umask是0022，那么文件夹默认权限是0755，文件权限是0644

```bash
[root@host1 ~]# umask
0022
[root@host1 ~]# umask -p
umask 0022
[root@host1 ~]# umask -S
u=rwx,g=rx,o=rx
[root@host1 ~]# mkdir foldertest
[root@host1 ~]# touch filetest
[root@host1 ~]# ll -d foldertest/ filetest
-rw-r--r--. 1 root root 0 Feb  6 00:49 filetest
drwxr-xr-x. 2 root root 6 Feb  6 00:49 foldertest/

```

**修改umask值**

你可以在命令行中输入umask xxxx回车，但是这只有临时生效，你可以放入家目录中的`.bashrc`只影响自己一个人，也可以把`umask xxxx`这个内容放入`/etc/bashrc或/etc/profile`影响整个系统

# 第八章 监控和管理 Linux 进程

## 了解进程

`进程：`进程是已启动的可执⾏程序的运⾏中实例

## PS 查询进程

进程有多个状态，要警惕`僵尸状态的进程`，查询状态的命令如下：

1. ps

ps 通常是一次性的输出，可以用于配合grep来筛选特定进程是否存在

```bash
[root@host1 ~]# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        1314  0.0  0.0  16064  9380 ?        Ss   21:55   0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        2660  0.0  0.0  19444 12360 ?        Ss   21:58   0:00 sshd: root [priv]
root        2667  0.0  0.0  19444 12176 ?        Ss   21:58   0:00 sshd: root [priv]
root        2696  0.0  0.0  19712  7336 ?        S    21:58   0:00 sshd: root@pts/0
root        2718  0.0  0.0  19444  6496 ?        S    21:58   0:00 sshd: root@notty
root        2793  0.0  0.0 221800  2356 pts/0    S+   22:04   0:00 grep --color=auto sshd
```

在查询中，注意--color=auto这一行，这一行是ps命令回车产生的命令本身进程，并不算查询结果中的一个

```bash
[root@host1 ~]# ps aux | grep sshd
root        1314  0.0  0.0  16064  9380 ?        Ss   21:55   0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        2660  0.0  0.0  19444 12360 ?        Ss   21:58   0:00 sshd: root [priv]
root        2667  0.0  0.0  19444 12176 ?        Ss   21:58   0:00 sshd: root [priv]
root        2696  0.0  0.0  19712  7336 ?        S    21:58   0:00 sshd: root@pts/0
root        2718  0.0  0.0  19444  6496 ?        S    21:58   0:00 sshd: root@notty
root        2797  0.0  0.0 221800  2192 pts/0    S+   22:05   0:00 grep --color=auto sshd

```

查询进程之间的依赖

```bash
[root@host1 ~]# pstree
systemd─┬─ModemManager───3*[{ModemManager}]
        ├─NetworkManager───2*[{NetworkManager}]
        ├─VGAuthService
        ├─accounts-daemon───3*[{accounts-daemon}]
        ├─anacron
        ├─atd
        ├─auditd─┬─sedispatch
        │        └─2*[{auditd}]
        ├─avahi-daemon───avahi-daemon
        ├─chronyd
        ├─colord───3*[{colord}]
        ├─crond
        ├─dbus-broker-lau───dbus-broker
        ├─dhcpd
        ├─2*[dnsmasq───dnsmasq]
        ├─dnsmasq
        ├─firewalld───{firewalld}
        ├─fwupd───4*[{fwupd}]
        ├─gdm─┬─gdm-session-wor─┬─gdm-wayland-ses─┬─gnome-session-b───3*[{gnome-session-b}]
        │     │                 │                 └─2*[{gdm-wayland-ses}]
        │     │                 └─2*[{gdm-session-wor}]
        │     └─2*[{gdm}]

```

树形格式查询进程

```bash
[root@host1 ~]# ps --forest
    PID TTY          TIME CMD
   2710 pts/0    00:00:00 bash
   2817 pts/0    00:00:00  \_ ps

```

## top 查询进程

1. top

top 通常用于动态观察系统的压力情况，和Windows 任务管理器相似

```bash
[root@host1 ~]# top
top - 22:07:00 up 11 min,  2 users,  load average: 0.00, 0.03, 0.04
Tasks: 427 total,   1 running, 426 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  15966.9 total,  14038.1 free,   1339.8 used,    589.0 buff/cache
MiB Swap:  65536.0 total,  65536.0 free,      0.0 used.  14328.7 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   2804 root      20   0  226316   4392   3512 R   6.2   0.0   0:00.01 top
      1 root      20   0  172500  16788  10384 S   0.0   0.1   0:01.67 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.06 kthreadd
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp

```

我们注意到top命令右上角有一个 `load average`，这是系统的平均负载，表⽰⼀段时间内感知的系统负载，三个数字是最近 1 分钟、5 分钟和 15 分钟内的平均值

`负载平均值`代表⼀段时间内感知的系统负载。通过报告 CPU 上准备运⾏的进程数以及等待磁盘或⽹络 I/O 完成的进程数，Linux 可以确定负载平均值

还可以通过以下命令显示这三个数字：

```bash
[root@host1 ~]# uptime
 22:12:50 up 17 min,  2 users,  load average: 0.00, 0.00, 0.01

```

**这个数字和你的CPU核心数有关系，有一个核心，那每个数字最好都不好接近或超过1，趋近于1就说明CPU可能处于100%，两个核心，那就是不要趋近于2**

### 查询CPU信息

可以看出，我的电脑有4个CPU，每个cpu插槽里有4个核心，每个核心是一个超线程，那就是我有16核心

```bash
[root@host1 ~]# lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         45 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  16
  On-line CPU(s) list:   0-15
Vendor ID:               GenuineIntel
  BIOS Vendor ID:        GenuineIntel
  Model name:            11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
    BIOS Model name:     11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
    CPU family:          6
    Model:               141
    Thread(s) per core:  1
    Core(s) per socket:  4
    Socket(s):           4

```

```bash
[root@host1 ~]# grep "model name" /proc/cpuinfo | wc -l
16
[root@host1 ~]# grep "model name" /proc/cpuinfo
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
model name      : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz

```

### TOP 快捷键

|快捷键|效果|
|-|-|
|u|过滤⽤⼾名称|
|M|按照内存使⽤率，以降序⽅式对进程列表排序|
|P|按照处理器使⽤率，以降序⽅式对进程列表排序|
|k|中止特定进程|
|r|调整nice值|
|h|查询top命令其他快捷键或帮助|

## 进程或作业管理

每一次的shell命令回车，系统都会创建一个作业或进程

### 前后台任务调度

**安排后台作业**

任何命令或管道都可以在后台启动，只需在命令上附加⼀个 & 符号即可

我们在后台安排了一个任务，并看到作业编号为1，进程编号为2875

```bash
[lixiaohui@host1 ~]$ sleep 1000 &
[1] 2875
[lixiaohui@host1 ~]$ jobs
[1]+  Running                 sleep 1000 &

```

如果将包含竖线 (|) 的命令⾏发送到后台，将显⽰管道中最后⼀个命令的 PID

**将后台作业调度到前台**

使⽤ fg 命令将后台作业置于前台。使⽤ (%jobNumber) 格式将进程指定到前台

**+ 符号表⽰此作业是当前的默认作业。如果不带 %jobNumber 参数使⽤作业控制命令，则对默认作业执⾏操作。- 符号表⽰在当前默认作业完成时将成为默认作业的上⼀作业。**

```bash
[lixiaohui@host1 ~]$ jobs
[1]+  Running                 sleep 1000 &
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ fg %1
sleep 1000

```

**将前台作业调度到后台**

要将前台进程发送到后台，在终端中按键盘⽣成的暂停请求 (Ctrl+z)。该作业将被置于后台并暂停，然后执行bg %NUMBER继续后台运行

```bash
[lixiaohui@host1 ~]$ jobs
[1]+  Running                 sleep 1000 &
[lixiaohui@host1 ~]$
[lixiaohui@host1 ~]$ fg %1
sleep 1000
^Z
[1]+  Stopped                 sleep 1000
[lixiaohui@host1 ~]$ jobs
[1]+  Stopped                 sleep 1000
[lixiaohui@host1 ~]$ bg %1
[1]+ sleep 1000 &
[lixiaohui@host1 ~]$ jobs
[1]+  Running                 sleep 1000 &

```

### 查询特定所用的所有进程

```bash
[lixiaohui@host1 ~]$ pgrep -u lixiaohui
2849
2875

```

### 杀死特定用户的所有进程

有时候我们可能会怀疑被人非法入侵，我们需要知道有谁登录了系统，如果异常，要把用户踢下去

```bash
[root@host1 ~]# w
 22:46:55 up 51 min,  2 users,  load average: 0.00, 0.00, 0.00
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
laoli    tty2      21:55   51:15   0.06s  0.06s /usr/libexec/gnome-session-binary
root     pts/0     21:58    6.00s  0.03s  0.00s w
[root@host1 ~]# pkill -u laoli
[root@host1 ~]# w
 22:47:02 up 51 min,  1 user,  load average: 0.00, 0.00, 0.00
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0     21:58    5.00s  0.05s  0.01s w

```

# 第九章 控制服务和守护进程

## 了解 Systemd

systemd 守护进程管理 Linux 的启动过程，⼀般包括服务启动和服务管理，在红帽企业 Linux 中，第⼀个启动的进程 (PID 1) 是 systemd 守护进程

### 服务单元介绍

单元通过称为`单元⽂件`的配置⽂件表⽰，其中封装了关于系统服务、侦听套接字以及与 systemd init 系统相关的其他对象的信息。单元具有`名称和单元类型`。名称为单元提供唯⼀标识。通过单元类型，可以将单元与其他类似的单元类型分组到⼀起

### 列出服务单元

使⽤ systemctl 命令来探索系统的当前状态

```bash
[root@host1 ~]# systemctl list-units --type=service
  UNIT                               LOAD   ACTIVE SUB     DESCRIPTION                                                             >
  accounts-daemon.service            loaded active running Accounts Service
  atd.service                        loaded active running Deferred execution scheduler
  auditd.service                     loaded active running Security Auditing Service
  avahi-daemon.service               loaded active running Avahi mDNS/DNS-SD Stack
  chronyd.service                    loaded active running NTP client/server

```

systemctl list-units --type=service 命令仅列出激活状态为 active 的服务单元。systemctl list-units --all 选项可列出所有服务单元，不论激活状态如何

```bash
[root@host1 ~]# systemctl list-units --type=service --all
  UNIT                                   LOAD      ACTIVE   SUB     DESCRIPTION                                                    >
  accounts-daemon.service                loaded    active   running Accounts Service
● alsa-restore.service                   not-found inactive dead    alsa-restore.service
● alsa-state.service                     not-found inactive dead    alsa-state.service
● apparmor.service                       not-found inactive dead    apparmor.service
  atd.service                            loaded    active   running Deferred execution scheduler
  auditd.service                         loaded    active   running Security Auditing Service
  auth-rpcgss-module.service             loaded    inactive dead    Kernel Module supporting RPCSEC_GSS
● auto-cpufreq.service                   not-found inactive dead    auto-cpufreq.service
  autofs.service                         loaded    inactive dead    Automounts filesystems on demand
  avahi-daemon.service                   loaded    active   running Avahi mDNS/DNS-SD Stack

```

systemctl 命令 list-units 选项可显⽰ systemd 服务尝试解析并加载到内存中的单元。此选项不显⽰已安装但未启⽤的服务，可以使⽤ systemctl 命令 list-unit-files 选项来查看所有已安装的单元⽂件的状态

```bash
[root@host1 ~]# systemctl list-unit-files --type=service
UNIT FILE                                  STATE           VENDOR PRESET
accounts-daemon.service                    enabled         enabled
arp-ethers.service                         disabled        disabled
atd.service                                enabled         enabled
auditd.service                             enabled         enabled
auth-rpcgss-module.service                 static          -
autofs.service                             disabled        disabled
autovt@.service                            alias           -
avahi-daemon.service                       enabled         enabled

```

## 查看服务状态

使⽤ systemctl status name.type 命令来查看单元的状态

```bash
[root@host1 ~]# systemctl status sshd.service
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-02-06 21:55:43 CST; 1h 37min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 1314 (sshd)
      Tasks: 1 (limit: 101924)
     Memory: 8.4M
        CPU: 111ms
     CGroup: /system.slice/sshd.service
             └─1314 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

Feb 06 21:55:43 host1 systemd[1]: Starting OpenSSH server daemon...
Feb 06 21:55:43 host1 sshd[1314]: Server listening on 0.0.0.0 port 22.
Feb 06 21:55:43 host1 sshd[1314]: Server listening on :: port 22.
Feb 06 21:55:43 host1 systemd[1]: Started OpenSSH server daemon.

```

## 验证服务的状态

使⽤ systemctl 命令 is-active 选项来验证服务单元是否处于活动状态（正在运⾏）

运⾏ systemctl 命令 is-enabled 选项可验证服务单元是否已启⽤为在系统引导期间⾃动启动

验证单元是否在启动过程中失败，请运⾏ systemctl 命令 is-failed 选项

要列出所有失败的单元，请运⾏ systemctl --failed --type=service 命令

```bash
[root@host1 ~]# systemctl is-active sshd.service
active
[root@host1 ~]# systemctl is-enabled sshd.service
enabled
[root@host1 ~]# systemctl is-failed sshd.service
active
[root@host1 ~]# systemctl --failed --type=service
  UNIT LOAD ACTIVE SUB DESCRIPTION
0 loaded units listed.

```

## 管理服务状态

**启动服务**

```bash
[root@host1 ~]# systemctl start psacct.service
```

**停止服务**

```bash
[root@host1 ~]# systemctl stop psacct.service
```

**启用服务**

启用服务使得服务器重启时， 此服务会自动启动，可以加`--now`来立刻影响服务状态

```bash
[root@host1 ~]# systemctl enable psacct.service
Created symlink /etc/systemd/system/multi-user.target.wants/psacct.service → /usr/lib/systemd/system/psacct.service.
```


**禁用服务**

禁用服务使得服务器重启时， 此服务会`不自动启动`，可以加`--now`来立刻影响服务状态

```bash
[root@host1 ~]# systemctl disable psacct.service
Removed /etc/systemd/system/multi-user.target.wants/psacct.service.
```

**重启服务**

```bash
[root@host1 ~]# systemctl restart psacct.service
```

**重新加载服务**

修改了配置文件的参数时，不一定要重启服务，因为重启服务会结束进程，重新启动，而reload是在现有进程基础上重新加载新参数

```bash
[root@host1 ~]# systemctl reload psacct.service
```

**列出服务的依赖项**

```bash
[root@host1 ~]# systemctl list-dependencies sshd.service
sshd.service
● ├─system.slice
● ├─sshd-keygen.target
○ │ ├─sshd-keygen@ecdsa.service
○ │ ├─sshd-keygen@ed25519.service
○ │ └─sshd-keygen@rsa.service
● └─sysinit.target
●   ├─dev-hugepages.mount

```

**屏蔽服务**

部分服务之间可能彼此冲突，或者你不需要停止a服务后，a服务又被其他管理员启动或被b服务唤醒

```bash
[root@host1 ~]# systemctl mask psacct.service
Created symlink /etc/systemd/system/psacct.service → /dev/null.
[root@host1 ~]# systemctl restart psacct
Failed to restart psacct.service: Unit psacct.service is masked.
[root@host1 ~]# systemctl unmask psacct.service
Removed /etc/systemd/system/psacct.service.
[root@host1 ~]# systemctl restart psacct
[root@host1 ~]# systemctl is-active psacct
active

```

# 第十章 配置和保护 SSH

 OpenSSH 软件包提供了Secure Shell 或 SSH 协议。借助 SSH 协议，系统能够通过不安全的⽹络在加密和安全的通道中进⾏通信

## SSH 命令的基本使用

远程登录系统，不加用户名就是当前用户

```bash
[root@host1 ~]# ssh lxh-host2
root@hosta's password: redhat
[root@lxh-host2 ~]# exit
[root@host1 ~]# 
```

```bash
[root@host1 ~]# ssh lixiaohui@lxh-host2
lixiaohui@lxh-host2's password: redhat
[lixiaohui@lxh-host2 ~]$
```

查询系统中登录的用户

```bash
[lixiaohui@lxh-host2 ~]$ w
 11:03:15 up 10 min,  1 user,  load average: 0.04, 0.08, 0.08
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
lixiaohu pts/0     11:03    1.00s  0.06s  0.02s w
[lixiaohui@lxh-host2 ~]$ w -f
 11:03:19 up 10 min,  1 user,  load average: 0.03, 0.08, 0.08
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
lixiaohu pts/0    172.25.250.250   11:03    5.00s  0.04s  0.00s w -f
```

不以交互式方式登录对方，但是用对方的shell环境执行命令

```bash
[root@host1 ~]# ssh lixiaohui@lxh-host2 hostname
lixiaohui@lxh-host2's password: redhat
lxh-host2

```

## 主机密钥检查

默认情况下，第一次去连接对方时，对方会给出他的公钥信息，客户端会比比对`/etc/ssh/ssh_known_hosts或 ~/.ssh/known_hosts ⽂件`中是否已经记录了相关信息，如果没有会问你是否连接对方，接受新密钥，则公钥的副本将保存在 ~/.ssh/known_hosts ⽂件中

```bash
[root@host1 ~]# ssh root@servera
The authenticity of host 'lxh-host2 (192.168.1.18)' can't be established.
ED25519 key fingerprint is SHA256:peUGgfxFNw6Jt6WK4CB2rs+jql1/LhA32M1+8zBawLI.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?

```

## 禁用密钥检查

交互式输入yes会打断自动化，所以可以在必要时禁用这个检查

StrictHostKeyChecking 参数在⽤⼾特定的 `~/.ssh/config` ⽂件或系统范围的 `/etc/ssh/ssh_config` ⽂件中设置，或者通过指定 ssh 命令的 `-o StrictHostKeyChecking=` 选项来设置。

```bash
[root@host1 ~]# cat .ssh/config
Host *.ilt.example.com f* g*
    StrictHostKeyChecking no
    PreferredAuthentications publickey
    User kiosk
Host classroom.example.com classroom c
    StrictHostKeyChecking no
    PreferredAuthentications publickey
    User instructor
Host *.example.com *
    StrictHostKeyChecking no
    PreferredAuthentications publickey
    User student
```

```bash
[root@serverb ~]# ssh -o StrictHostKeyChecking=yes root@servera
No ED25519 host key is known for servera and you have requested strict checking.
Host key verification failed.
[root@serverb ~]# ssh -o StrictHostKeyChecking=no root@servera
Warning: Permanently added 'servera' (ED25519) to the list of known hosts.
root@servera's password:

```

## 基于 SSH 密钥的⾝份验证

每次生成新密钥，都会覆盖原有密钥，导致无法用以前的密钥登录

### 交互式生成密钥文件

```bash
[root@serverb ~]# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa
Your public key has been saved in /root/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:rYI63NZpSyOrdieyUii4FiJn1hpisFay2MDMJpjVuJQ root@serverb.lab.example.com
The key's randomart image is:
+---[RSA 3072]----+
|   +             |
|  E .            |
|=+ .             |
|**..     .       |
|*=+.    S .      |
|X=B ..   .       |
|*O.+o.+..        |
|o.*.=+=o         |
|.o+B.+..         |
+----[SHA256]-----+

```

### 非交互式生成密钥文件

```bash
[root@serverb ~]# ssh-keygen -N '' -f ~/.ssh/id_rsa
Generating public/private rsa key pair.
Your identification has been saved in /root/.ssh/id_rsa
Your public key has been saved in /root/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:oAnis4J88dovDwoe8iLe6RqYC4xtsEfJybiRNlo14J4 root@serverb.lab.example.com
The key's randomart image is:
+---[RSA 3072]----+
|  .              |
| . .             |
|. o o .          |
|.B * + .         |
|==E.o   S        |
|OX+ o            |
|%B+. o           |
|B=* =..          |
|+=+* .+o         |
+----[SHA256]-----+

```

## 分发密钥

分发公钥给所有需要被登录的机器，需要需要分发的公钥不在默认的位置，可以用-i参数来指定文件路径

```bash
[root@serverb ~]# ssh-copy-id student@servera
...
student@servera's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'student@servera'"
and check to make sure that only the key(s) you wanted were added.

[root@serverb ~]# ssh student@servera
[student@servera ~]$

```

## ssh 密钥管理器

如果在生成密钥的时候指定了使用密钥时的单独密码，每次使用私钥都会问你密码，这个非常不方便也不安全，可以将密钥缓存到ssh-agent程序中

```bash
[root@serverb ~]# ssh student@servera
Enter passphrase for key '/root/.ssh/id_rsa':

[root@serverb ~]#
[root@serverb ~]# eval $(ssh-agent)
Agent pid 1606
[root@serverb ~]# ssh-add
Enter passphrase for /root/.ssh/id_rsa:
Identity added: /root/.ssh/id_rsa (root@serverb.lab.example.com)
[root@serverb ~]# ssh student@servera
Activate the web console with: systemctl enable --now cockpit.socket

Register this system with Red Hat Insights: insights-client --register
Create an account or view all your systems at https://red.ht/insights-dashboard
Last login: Tue Feb  6 11:27:55 2024 from 172.25.250.11
[student@servera ~]$

```


## ⾃定义 OpenSSH 服务配置

sshd 守护进程提供 OpenSSH 服务。您可以通过编辑 /etc/ssh/sshd_config ⽂件来配置该服务

## 禁⽌超级⽤⼾进⾏登录

OpenSSH 服务器使⽤ /etc/ssh/sshd_config ⽂件中的 PermitRootLogin 配置设置，以允许或禁⽌⽤⼾以 root ⽤⼾⾝份登录系统

设置为`without-password`后，只允许root用密钥登录，不允许密码登录

设置后，需要重启sshd服务

```bash
[root@host1 ~]# grep PermitRootLogin /etc/ssh/sshd_config
PermitRootLogin yes
# the setting of "PermitRootLogin without-password".

```

## 禁⽌基于密码的⾝份验证

一般来说，默认是启用的

```bash
[root@host1 ~]# grep PasswordAuthentication /etc/ssh/sshd_config
#PasswordAuthentication yes

```

# 第十一章 管理网络

## 网络接口名称的变化

在RHEL 7之后，不再用eth0、eth1来标记网络接口，系统将基于固件信息、PCI 总线拓扑及⽹络设备的类型来分配⽹络接⼝名称

⽹络接⼝名称以接⼝类型开头：
- 以太⽹接⼝以 en 开头
- WLAN 接⼝以 wl 开头
- WWAN 接⼝以 ww 开头

在类型之后，接⼝名称的其余部分将基于服务器固件所提供的信息，或由 PCI 拓扑中设备的位置确定。

- oN 表⽰板载设备，其唯⼀索引为 N，来⾃服务器的固件。eno1 名称是板载以太⽹设备 1。
- sN 表⽰这是⼀个位于 PCI 热插拔插槽 N 中的设备。例如，ens3 代表 PCI 热插拔插槽 3 中的以太
⽹卡。
- pMsN 表⽰这是⼀个位于插槽 N 中总线 M 上的 PCI 设备。wlp4s0 接⼝是位于插槽 0 中 PCI 总线 4
上的 WLAN 卡。

## IPV4和IPV6

### IPV4概述

`IPv4` 地址是⼀个 `32 位数字`，使⽤点号分隔的四个⼗进制⼋位字节（取值范围从 0 到 255）来表⽰。

此类地址分为两个部分，即⽹络前缀和主机编号。⽹络前缀标识唯⼀的物理或虚拟⼦⽹。主机号标识⼦⽹上的特定主机。同一子网中的主机可以无需网关互相通信，⽹络⽹关连接不同的⽹络，⽹络路由器通常充当⼦⽹的⽹关

### IPV4 地址计算公式

192.168.1.0/24中一共有多少个地址可用？

```text
2^(32-24)  //2的32-24次方
```

对于/24子网，子网掩码是255.255.255.0，这意味着前24位是网络地址，最后8位是主机地址。因此，我们有2^8 = 256个可能的地址组合。

但是，我们需要减去两个地址：

1. 网络地址（Network Address）：它是子网的第一个地址，用于标识整个子网。例如，在192.168.1.0/24子网中，网络地址是192.168.1.0。

2. 广播地址（Broadcast Address）：它是子网的最后一个地址，用于向子网内的所有设备发送广播消息。在192.168.1.0/24子网中，广播地址是192.168.1.255。

因此，对于/24子网，实际可用的主机地址是256（总地址数） - 2（网络地址和广播地址） = 254个。

### IPV6概述

`IPv6` 地址是⼀个 `128 位数字`，通常表⽰为⼋组以分号分隔的四个⼗六进制半字节。每个半字节均表⽰ 4 位的 IPv6 地址，因此每个组表⽰ 16 位的 IPv6 地址，在IPV6中的字母只能时`A-F`。

```text
2001:0db8:0000:0010:0000:0000:0000:0001
```

### 简化IPV6写法

1. 去掉前导零

```text
2001:db8:0:10:0:0:0:1
```

2. 去掉连续零

连续都是0时，用::表示，但是一个地址中只能出现一次

```text
2001:db8:0:10::1
```

3. 加端口的写法

如果在 IPv6 地址后⾯包括 TCP 或 UDP ⽹络端⼝，请始终将 IPv6 地址括在⽅括号中，以便端⼝不会被误认为是地址的⼀部分。

```bash
[2001:db8:0:10::1]:80
```

## 主机名解析和 IP 地址映射

1. `/etc/hosts` ⽂件中为每个主机名创建静态条⽬，但是需要管理员手工更新，且只影响此机器，影响不到别的机器

2. `/etc/resolv.conf` ⽂件中列出了所有使用中的DNS服务器地址

## 查询网络接口和IP

```bash
[root@lixiaohui ~]# ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0c:29:6a:16:13 brd ff:ff:ff:ff:ff:ff
    inet 172.25.254.250/24 brd 172.25.254.255 scope global noprefixroute br0
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe6a:1613/64 scope link noprefixroute
       valid_lft forever preferred_lft forever

```
1. 网络接口有2个，`lo和ens160`，其中`lo`为连接到服务器本⾝的环回设备，`不能用于网络互通`
2. `ens160`接口上的IPV4地址是：172.25.254.250/24
3. `ens160`接口上的MAC地址是：00:0c:29:6a:16:13
4. `ens160`接口上的IPV6地址是：fe80::20c:29ff:fe6a:1613/64

## 测试网络通畅

`ping` 命令可以测试连接。该命令将持续运⾏，直到按下 `Ctrl+c` 为⽌，或者指定`-c`参数

`ping6`命令可以测试ipv6连接

```bash
[root@lixiaohui ~]# ping 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.062 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.130 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.079 ms
^C
--- 127.0.0.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2314ms
rtt min/avg/max/mdev = 0.062/0.090/0.130/0.028 ms

[root@lixiaohui ~]# ping -c 2 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.064 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.083 ms

--- 127.0.0.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1166ms
rtt min/avg/max/mdev = 0.064/0.073/0.083/0.009 ms

[root@lixiaohui ~]# ping6 fe80::c38a:ac39:36a1:a43c
PING fe80::c38a:ac39:36a1:a43c(fe80::c38a:ac39:36a1:a43c) 56 data bytes

```

## 查询路由

```bash
[root@lixiaohui ~]# ip route
default via 172.25.250.254 dev eth0 proto static metric 100
172.25.250.0/24 dev eth0 proto kernel scope link src 172.25.250.10 metric 100
[root@lixiaohui ~]# ip -6 route
::1 dev lo proto kernel metric 256 pref medium
fe80::/64 dev eth0 proto kernel metric 1024 pref medium

```

## 追踪流量路由

可使⽤ `traceroute` `或tracepath` 命令来完成追踪流量路由，通常，默认情况下系统不安装 `traceroute` 命令。

`tracepath6` 和 `traceroute -6` 命令等效于 IPv6 版本的 `tracepath` 和 `traceroute` 命令。

```bash
[root@lixiaohui ~]# tracepath classroom
 1?: [LOCALHOST]                      pmtu 1500
 1:  bastion.lab.example.com                               0.901ms
 1:  bastion.lab.example.com                               0.355ms
 2:  172.25.254.254                                        1.561ms reached
     Resume: pmtu 1500 hops 2 back 2

```

## 端⼝和服务故障排除

`/etc/services` ⽂件中列出了标准端⼝的常⽤名称

`ss` 命令可⽤于显⽰套接字统计信息。`ss` 命令取代了 `net-tools` 软件包中所含的较早的⼯具`netstat`

```bash
[root@lixiaohui ~]# ss -tunlpa
Netid    State     Recv-Q    Send-Q       Local Address:Port          Peer Address:Port     Process
udp      UNCONN    0         0                  0.0.0.0:111                0.0.0.0:*         users:(("rpcbind",pid=741,fd=5),("systemd",pid=1,fd=42))
udp      UNCONN    0         0                127.0.0.1:323                0.0.0.0:*         users:(("chronyd",pid=786,fd=5))
udp      UNCONN    0         0                     [::]:111                   [::]:*         users:(("rpcbind",pid=741,fd=7),("systemd",pid=1,fd=46))
udp      UNCONN    0         0                    [::1]:323                   [::]:*         users:(("chronyd",pid=786,fd=6))
tcp      LISTEN    0         128                0.0.0.0:22                 0.0.0.0:*         users:(("sshd",pid=808,fd=3))
tcp      LISTEN    0         4096               0.0.0.0:111                0.0.0.0:*         users:(("rpcbind",pid=741,fd=4),("systemd",pid=1,fd=41))
tcp      ESTAB     0         0            172.25.250.10:22          172.25.250.250:35520     users:(("sshd",pid=1082,fd=4),("sshd",pid=1069,fd=4))
tcp      LISTEN    0         128                   [::]:22                    [::]:*         users:(("sshd",pid=808,fd=4))
tcp      LISTEN    0         4096                  [::]:111                   [::]:*         users:(("rpcbind",pid=741,fd=6),("systemd",pid=1,fd=43))

```

1. `-n` 显⽰接⼝和端⼝的编号，⽽不显⽰名称
2. `-t` 显⽰ TCP 套接字
3. `-u` 显⽰ UDP 套接字
4. `-l` 仅显⽰侦听中的套接字
5. `-a` 显⽰所有（侦听中和已建⽴的）套接字
6. `-p` 显⽰使⽤套接字的进程

## NetworkManager

可以通过命令⾏或图形⼯具与 NetworkManager 服务交互。服务配置⽂件存储在 `/etc/NetworkManager/system
connections/` ⽬录中。

NetworkManager 服务⽤于管理⽹络设备和⽹络连接。

1. 设备是提供⽹络流量的物理或虚拟⽹络接⼝。
2. 连接拥有单个⽹络设备的相关配置设置。连接也可称为⽹络配置集。每个连接必须具有唯⼀的名称或 ID，可以与其配置的设备名称匹配，`单个设备可以有多个连接配置并在它们之间切换，但每个设备只能有⼀个连接处于活跃状态`

## 查看⽹络信息

以下信息中，eth0这个网络是类型是Ethernet，并已经连接到lxh-connection的链接，eno2的state部分显示disconnected，表示此接口此时不用于网络通信

```bash
[root@lixiaohui ~]# nmcli device status
DEVICE  TYPE      STATE      CONNECTION
eth0    ethernet  connected  lxh-connection
lo      loopback  unmanaged  --
eno2    ethernet  disconnected  --
```

## 查询所有链接

`nmcli connection show` 命令可显⽰所有连接的列表。使⽤ `--active` 选项可仅列出活动的连接

```bash
[root@lixiaohui ~]# nmcli con show
NAME         UUID                                  TYPE            DEVICE
eno2         ff9f7d69-db83-4fed-9f32-939f8b5f81cd  802-3-ethernet  -
static-ens3  72ca57a2-f780-40da-b146-99f71c431e2b  802-3-ethernet  ens3
eno1         87b53c56-1f5d-4a29-a869-8a7bdaf56dfa  802-3-ethernet  eno1
[root@lixiaohui ~]# nmcli con show --active
NAME         UUID                                  TYPE            DEVICE
static-ens3  72ca57a2-f780-40da-b146-99f71c431e2b  802-3-ethernet  ens3
eno1         87b53c56-1f5d-4a29-a869-8a7bdaf56dfa  802-3-ethernet  eno1
```

查询具体的网络连接详情

```bash
[root@lixiaohui system-connections]# nmcli connection show lxh-con2
connection.id:                          lxh-con2
connection.uuid:                        f2af0cda-b25c-4688-9df3-2b4f8428f407
connection.stable-id:                   --
connection.type:                        802-3-ethernet
connection.interface-name:              eth0
connection.autoconnect:                 yes
connection.autoconnect-priority:        0
connection.autoconnect-retries:         -1 (default)
connection.multi-connect:               0 (default)
```

## 添加⽹络连接

使⽤ `nmcli connection add` 命令来添加⽹络连接，可以采取`TAB键`不断的补齐参数

以下命令将`lxh-con2`添加到`eth0`设备上，并将IPV4设置为`1.1.1.1/24`，网关设置为`1.1.1.2`，DNS设置为`1.1.1.3`，需要特别注意`ipv4.method` 参数设置为`manual`，只有设置为manual，你手工设置的网络信息才会优先生效，`autoconnect yes`为服务器重启时，`自动激活`此链接

```bash
[root@lixiaohui ~]# nmcli connection add con-name lxh-con2 type ethernet ifname eth0 ipv4.method manual ipv4.addresses 1.1.1.1/24 ipv4.gateway 1.1.1.12 ipv4.dns 1.1.1.3 autoconnect yes
Connection 'lxh-con2' (f2af0cda-b25c-4688-9df3-2b4f8428f407) successfully added.
[root@lixiaohui ~]# nmcli con show
NAME                UUID                                  TYPE      DEVICE
Wired connection 1  ec3a15fb-2e26-3254-9433-90c66981e924  ethernet  eth0
lxh-con2            f2af0cda-b25c-4688-9df3-2b4f8428f407  ethernet  --

```

以下命令将`lxh-con3`添加到`eth0`设备上，并将IPV6设置为`2000::1/64`，网关设置为`2000::2`，DNS设置为2000::3`，需要特别注意`ipv6.method` 参数设置为`manual`，只有设置为manual，你手工设置的网络信息才会优先生效，`autoconnect yes`为服务器重启时，`自动激活`此链接

```bash
[root@lixiaohui ~]# nmcli connection add con-name lxh-con3 type ethernet ifname eth0 ipv6.method manual ipv6.addresses "2000::1/64" ipv6.gateway "2000::2" ipv6.dns "2000::3" autoconnect yes
Connection 'lxh-con3' (9f7c282c-9254-45cf-a020-24acac1639b1) successfully added.
[root@lixiaohui ~]# nmcli connection show
NAME                UUID                                  TYPE      DEVICE
Wired connection 1  ec3a15fb-2e26-3254-9433-90c66981e924  ethernet  eth0
lxh-con2            f2af0cda-b25c-4688-9df3-2b4f8428f407  ethernet  --
lxh-con3            9f7c282c-9254-45cf-a020-24acac1639b1  ethernet  --

```

查看具体的网络配置文件

```bash
[root@lixiaohui system-connections]# cat /etc/NetworkManager/system-connections/lxh-con2.nmconnection
[connection]
id=lxh-con2
uuid=f2af0cda-b25c-4688-9df3-2b4f8428f407
type=ethernet
interface-name=eth0

[ethernet]

[ipv4]
address1=1.1.1.1/24,1.1.1.12
dns=1.1.1.3;
method=manual

[ipv6]
addr-gen-mode=stable-privacy
method=auto

[proxy]

```

## 修改网络连接

将`lxh-con2`的连接IP改为`2.2.2.2/24`，并添加另一个IP地址`3.3.3.3/24`到此连接上

`+`号可以用在ip地址、dns等信息上，用于添加辅助网络信息

```bash
[root@lixiaohui ~]# nmcli connection modify lxh-con2 ipv4.addresses 2.2.2.2/24 +ipv4.addresses 3.3.3.3/24
[root@lixiaohui ~]# nmcli connection show lxh-con2 | grep ipv4
ipv4.method:                            manual
ipv4.dns:                               1.1.1.3
ipv4.dns-search:                        --
ipv4.dns-options:                       --
ipv4.dns-priority:                      0
ipv4.addresses:                         2.2.2.2/24, 3.3.3.3/24
ipv4.gateway:                           1.1.1.12

```
## 激活网络连接

需要注意的是，`一个设备同时只能激活一个连接`

```bash
[root@lixiaohui ~]# nmcli connection up lxh-con2
```

## 关闭网络连接

关闭网络连接后，可能会`面临断网`的情况

```bash
[root@lixiaohui ~]# nmcli connection down lxh-con2
```

除了关闭网络连接外，还可以直接断开网络设备的连接

```bash
[root@lixiaohui ~]# nmcli device disconnect eth0
```

## 重新加载网络连接

```bash
[root@lixiaohui ~]# nmcli connection reload lxh-con2
```

## 删除网络连接

```bash
[root@lixiaohui ~]# nmcli connection delete lxh-con2
```

## 更新系统主机名

`hostname`或`hostnamectl`命令可以显示主机名，`hostnamectl`命令可以设置主机名，主机名将放入到`/etc/hostname`中

```bash
[root@lixiaohui ~]# hostnamectl
 Static hostname: lixiaohui
       Icon name: computer-vm
         Chassis: vm 🖴
      Machine ID: ace63d6701c2489ab9c0960c0f1afe1d
         Boot ID: d845959153e74e6fb3e9d157c18b851f
  Virtualization: kvm
Operating System: Red Hat Enterprise Linux 9.0 (Plow)
     CPE OS Name: cpe:/o:redhat:enterprise_linux:9::baseos
          Kernel: Linux 5.14.0-70.13.1.el9_0.x86_64
    Architecture: x86-64
 Hardware Vendor: Red Hat
  Hardware Model: KVM

[root@lixiaohui ~]# hostnamectl hostname test
[root@lixiaohui ~]# cat /etc/hostname
test
[root@lixiaohui ~]# sudo -i
[root@test ~]#
```

## 配置名称解析

1. `/etc/hosts` ⽂件中为每个主机名创建静态条⽬，但是需要管理员手工更新，且只影响此机器，影响不到别的机器

2. `/etc/resolv.conf` ⽂件中列出了所有使用中的DNS服务器地址

测试一下DNS名称解析

`getent`将先查询`/etc/hosts`，如果没找到，才找dns服务器，所以此命令可以帮助测试hosts文件

`host、dig不会查看/etc/hosts`

```bash
[root@lixiaohui ~]# host servera
servera.lab.example.com has address 172.25.250.10

[root@lixiaohui ~]# getent hosts servera
172.25.250.10   servera.lab.example.com

[root@lixiaohui ~]# dig servera.lab.example.com

; <<>> DiG 9.16.23-RH <<>> servera.lab.example.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 4557
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 8265a3a3071b4061ba7ea74165d1ef6e76e9842339bf54cf (good)
;; QUESTION SECTION:
;servera.lab.example.com.       IN      A

;; ANSWER SECTION:
servera.lab.example.com. 86400  IN      A       172.25.250.10

;; AUTHORITY SECTION:
lab.example.com.        86400   IN      NS      utility.lab.example.com.

;; ADDITIONAL SECTION:
utility.lab.example.com. 86400  IN      A       172.25.250.220

;; Query time: 4 msec
;; SERVER: 172.25.250.220#53(172.25.250.220)
;; WHEN: Sun Feb 18 06:52:14 EST 2024
;; MSG SIZE  rcvd: 134

```

# 第十二章 安装和更新软件包

## 系统订阅与注册

Linux 系统需要以安装软件包的方式丰富服务器功能，而红帽提供了在线的增值服务，给我们提供高质量的软件包仓库，我们从仓库中可以安装软件，这要求我们将系统注册到红帽网络，这个会涉及到购买服务，作为开发者，可以用以下连接完成注册为开发者，临时获得此服务

```bash
RHEL 开发者订阅注册：https://developers.redhat.com/register
```

以下命令完成了系统注册

```bash
[root@lixiaohui ~]# subscription-manager register --username 939958092@qq.com
Registering to: subscription.rhsm.redhat.com:443/subscription
Password:
The system has been registered with ID: 4aa93fdb-8d29-4e72-b97b-b5ab5421ea8e
The registered system name is: lixiaohui
```
以下命令取消了系统注册

```bash
[root@lixiaohui ~]# subscription-manager unregister
Unregistering from: subscription.rhsm.redhat.com:443/subscription
System has been unregistered.

```


## RPM 软件包描述

RPM 软件包管理器最初是由红帽开发的，提供了⼀种标准的⽅式来打包软件进⾏分发，借助 RPM 软件包，管理员可以跟踪软件包会安装哪些⽂件，卸载软件包时将删除哪些⽂件，并且在安装时验证是否存在⽀持软件包

RPM 软件包⽂件名由四个元素组成（再加上 .rpm 后缀）：name-version-release.architecture：


`coreutils-8.32-21.el9.x86_64.rpm`

1. coreutils是名字

2. 8.32是版本

3. 21.el9是发行版本号以及平台名称，此处是适用于el9的21此发行版本

4. x86_64是CPU指令集，这代表64位

- rpm -qa ：列出所有已安装的软件包
- rpm -qf FILENAME ：确定提供 FILENAME 的软件包
- rpm -q coreutils：列出当前安装的软件包版本
- rpm -qi coreutils：获取软件包的详细信息。
- rpm -ql coreutils：列出软件包安装的⽂件
- rpm -qc coreutils：仅列出软件包安装的配置⽂件
- rpm -qd coreutils：仅列出软件包安装的⽂档⽂件
- rpm -q --scripts ：列出在安装或删除软件包之前或之后运⾏的 shell 脚本
- rpm -q --changelog ：列出软件包的更改⽇志信息
- rpm -qlp coreutils-8.32-21.el9.x86_64.rpm：列出本地软件包安装的⽂件。
- rpm -ivh podman-4.0.0-6.el9.x86_64.rpm。使⽤ rpm 命令来安装已下载到本地⽬录的 RPM 软件包
- rpm2cpio httpd-2.4.51-7.el9_0.x86_64.rpm | cpio -idv rpm2cpio 命令将 RPM 软件包转换为 cpio 归档。将 RPM 软件包转换为 cpio 归档后，可以使⽤cpio 命令提取⽂件列表

## DNF 管理软件包

在新版本的Linux上，DNF命令取代了以前的YUM命令，但YUM依旧可以使用，但会自动链接到DNF并执行

### DNF 仓库配置

和RPM不同，DNF依赖于仓库的存在，DNF并不要求你指定软件包的具体位置，你只需要指定名称，就可以通过DNF命令来完成安装、更新、卸载等操作，DNF会自动从你配置的仓库中，搜索下载软件包

列出本地仓库

```bash
[root@lixiaohui ~]# dnf repolist all
repo id                               repo name                                        status
rhel-9.0-for-x86_64-appstream-rpms    Red Hat Enterprise Linux 9.0 AppStream (dvd)     enabled
rhel-9.0-for-x86_64-baseos-rpms       Red Hat Enterprise Linux 9.0 BaseOS (dvd)        enabled
```

所有的仓库将以文件的方式存在于/etc/yum.repos.d/中，此路径中包括在系统中可用的仓库文件，文件名要求以repo结尾，具体格式如下：

```ini
[root@lixiaohui ~]# cat /etc/yum.repos.d/rhel_dvd.repo
[rhel-9.0-for-x86_64-baseos-rpms]
baseurl = http://content.example.com/rhel9.0/x86_64/dvd/BaseOS
enabled = 1
gpgcheck = false
name = Red Hat Enterprise Linux 9.0 BaseOS (dvd)
[rhel-9.0-for-x86_64-appstream-rpms]
baseurl = http://content.example.com/rhel9.0/x86_64/dvd/AppStream
enabled = true
gpgcheck = false
name = Red Hat Enterprise Linux 9.0 AppStream (dvd)

```


### 禁用和启用仓库

```bash
[root@lixiaohui ~]# dnf config-manager --disable rhel-9.0-for-x86_64-baseos-rpms
[root@lixiaohui ~]# dnf repolist all
repo id                               repo name                                        status
rhel-9.0-for-x86_64-appstream-rpms    Red Hat Enterprise Linux 9.0 AppStream (dvd)     enabled
rhel-9.0-for-x86_64-baseos-rpms       Red Hat Enterprise Linux 9.0 BaseOS (dvd)        disabled
```

```bash
[root@lixiaohui ~]# dnf config-manager --enable rhel-9.0-for-x86_64-baseos-rpms
[root@lixiaohui ~]# dnf repolist all
repo id                               repo name                                        status
rhel-9.0-for-x86_64-appstream-rpms    Red Hat Enterprise Linux 9.0 AppStream (dvd)     enabled
rhel-9.0-for-x86_64-baseos-rpms       Red Hat Enterprise Linux 9.0 BaseOS (dvd)        enabled
```

### 添加 DNF 仓库

```bash
[root@lixiaohui ~]# dnf config-manager --add-repo="https://dl.fedoraproject.org/pub/epel/9/Everything/x86_64/"
Adding repo from: https://dl.fedoraproject.org/pub/epel/9/Everything/x86_64/

[root@lixiaohui ~]# cat /etc/yum.repos.d/dl.fedoraproject.org_pub_epel_9_Everything_x86_64_.repo
[dl.fedoraproject.org_pub_epel_9_Everything_x86_64_]
name=created by dnf config-manager from https://dl.fedoraproject.org/pub/epel/9/Everything/x86_64/
baseurl=https://dl.fedoraproject.org/pub/epel/9/Everything/x86_64/
enabled=1

```

默认情况下，命令添加仓库时，没有GPG公钥，这个需要自己手工下载到系统中，并在repo文件中添加，添加好之后的样例如下：

```ini
[EPEL]
name=EPEL 9
baseurl=https://dl.fedoraproject.org/pub/epel/9/Everything/x86_64/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9
```

### DNF 安装软件

```bash
[root@lixiaohui ~]# dnf install httpd -y
...
Complete!
```

### 列出已安装的软件包

```bash
[root@lixiaohui ~]# dnf list installed
```

### 列出在仓库中可用的软件包

```bash
[root@lixiaohui ~]# dnf list available
```

### DNF 搜索软件包

```bash
[root@lixiaohui ~]# dnf search all 'web server'
```

### 查看软件包信息

```bash
[root@lixiaohui ~]# dnf info httpd
```

### 查询文件来源

```bash
[root@lixiaohui ~]# dnf provides /var/www/html
```

### 删除软件包

```bash
[root@lixiaohui ~]# dnf remove httpd
```

### 更新软件包

**注意** 如果dnf update后面不加软件包名字，它将更新系统中的所有软件包，其中就包括内核

```bash
[root@lixiaohui ~]# dnf list kernel
Last metadata expiration check: 0:05:40 ago on Sun 18 Feb 2024 08:20:06 AM EST.
Installed Packages
kernel.x86_64     5.14.0-70.13.1.el9_0        @System
[root@lixiaohui ~]# uname -r
5.14.0-70.13.1.el9_0.x86_64
[root@lixiaohui ~]# uname -a
Linux lixiaohui 5.14.0-70.13.1.el9_0.x86_64 #1 SMP PREEMPT Thu Apr 14 12:42:38 EDT 2022 x86_64 x86_64 x86_64 GNU/Linux

```

只更新特定软件包：

```bash
[root@lixiaohui ~]# dnf update httpd
```


### 列出软件包组

dnf 命令也具有组的概念，即⼀起安装的相关软件集合。

```bash
[root@lixiaohui ~]# dnf grouplist
Last metadata expiration check: 0:07:56 ago on Sun 18 Feb 2024 08:20:06 AM EST.
Available Environment Groups:
   Server with GUI
   Server
   Minimal Install
   Workstation
   Custom Operating System
   Virtualization Host
Available Groups:
   Legacy UNIX Compatibility
   Console Internet Tools
   Container Management
   Development Tools
   .NET Development
   Graphical Administration Tools
   Headless Management
   Network Servers
   RPM Development Tools
   Scientific Support
   Security Tools
   Smart Card Support
   System Tools

```

### 查询软件包组信息

这些集合提供的软件包或组可以列为 mandatory（安装该组时必须予以安装）、default（安装该组时通常会安装），或 optional（安装该组时不予安装，除⾮特别要求）

```bash
[root@lixiaohui ~]# dnf groupinfo "System Tools"
Last metadata expiration check: 0:08:56 ago on Sun 18 Feb 2024 08:20:06 AM EST.
Group: System Tools
 Description: This group is a collection of various tools for the system, such as the client for connecting to SMB shares and tools to monitor network traffic.
 Default Packages:
   NetworkManager-libreswan
   chrony
   cifs-utils
   libreswan
   nmap
   openldap-clients
   samba-client
   setserial
   tigervnc
   tmux
   zsh
 Optional Packages:
   PackageKit-command-not-found
   aide
   autofs
   bacula-client
   chrpath
   convmv
   createrepo_c
   environment-modules
   freerdp
   fuse
   gpm

```

### 安装软件包组

```bash
[root@lixiaohui ~]#  dnf group install "RPM Development Tools" -y
```

## DNF 事务

所有安装和删除事务的⽇志都记录在 /var/log/dnf.rpm.log 中。

```bash
[root@lixiaohui ~]# tail /var/log/dnf.rpm.log
2024-02-18T08:32:46-0500 SUBDEBUG Installed: gdb-minimal-10.2-9.el9.x86_64
2024-02-18T08:32:47-0500 SUBDEBUG Installed: efi-srpm-macros-6-2.el9_0.noarch
2024-02-18T08:32:47-0500 SUBDEBUG Installed: dwz-0.14-3.el9.x86_64
2024-02-18T08:32:47-0500 SUBDEBUG Installed: fonts-srpm-macros-1:2.0.5-7.el9.1.noarch
2024-02-18T08:32:47-0500 SUBDEBUG Installed: go-srpm-macros-3.0.9-9.el9.noarch
2024-02-18T08:32:47-0500 SUBDEBUG Installed: python-srpm-macros-3.9-52.el9.noarch
2024-02-18T08:32:47-0500 SUBDEBUG Installed: redhat-rpm-config-194-1.el9.noarch
2024-02-18T08:32:47-0500 SUBDEBUG Installed: elfutils-0.186-1.el9.x86_64
2024-02-18T08:32:47-0500 SUBDEBUG Installed: rpm-build-4.16.1.3-12.el9_0.x86_64
2024-02-18T08:32:47-0500 SUBDEBUG Installed: rpmdevtools-9.5-1.el9.noarch

```

### 查询DNF 历史

```bash
[root@lixiaohui ~]# dnf history
ID     | Command line                                          | Date and time    | Action(s)      | Altered
------------------------------------------------------------------------------------------------------------
     3 | group install RPM Development Tools -y                | 2024-02-18 08:32 | Install        |   78
     2 | install httpd -y                                      | 2024-02-18 08:20 | Install        |   10 EE
     1 | -y install @base firewalld vim-enhanced gpm xkeyboard | 2022-05-18 07:12 | D, I           |  163 EE

```

### 撤销DNF事务

从上面的查询来看，ID为2是安装了httpd软件包，撤销就是卸载的意思

```bash
[root@lixiaohui ~]# dnf history undo 2
```

### 重做DNF事务

刚卸载了httpd，现在可以redo重做事务来再安装

```bash
[root@lixiaohui ~]# dnf history redo 2
```

# 第十三章 访问 Linux ⽂件系统

## 识别⽂件系统和设备

从RHEL 7开始默认的文件系统为XFS

### 挂载点

通过将⽂件系统挂载到空⽬录来访问⽂件系统的内容。该⽬录被称为挂载点，⽬录挂载后，使⽤ ls 命令列出该⽬录的内容。许多⽂件系统系统启动时⾃动挂载。

### 块设备

块设备是提供存储设备低级别访问权限的⽂件。必须对块设备进⾏可选分区，并创建⽂件系统，然后才能挂载该设备。

/dev ⽬录存储 RHEL ⾃动为所有设备创建的块设备⽂件。在 RHEL 9 中，检测到的第⼀个SATA、SAS、SCSI 或 USB 硬盘驱动器被称为 /dev/sda 设备，第⼆个被称为 /dev/sdb 设备，以此类推。这些名称代表整个硬盘驱动器。

### 磁盘分区

分区本⾝就是块设备。例如，在第⼀ SATA 附加存储中，第⼀分区是 /dev/sda1 磁盘。同⼀存储的第⼆分区是 /dev/sda2 磁盘。

### 逻辑卷

整理磁盘和分区的另⼀种⽅式是利⽤逻辑卷管理 (LVM)。借助 LVM，可以将多个块设备聚合到⼀个卷组中。卷组中的磁盘空间分割成若⼲逻辑卷，它们的功能等同于物理磁盘上的分区。

LVM 系统在创建时为卷组和逻辑卷分配名称。LVM 在 /dev ⽬录中创建⼀个名称与组名匹配的⽬录，然后在该新⽬录中创建⼀个与逻辑卷同名的符号链接。之后，可以挂载该逻辑卷⽂件。例如，如果存在⼀个 myvg 卷组和 mylv 逻辑卷，那么其逻辑卷的完整路径名是 /dev/myvg/mylv。

### 文件系统查询

1. 使⽤ df 命令可显⽰本地和远程⽂件系统设备的概览，其中包括总磁盘空间、已⽤磁盘空间、可⽤
磁盘空间，以及占整个磁盘空间的百分⽐

df 命令的 -h 或 -H 选项是⼈类可读选项，可以改善输出⼤⼩的可读性。-h 选项的报告单位是 KiB(1024进制)，⽽ -H 选项的报告单位是 SI 单位（1000进制）

```bash
[root@lixiaohui ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        844M     0  844M   0% /dev
tmpfs           888M     0  888M   0% /dev/shm
tmpfs           355M  9.5M  346M   3% /run
/dev/vda4       9.4G  1.8G  7.6G  19% /
/dev/vda3       495M  160M  335M  33% /boot
/dev/vda2       200M  7.0M  193M   4% /boot/efi
tmpfs           178M     0  178M   0% /run/user/0
[root@lixiaohui ~]# df -H
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        885M     0  885M   0% /dev
tmpfs           931M     0  931M   0% /dev/shm
tmpfs           373M   10M  363M   3% /run
/dev/vda4        10G  1.9G  8.2G  19% /
/dev/vda3       519M  168M  351M  33% /boot
/dev/vda2       210M  7.4M  203M   4% /boot/efi
tmpfs           187M     0  187M   0% /run/user/0

```

2. du 命令的 -h 和 -H 选项可以将输出转换为⼈类可读格式。du 命令以递归⽅式显⽰当前⽬录树中所有⽂件的⼤⼩。

```bash
[root@lixiaohui ~]# du /boot
6132    /boot/efi/EFI/redhat
1012    /boot/efi/EFI/BOOT
7148    /boot/efi/EFI
7164    /boot/efi
4       /boot/loader/entries
4       /boot/loader
2340    /boot/grub2/fonts
3344    /boot/grub2/i386-pc
5692    /boot/grub2
141348  /boot
[root@lixiaohui ~]# du -h /boot
6.0M    /boot/efi/EFI/redhat
1012K   /boot/efi/EFI/BOOT
7.0M    /boot/efi/EFI
7.0M    /boot/efi
4.0K    /boot/loader/entries
4.0K    /boot/loader
2.3M    /boot/grub2/fonts
3.3M    /boot/grub2/i386-pc
5.6M    /boot/grub2
139M    /boot
[root@lixiaohui ~]# du -s /boot
141348  /boot
[root@lixiaohui ~]# du -sh /boot
139M    /boot

```

## 挂载和卸载⽂件系统

### ⼿动挂载⽂件系统

通过 mount 命令，root ⽤⼾可以⼿动挂载⽂件系统。mount 命令的第⼀个参数指定要挂载的⽂件系统。第⼆个参数指定在⽂件系统层次结构中⽤作挂载点的⽬录。

可以使⽤ mount 命令，以下列⽅式之⼀挂载⽂件系统：

1. 使⽤ /dev ⽬录中的设备⽂件名。
2. 使⽤ UUID，即设备的通⽤唯⼀标识符。

**注意** 如果使⽤ mount 命令挂载⽂件系统，之后⼜重新了启动系统，该⽂件系统不会⾃动重新挂载，需要手工挂载，在RH134课程中，我们将介绍如何处理此情况

### 识别块设备

使⽤ lsblk 命令可列出指定块设备或所有可⽤设备的详细信息

```bash
[root@lixiaohui ~]# lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
vda    252:0    0   10G  0 disk
├─vda1 252:1    0    1M  0 part
├─vda2 252:2    0  200M  0 part /boot/efi
├─vda3 252:3    0  500M  0 part /boot
└─vda4 252:4    0  9.3G  0 part /
vdb    252:16   0    5G  0 disk
└─vdb1 252:17   0    5G  0 part
vdc    252:32   0    5G  0 disk
vdd    252:48   0    5G  0 disk

```

### 使⽤分区名称挂载⽂件系统

```bash
[root@lixiaohui ~]# mount /dev/vdb1 /mnt
[root@lixiaohui ~]# df -h | grep mnt
/dev/vdb1       5.0G   68M  5.0G   2% /mnt

```

### 使⽤分区 UUID 挂载⽂件系统

```bash
[root@lixiaohui ~]# mount UUID="8599ac53-e0cc-4ca0-a3eb-233ccbcff9bd" /opt
[root@lixiaohui ~]# df -h | grep opt
/dev/vdb1       5.0G   68M  5.0G   2% /opt

```

### 卸载⽂件系统

umount 命令使⽤挂载点作为参数，以卸载⽂件系统。

```bash
[root@lixiaohui ~]# umount /mnt

```

如果挂载的⽂件系统在使⽤之中，则⽆法卸载。要成功执⾏ umount 命令，所有进程必须停⽌访问挂载点下的数据。lsof 命令可列出所有打开的⽂件，以及访问该⽂件系统的进程。此列表可以帮助识别哪些进程正在阻⽌⽂件系统被成功卸载

```bash
[root@lixiaohui opt]# lsof | grep /opt
bash       5883                          root  cwd       DIR             252,17         6        128 /opt
lsof      32373                          root  cwd       DIR             252,17         6        128 /opt
grep      32374                          root  cwd       DIR             252,17         6        128 /opt
lsof      32375                          root  cwd       DIR             252,17         6        128 /opt
[root@lixiaohui opt]# kill -9 5883

```

## 查找系统中的⽂件

1. locate 命令搜索预⽣成索引中的⽂件名或⽂件路径，并即时返回结果。此命令速度较快，因为它是从 mlocate 数据库中
查找这些信息的。但是，此数据库不会实时更新，需要频繁更新才能获得准确结果。

先更新数据库

```bash
[root@lixiaohui ~]# updatedb

```

再查询

-i 忽略大小写

-n 限制返回的搜索结果数

```bash
[root@lixiaohui ~]# locate passwd
/etc/passwd
/etc/passwd
/etc/pam.d/passwd
...
```


2. find 命令通过解析整个⽂件系统层次结构来实时搜索⽂件，此命令速度⽐ locate 命令慢，但更加准确。此外，find 命令还可以根据⽂件名以外的条件搜索⽂件，例如⽂件的权限、⽂件、⼤⼩或修改时间。

基于名称的查询

```bash
find / -name sshd_config
find / -name '*.txt'
find /etc -name '*pass*'
find / -iname '*messages*'
```

基于用户或组的查询

```bash
find -user developer
find -group developer
find -uid 1000
find -gid 1000
find / -user root -group mail
```

基于特定权限的查询，权限前⾯带有 / 或 - 符号，以控制搜索结果

1. 带有 / 符号将匹配权限集中为⽤⼾、组或其他⼈设置了⾄少⼀个权限的⽂件。具有r--r--r-- 权限的⽂件与 /222 权限不匹配，但与 rw-r--r-- 权限匹配。

2. 权限前带有 - 符号表⽰权限的所有三个部分都必须匹配。对于上⼀⽰例，具有 rw-rw-rw- 权限的⽂件将符合条件

```bash
find /home -perm 764
find /home -perm u=rwx,g=rw,o=r
find /home -perm 764 -ls
find /home -perm -324
find /home -perm -u=wx,g=w,o=r
find /home -perm /442
find /home -perm /u=r,g=r,o=w
find -perm -004
find -perm -o=r
find -perm -002
find -perm -o=w
```

基于文件大小的查询

```bash
find -size 10M
find -size +10G
find -size -10k
```

基于时间的查询

```bash
find / -mmin 120
find / -mmin +200
find / -mmin -150
```

基于文件类型的查询

```bash
find /etc -type d
find / -type l
find /dev -type b
find / -type f -links +1
```

# 第十四章 分析服务器和获取支持

## 分析和管理远程服务器

## Web 控制台

⾃红帽企业 Linux 7 起，除了最⼩安装外，所有安装中都默认安装 Web 控制台，直接启用即可

```bash
[root@lixiaohui ~]# systemctl enable --now cockpit

```

也可以用以下方式来安装

```bash
[root@lixiaohui ~]# dnf install cockpit

```

想要被外部访问到，需要在防火墙开通cockpit或者9090端口号

```bash
[root@lixiaohui ~]# firewall-cmd --add-service=cockpit --permanent
[root@lixiaohui ~]# firewall-cmd --reload

```

访问控制台可以用http://IP:9090来访问

如果root用户无法登录，可按照以下方式解除root用户限制，在编辑文件后，去掉root字样即可

```bash
[root@lixiaohui ~]# vim /etc/cockpit/disallowed-users
[root@lixiaohui ~]# systemctl restart cockpit

```

## 创建sosreport

sos 报告通常是红帽技术⽀持调查所报告问题的起点，⽤于收集红帽技术⽀持调查所报告问题所需的诊断信息。

创建报告

```bash
[root@lixiaohui ~]# sos report
Press ENTER to continue, or CTRL-C to quit.
`ENTER`
```

如果你想限制一些隐私，可以尝试sos clean

```bash
[root@lixiaohui ~]# sos clean /var/tmp/sosreport-lixiaohui-2024-02-18-ectivgc.tar.xz
```

## 红帽智能分析insights-client

```bash
[root@lixiaohui ~]# dnf install insights-client
[root@lixiaohui ~]# subscription-manager register --auto-attach
[root@lixiaohui ~]# insights-client --register

```

注册完成后，打开：https://console.redhat.com/insights在 Web UI 的 Inventory 部分下可以看到系统。

在同样的这个页面中，点击左侧的按钮，查看系统的分析和诊断信息



