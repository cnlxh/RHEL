```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# RHCE 9.0 虚拟机环境使用指南

## 课程环境硬件需求

**此课程对内存要求较高，以下内存的表述是指，除操作系统以及操作系统平时用的软件之外，需要给虚拟机16G内存，如果操作系统平时开机后就占用很多，需要看看怎么缩减系统占用，而不要减少虚拟机的配置**

| CPU     | 内存          | 硬盘         | 操作系统                      | 软件版本                                                                                  |
| ------- | ----------- | ---------- | ------------------------- | ------------------------------------------------------------------------------------- |
| 10代i5以上 | 至少16G，推荐32G | 至少100G SSD | Windows10 x64<br>MAC Book | Windows: 至少VMware Workstaion 17<br>MAC: intel版本的Fustion，不支持任何ARM架构CPU<br>解压软件：7z解压缩软件 |

## 虚拟机账号密码

| 角色         | 账号              | 密码                |
| ---------- | --------------- | ----------------- |
| VMware虚拟机 | root<br>kiosk   | Asimov<br>redhat  |
| 所有其他虚拟机    | root<br>student | redhat<br>student |

## 准备工作

### VMware Workstation下载地址：

<mark>除非特别说明，不然请使用我们百度网盘里的版本或官网的最新版，所以请使用我们提供的版本升级你电脑上的VMware软件</mark>

我们的百度网盘已提供了此软件的最新版下载，如需自己从官方下载，可以在下面的链接自行操作

注册账号，打开以下链接选择Windows即可开始下载，此软件官方已确定对包括商用在内的场景免费，无版权问题

```textile
https://support.broadcom.com/group/ecx/productdownloads?subfamily=VMware%20Workstation%20Pro
```

### 修改VMware 虚拟机的网卡信息

为了更顺利的使用ssh工具连接虚拟机，需要在安装好VMware的情况下，将虚拟机所使用的网络修改为 `VMnet1`，并将VMnet1的网络修改为 `172.25.254.0/24` 网段

在VMware软件左上角点击 `编辑` ，点击 `虚拟网络编辑器`

![vmnetedit](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/vmnetedit.png)

默认无法修改，请点击更改设置，请在弹出框中，点击“是”

![vmnetedit](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/changeset.png)

确保选中了 `VMnet1` ，并将子网信息改为 `172.25.254.0` ， 掩码 `255.255.255.0` ，另外要注意，我们需要去掉VMnet1网卡的DHCP功能，不然后续的bastion机器无法启动会导致环境无法使用，确认都改好了之后，点击确定

![vm-network-confirm](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/vm-network-confirm.png)

至此，我们已经可以用ssh工具来远程连接我们的VMware 虚拟机了

### 导入虚拟机

你下载的资料如果是很多压缩包，例如xxx.7z之类的字眼，就解压一下，会得到VMware 的原始文件，如果是下载的VMware 原始文件，例如xxx.vmdk，在所有文件都下载完成后，执行下一步的导入操作，不管是解压的还是直接下载的，最后你都会得到一个文件夹，我们的虚拟机都从这个文件夹中导入，具体步骤如下：

打开已安装的VMware workstation软件，点击软件左上角的 `文件` ---> `打开` ，双击你得到的文件夹，找到`RHCE90.vmx`或其他名字但后缀名是 `vmx` 的文件

![menu-file-open](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/menu-file-open.png)

双击文件夹后，会看到一个 `RHCE90.vmx` 或是其他名字但后缀是 `vmx` 的文件，选中后，点击 `打开` 按钮就可以导入此虚拟机了

![open-rhce9-vm](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/open-rhce9-vm.png)

如果你的硬件较强，可以点击 `编辑虚拟机设置` 添加更多的内存和CPU，有助于你的使用体验，请注意内存至少需要分配16G，低于此配置，需要你个人测试是否可运行，低于16G内存不在红帽官方支持的范围内

我们使用VMnet1来SSH远程连接虚拟机，所以需要确保我们的虚拟机已选中VMnet1网卡，点击 `编辑虚拟机设置` 

![edit-vm-setting](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/edit-vm-setting.png)

我们需要确保选中了 `网络适配器`，设备状态处于 `启动时连接`，网络连接已勾选 `仅主机模式`，仅主机模式就是VMnet1，请务必选择这个模式，后续我们将通过此模式SSH连接虚拟机，完成后，点击 `确定` 按钮

![confirm-vmnet1-at-vm](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/confirm-vmnet1-at-vm.png)

如果配置调整完成，点击 `开启此虚拟机`

![start-vm](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/vmware/start-vm.png)

### 使用SSH 工具远程连接环境

MobaXterm工具下载地址如下：

```bash
https://download.mobatek.net/2362023122033030/MobaXterm_Portable_v23.6.zip
```

登录服务器步骤如下：

解压并打开下载好的MobaXterm软件，点击左上角的 `session` 按钮

![mobaxterm-session-on-gui](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/mobaxterm-session-on-gui.png)

选择左上角的 `SSH` ，然后确保Remote Host是 `172.25.254.250` , 已勾选Specify Username，并输入了 `kiosk` 用户名，端口号是默认的 `22` ,第一次连接会弹出窗口问你是否 `accept` ，点击 `accept` 即可

![mobaxterm-session-ssh-create](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/mobaxterm-session-ssh-create.png)

此时会问你kiosk的密码是多少，请输入小写的 `redhat` ，输入的内容不可见，请确认输入正确，输入完毕后回车即可登录，在回车后，点击 `yes` 来保存密码

![foundation-kiosk-password](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/foundation-kiosk-password.png)

## 自动初始化虚拟机环境

推荐使用此方法来初始化虚拟机环境，省时省力还省心，如果无法执行的情况下，再考虑使用下方的 `手工初始化虚拟机环境`

1. 恢复最开始`虚拟机自带`的快照，并使虚拟机开机

2. 用SSH工具连接虚拟机后，点击左侧的SFTP按钮，确认我们位于 `/home/kiosk/`，点击上传按钮，将我们下载好的 `reset-vm.sh` 上传到/home/kiosk下

![mobaxterm-sftp](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/mobaxterm/mobaxterm-sftp.png)

3. 运行自动初始化虚拟机的脚本，脚本名字叫`reset-vm.sh`

`su - root`会让你输入密码，请输入`Asimov`

```bash
su - root
```

```bash
cd /home/kiosk
bash reset-vm.sh
```

4. 设置课程并初始化虚拟机

直接在登录好的窗口中执行以下命令，来完成设置课程以及初始化虚拟机，在此过程中，会问你希望设置的课程代码是什么，请根据你的需求来设置

1. 第一本书的课程代码是 `rh124`

2. 第二本书的课程代码是 `rh134`

3. 第三本书的课程代码是 `rh294`

执行命令如下：

```bash
[kiosk@foundation0 ~]$ cd /home/kiosk
[kiosk@foundation0 ~]$ bash reset-vm.sh
Which course do you want to set:
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

以下是classroom虚拟机的操作例子，请按照此例子对所有虚拟机 `按照顺序分别` 执行reset和vmview，每台机器看到login提示符之后，才能操作下一个机器的reset和vmview

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

classroom必须先reset开机，然后依次类推，需要按照顺序，将其他虚拟机reset开机，具体顺序为：

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
