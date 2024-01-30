
```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# RHCE 9.0 虚拟机环境使用指南

## 虚拟机账号密码

|角色|账号|密码|
|-|-|-|
|foundation|root<br>kiosk|Asimov<br>redhat|
|所有其他虚拟机|root<br>student|redhat<br>student|

## 准备工作

### VMware Workstation下载地址：

将链接复制到浏览器，即可自动开始下载，另外此为付费软件，可试用，本次课程使用试用版，如有必要，请支持正版

```textile
https://www.vmware.com/go/getworkstation-win
```
### 修改VMware 虚拟机的网卡信息

为了更顺利的使用ssh工具连接虚拟机，需要在安装好VMware的情况下，将虚拟机所使用的网络修改为 `VMnet1`，并将VMnet1的网络修改为 `172.25.254.250/24` 网段

在VMware软件左上角点击 `编辑` ，点击 `虚拟网络编辑器`

![vmnetedit](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/vmnetedit.png)

默认无法修改，请点击更改设置，请在弹出框中，点击“是”

![vmnetedit](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/changeset.png)

确保选中了 `VMnet1` ，并将子网信息改为 `172.25.254.250` ， 掩码 `255.255.255.0` 点击确定

![vm-network-confirm](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/vm-network-confirm.png)

至此，我们已经可以用ssh工具来远程连接我们的VMware 虚拟机了

## 自动初始化虚拟机环境

推荐使用此方法来初始化虚拟机环境，省时省力还省心，如果无法执行的情况下，再考虑使用下方的 `手工初始化虚拟机环境`

1. 恢复最开始`虚拟机自带`的快照，并使虚拟机开机

2. 下载自动初始化虚拟机的脚本，下载链接如下，直接用你的下载工具下载，下载完名字叫`reset-vm.sh`

```bash
https://gitee.com/cnlxh/rhel/raw/master/reset-vm.sh
 ```
3. 使用MobaXterm等工具将下载好的`reset-vm.sh`上传到foundation0上，在MobaXterm上用`kiosk`身份登录foundation0后，上传到foundation虚拟机中的`/home/kiosk/`

MobaXterm工具下载地址如下：

```bash
https://download.mobatek.net/2362023122033030/MobaXterm_Portable_v23.6.zip
```

登录和上传步骤如下：

解压并打开下载好的MobaXterm软件，点击左上角的 `session` 按钮

![mobaxterm-session-on-gui](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/mobaxterm-session-on-gui.png)

选择左上角的 `SSH` ，然后确保Remote Host是 `172.25.254.250` , 已勾选Specify Username，并输入了 `kiosk` 用户名，端口号是默认的 `22` ,第一次连接会弹出窗口问你是否 `accept` ，点击 `accept` 即可

![mobaxterm-session-ssh-create](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/mobaxterm-session-ssh-create.png)

此时会问你kiosk的密码是多少，请输入小写的 `redhat` ，输入的内容不可见，请确认输入正确，输入完毕后回车即可登录，在回车后，点击 `yes` 来保存密码

![foundation-kiosk-password](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/foundation-kiosk-password.png)

点击左侧的SFTP按钮，确认我们位于 `/home/kiosk/`，点击上传按钮，将我们下载好的 `reset-vm.sh` 上传到/home/kiosk下

![mobaxterm-sftp](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/mobaxterm-sftp.png)

4. 设置课程并初始化虚拟机

直接在登录好的窗口中执行以下命令，来完成设置课程以及初始化虚拟机，在此过程中，会问你希望设置的课程代码是什么，请根据你的需求来设置

  1. 第一本书的课程代码是 `rh124`

  2. 第二本书的课程代码是 `rh134`

  3. 第三本书的课程代码是 `rh294`

执行命令如下：

```bash
cd /home/kiosk
bash reset-vm.sh
```

## 手工初始化虚拟机环境

开启解压后导入到VMware的虚拟机，输入`kiosk`用户的密码`redhat`之后，需要根据课程进度设置课程代码：

1. 第一本书的课程代码是 `rh124`

2. 第二本书的课程代码是 `rh134`

3. 第三本书的课程代码是 `rh294`

请根据课程进度自行设置课程代码，`记得每次设置课程代码之前，需要恢复虚拟机自带的VMware快照`

### 设置课程代码

设置课程代码为rh124(第一本书)的示例如下：

用kiosk身份(密码redhat)登录虚拟机，在桌面上右击，并点击左下角画线处的“Open in Terminal”打开终端，或者点击左上角的 `Activities`，点击黑色的terminal窗口都可以

![open-in-terminal](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vm-usage-guide/open-in-terminal.png)

并在终端中输入rht-setcourse rh124即可设置课程为第一本书，第二本书为 `rh134` ，第三本书为 `rh294`

![set-to-rh124](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vm-usage-guide/set-to-rh124.png)

### 注意事项

如下图所示，不推荐使用`rht-vmctl status all` 这个命令，此命令显示为 `RUNNING` 或者 `MISSING` 或者任何其他所有状态，`都不代表环境正常`，必须通过以下方法去 rht-vmview，而且在reset时机器启动是有先后顺序的，顺序不对也会导致环境不正常，需要重新按照顺序重置。

以下为错误示范，不管你执行后显示什么，都不能说明任何问题，纯浪费时间

![reset-all](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vm-usage-guide/reset-all.png)

注意每本书第一章前面的课堂环境介绍，以下内容有先后顺序，reset的时候 `请务必按照顺序` 

### 初始化虚拟机

以下是classroom虚拟机的操作例子，请按照此例子对所有虚拟机执行reset和vmview

执行以下命令让 classroom 开机

```bash
rht-vmctl reset classroom -q
```

![reset-classroom](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vm-usage-guide/reset-classroom.png)

执行以下命令确认系统已经启动之后才可以开始执行下一条命令，启动可能较慢，多等待一下，`必须看到` 下图划线的登录提示，看到之前不要继续往下操作

```bash
rht-vmview view classroom
```
![confirm-classroom](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vm-usage-guide/confirm-classroom.png)

classroo必须先reset开机，然后依次类推，需要按照顺序，将其他虚拟机开机，具体顺序为：

1. bastion

2. utility

3. workstation

4. servera

5. serverb

**注意事项：**

1. bastion 和 utility关联

其中在执行 `rht-vmctl reset bastion -q` 后，再次执行rht-vmview `不一定` 能看到login提示符，只有这一台可以忽略这个现象，因为bastion依赖utility机器，在后期utility被reset后，bastion会自动恢复正常

2. serverc serverd只有在rh294课程中出现

在将课程代码设置为rh124 rh134后，serverc和serverd是不存在的，只有将课程代码设置为rh294才会出现

