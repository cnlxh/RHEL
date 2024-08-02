# 扩容Linux根分区大小

```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

今天遇到一台Linux的虚拟机根分区的容量不够，记录一下扩容根分区的过程

# 查询现有根分区大小

先查询现在根分区大小

```bash
df -h
```

从下图来看，根分区很小只有50G，而且已经用了85%了

```text
Filesystem                         Size  Used Avail Use% Mounted on
...
/dev/mapper/rhel_foundation0-root   50G   43G  7.7G  85% /
...
```

# 添加新的硬盘到虚拟机中

先将虚拟机正常关机，然后执行下面的添加硬盘操作

在VMware workstation的顶栏菜单中，点击虚拟机--->设置--->添加--->硬盘

在添加硬盘的过程中，除了硬盘大小，一切保持默认即可，大小处我输入了500G

将虚拟机开机

# 将新加的硬盘加入vg

查询新加的硬盘

```bash
lsblk
```

看出我的新硬盘名称是nvme0n2

```text
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
...
nvme0n2                   259:3    0   500G  0 disk
...
```

扩容vg

```bash
vgs
```
输出
```text
  VG               #PV #LV #SN Attr   VSize    VFree
  rhel_foundation0   1   3   0 wz--n- <499.00g    0
```

扩容

```bash
vgextend rhel_foundation0 /dev/nvme0n2
```
从输出看，VG已成功扩容
```text
  Physical volume "/dev/nvme0n2" successfully created.
  Volume group "rhel_foundation0" successfully extended
```

查询新的vg大小已增加

```bash
vgs
```
输出
```text
  VG               #PV #LV #SN Attr   VSize   VFree
  rhel_foundation0   2   3   0 wz--n- 998.99g <500.00g
```

扩容根分区所在的lv，注意不要遗漏最后-r参数，不然你还得单独扩容文件系统

```bash
lvextend /dev/rhel_foundation0/root -L +400G -r
```

从输出看，lv已成功扩容
```text
  Size of logical volume rhel_foundation0/root changed from 50.00 GiB (12800 extents) to 450.00 GiB (115200 extents).
  Logical volume rhel_foundation0/root successfully resized.
meta-data=/dev/mapper/rhel_foundation0-root isize=512    agcount=4, agsize=3276800 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1
data     =                       bsize=4096   blocks=13107200, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=6400, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 13107200 to 117964800
```
# 确认扩容效果

```bash
df -h
```

从输出看，已成功扩容

```text
Filesystem                         Size  Used Avail Use% Mounted on
...
/dev/mapper/rhel_foundation0-root  450G   46G  405G  11% /
```

