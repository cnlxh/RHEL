
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

