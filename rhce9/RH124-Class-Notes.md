
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

1. 超级⽤⼾

超级⽤⼾的名称为 root，其帐⼾的 UID 为 0，拥有所有权限

2. 系统⽤⼾

系统⽤⼾帐⼾供提供⽀持服务进程使⽤，一般不具有特权，⽤⼾⽆法使⽤系统⽤⼾帐⼾以交互⽅式登录

3. 普通⽤⼾

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

系统使⽤ /etc/passwd ⽂件存储有关本地⽤⼾的信息，该⽂件划分为七个以冒号分隔的字段

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

系统使⽤ /etc/group ⽂件存储有关本地组的信息，每个组条⽬被分为四个以冒号分隔的字段

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

补充组中的成员资格存储在 /etc/group ⽂件中。根据所在的组是否具有访问权限，将授予⽤⼾对⽂件的访问权限，不论这些组是主要组还是补充组

```text
我是IT部的人，所以我同时属于我的私有组lixiaohui，也属于IT部门，还属于公司全员
```

此时权限的分配变得简单，只需要分配到IT部门，我就会获得权限

## 获取超级用户访问权限

Linux 上的 root 帐⼾类似于 Microsoft Windows 上的本地 Administrator 帐⼾，。⼀旦 root ⽤⼾帐⼾被盗，系统将处于危险之中，所以我们不给用户超级用户权限，但是有时候一部分特权工作需要用户完成，例如HR需要执行useradd创建用户，此时HR将会用到下方的切换用户的方法

### su 直接切换身份

使用su - USERNAME的方法切换到目标用户身份下，普通用户的切换需要提供目标密码，而root用户切换无需密码

如果su后面省略⽤⼾名，则默认情况下会尝试切换到 root

```bash
[lixiaohui@host1 ~]$ su - lxh
Password:
[root@foundation0 ~]# su - lxh
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

**su、su - 和 sudo 命令之间的区别**

![su-su--sudo](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/rh124/su-su-sudo.png)

普通用户不具有用户创建权限

```bash
[lixiaohui@host1 ~]$ useradd zhangsan
useradd: Permission denied.
useradd: cannot lock /etc/passwd; try again later.

```

用root权限，授予lixiaohui用户可以创建用户和删除用户权限

先查询用户创建和删除的命令位置

```bash
[root@foundation0 ~]# which useradd
/usr/sbin/useradd
[root@foundation0 ~]# which userdel
/usr/sbin/userdel

```

**sudo 授权**

以下授权允许lixiaohui用户可以sudo运行useradd和userdel命令，但是不允许用sudo的方式运行ls命令
```bash
[root@foundation0 ~]# vim /etc/sudoers
[root@foundation0 ~]# tail -n 1 /etc/sudoers
lixiaohui    ALL=(ALL)       /usr/sbin/useradd,/usr/sbin/userdel,!/bin/ls

```

以下授权允许lixiaohui用户可以sudo运行所有命令，且不需要密码

```bash
[root@foundation0 ~]# vim /etc/sudoers
[root@foundation0 ~]# tail -n 1 /etc/sudoers
lixiaohui       ALL=(ALL)       NOPASSWD: ALL

```
我们注意，在userdel时失败了一次，因为没有sudo命令开始，不经过我们的授权验证

```bash
[root@foundation0 ~]# su - lixiaohui
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

