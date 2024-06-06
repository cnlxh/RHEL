```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# 将培训环境制作成物理机的方法

**注意事项**

**此内容不属于培训内容，所以不提供任何指导帮助，需要自己动手能力强一些**

**这个过程中，默认会清空这个电脑的所有资料，请备份好之后再安装，如果有丢失电脑资料，请自行负责**

**如果需要修改默认清空电脑的情况，可以在Windows磁盘管理器中压缩出一个较大的空闲空间出来，单独用于安装培训环境，但这需要在用U盘安装时，注意分区的选择，在这块空闲的空间上划分Linux用的分区，务必确认没有删除和格式化自己的数据盘，避免造成数据丢失**


RedHat Linux培训的时候，一般来说是提供基于`VMware workstation` 之类的虚拟机，有些课程`要求的内存比较多`，如果再使用虚拟化的话，`Windows以及Windows上的软件`本身也`会占用很多内存`，再加上`虚拟化的性能损耗`，可能会导致`环境运行异常`，本文档主要是描述如何将RedHat的培训环境`部署成物理机`，让环境直接运行在物理机上，可能带来更好的体验，本次演示以`RH124`课程举例

## 基本流程

以下是大概的步骤：

1. 获得RedHat培训的课程源文件

2. 制作foundation U盘

3. 用U盘在物理机上部署foundation0

4. 将相关课程部署到foundation0

5. 激活当前课程

## 获取源文件

一般来说，只要是`正规的红帽授权培训讲师`，都会有源文件，找讲师要即可

## 制作foundation U盘

**U盘大小的要求**

一般来说，要求U盘具有`16G`大小，`不能低于16G`，因为`RHEL9`操作系统本身就已经很大了

**制作流程**

1. 准备资料

随便开一个Linux虚拟机，推荐使用培训分发的VMware虚拟机，然后将foundation的文件上传到虚拟机中，本次我已将资料上传到`/mnt/hgfs/Downloads`中，当然别的地方也可以，自己记得就行，以下所有流程都使用`root权限`

![filelist](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/create-physical-machine/filelist.png)

2. 准备资料仓库

确认在`root家目录`中存在`/root/.icrm/config.yml`配置文件，复制粘贴以下代码即可

```bash
mkdir /root/.icrm
cat > /root/.icrm/config.yml <<EOF
---
repository: /mnt/hgfs/Downloads
EOF
```

3. 验证资料的完整性

使用上传资料中`rht-usb`开头的工具对源文件中`icmf文件`执行`verify`验证操作

不同课程的icmf文件的文件名是不一样的，请仔细观察文件名并替换命令参数

如果你也把课程资料上传了，就对所有课程资料的icmf文件也进行验证，看看校验和是否正确

```bash
[root@lixiaohui ~]# cd /mnt/hgfs/Downloads/
[root@lixiaohui Downloads]# ./rht-usb-9.x-7.r2023060817git06dcedc verify RHCIfoundation-RHEL90-7.r2023060817-ILT-7-en_US.icmf
```
如下图所示，我的文件最终验证都是成功的，就可以做U盘了

![rht-verify](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/create-physical-machine/rht-verify.png)

4. 格式化U盘

**需要注意，格式化U盘会丢失所有资料**

用`lsblk`命令确定U盘的名称，我的U盘名为/dev/sda4

![udisk-name](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/create-physical-machine/udisk-name.png)

使用rht-usb的命令格式化U盘

这一步，你要自己知道自己电脑是基于`MBR BIOS`启动的，还是基于`GPT`启动的，只需要选一个即可

**基于BIOS/Legacy启动的格式化方法**

```bash
[root@lixiaohui ~]# cd /mnt/hgfs/Downloads/
[root@lixiaohui Downloads]# ./rht-usb-9.x-7.r2023060817git06dcedc usbformat /dev/sda4
```
![udisk-format](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/create-physical-machine/udisk-format.png)

**基于GPT启动的格式化方法**

基于GPT启动的电脑，需要创建EFI系统分区U盘才能启动，所以这一步需要先用下面的步骤在U盘上划分GPT分区

```bash
[root@lixiaohui ~]# cd /mnt/hgfs/Downloads/
[root@lixiaohui Downloads]# ./rht-usb-9.x-7.r2023060817git06dcedc usbmkpart /dev/sda gpt
INFO     Configuration file: /root/.icrm/config.yml
INFO     Partitioning USB Device: /dev/sda
Confirm gpt partitioning /dev/sda (y/N) y
Wipe existing partitioning of /dev/sda (y/N) y
INFO     /dev/sda: wipefs OK
INFO     /dev/sda: zap partitions OK
Exhaustive zeroing of /dev/sda (recommended, not required) (y/N) n
INFO     /dev/sda: wipe partitions OK
INFO     /dev/sda: partitioning OK
INFO     /dev/sda1: apparent RHTINST partition
INFO     Now run usbformat of /dev/sda1
INFO     Appear to have properly partitioned USB device.
INFO     usbmkpart completed.
```

![usbmkpart-gpt](https://gitee.com/cnlxh/rhel/raw/master/rhce9/images/create-physical-machine/usbmkpart-gpt.png)

分辨哪个是EFI，哪个是可以放资料的分区

从大小就可以很容易看出`sda1`是可以放资料的分区

```bash
[root@lixiaohui Downloads]# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                         8:0    1 29.3G  0 disk
├─sda1                      8:1    1 29.1G  0 part
└─sda2                      8:2    1  200M  0 part
```

**格式化sda1**

如果有任何问询，请用`y`回复
```bash
[root@lixiaohui Downloads]# ./rht-usb-9.x-7.r2023060817git06dcedc usbformat /dev/sda1
```

5. 将foundation资料添加到U盘中

这一步可能需要较长的时间，耐心等待

如果添加成功，会提示`usbadd completed`，然后会使U盘可启动，请在问询中使用`y`进行回应


```bash
[root@lixiaohui ~]# cd /mnt/hgfs/Downloads/
[root@lixiaohui Downloads]# ./rht-usb-9.x-7.r2023060817git06dcedc usbadd RHCIfoundation-RHEL90-7.r2023060817-ILT-7-en_US.icmf
...
WARNING - You get to keep all the pieces if system becomes unbootable
WARNING - We really mean it - do not cry to us if your system is destroyed
Confirm writing to /dev/sda4 mounted to /tmp/tmp4agstop1 `(y/N) y`
INFO     Making bootable: /tmp/tmp4agstop1
...
```

需要注意的是在`usbadd completed`之后触发的U盘可启动功能有可能`由于Linux系统本身缺少软件包而失败`，目前已知的经常报错的软件包为: `syslinux-extlinux`，需要仔细观察输出，如果失败，U盘就无法引导，如果报错，可以`安装好报错的软件包`之后，再运行以下命令使U盘可引导

```bash
[root@lixiaohui Downloads]# ./rht-usb-9.x-7.r2023060817git06dcedc usbmkboot
```


至此，这一台用于做U盘的Linux就可以关机了，所有需要它的任务都已经完成

## 用U盘在物理机上部署foundation0

调整自己电脑的BIOS，从U盘启动，正常完成安装，整个过程你只需要选择一下时区为`亚洲/上海`，新手请勿修改其他任何设置

**格外注意**

**这个过程中，默认会清空这个电脑的所有资料，请备份好之后再安装，如果有丢失电脑资料，请自行负责**

**默认会分配较大的/home分区，这种情况下有些课程会导致`/` 根分区空间不够，推荐选择自行分区，将大部分空间给`/` 分区，经过测试，其实只划分`/` `/boot` `swap` 就够了**

**综上所述，你只能修改`时区`、`分区`**

将U盘插入新电脑，从U盘启动后，如果本来就有引导菜单，选择类似`f0` 、 `Fresh instructor` 之类的字眼即可，如果没有引导菜单，是一个`boot:` 提示符，就输入`f0`然后回车，然后就会开始引导，出现系统配置界面，根据需求完成硬盘分区(可选)、上海时区的设置，其他保持默认，点击开始安装，这个安装过程比较长，而且在此过程中，会有黑屏跑脚本的过程，耐心等待，直到提示你reboot按钮，点一下reboot进入系统

## 将相关课程部署到foundation0

前面已经完成了foundation0的安装，以下所有操作都是基于foundation0

将课程文件上传到/mnt/hgfs/Downloads中，当然别的地方也可以，自己记得就行

`kiosk密码为redhat`

`root密码为Asimov`

切换到root身份

```bash
[kiosk@foundation0 ~]$ su - root
```

准备配置文件

```bash
mkdir /root/.icrm # 这一步报告已经存在也不要紧，下一步的yml文件写入成功就行
cat > /root/.icrm/config.yml <<EOF
---
repository: /mnt/hgfs/Downloads
EOF
```

**添加课程**

在usbadd之前，也可以像前面一样，对课程文件icmf文件进行校验和的验证

每一门课程的icmf文件名不同，需要注意

```bash
[root@foundation0 ~]# rht-usb copy /mnt/hgfs/Downloads/RH124-RHEL9.0-5.r2023051908-ILT+RAV-7-en_US.icmf
```

## 激活当前课程

以下设置为rh124课程

```bash
[root@foundation0 ~]# rht-setcourse rh124
```

