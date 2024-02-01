```text
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# 仓库概述

本仓库中的模拟环境部分适用于RHCE9的模拟题部署和结果判断，仅限于本人使用，未经授权，其他人不得`使用、修改、传播`等

# RHCE9 虚拟机环境使用指南

如果你是初次上课，需要了解以下信息，请点击这里前往了解--->：[点我了解课程虚拟机环境使用指南](https://gitee.com/cnlxh/rhel/blob/master/rhce9/RHCE9.0-VMs-Usage-Guide.md)

1. 下载的资料如何使用

2. 具体的硬件需求

3. 虚拟机账号密码多少

4. 如何设置课程代码

5. 如何初始化嵌套的虚拟机

# RHCE9 模拟环境部署指南

## 准备工作

1. 恢复最开始`虚拟机自带`的快照，并使虚拟机开机

2. 下载本仓库的所有资料，下载链接如下所示，下载完名字叫`rhel-master.zip`

```bash
https://gitee.com/cnlxh/rhel/repository/archive/master.zip
 ```
3. 使用MobaXterm等工具将下载好的`rhel-master.zip`，在MobaXterm上用root身份登录foundation0后，上传到foundation虚拟机中的`/root`，MobaXterm工具下载地址如下：

```bash
https://download.mobatek.net/2362023122033030/MobaXterm_Portable_v23.6.zip
```

## RHCSA 环境部署

执行RHCSA 环境部署之前，必须已经完成准备工作

本环境对应的题目是解压后的`rh200.html`, 你`必须用`此文件中的方法做题，不然判题将出现问题

1. 在将`rhel-master.zip`上传到foundation的`/root`中后，执行解压操作

```bash
cd /root/
unzip rhel-master.zip
```

2. 开始部署EX200环境，这个过程需要较长时间，请耐心等待

```bash
cd /root/rhel-master/rhce9
bash ex200-setup.sh
```

3. 根据`rh200.html`答题完毕后，执行以下步骤进行判断对错

```bash
cd /root/rhel-master/rhce9
bash ex200-grade.sh
```

## RHCE 环境部署

注意： `请在执行RHCE 环境部署之前，重新恢复虚拟机自带的快照，并使其开机，重新完成准备工作，而不要在RHCSA的基础上执行`


本环境对应的题目是解压后的`rh294.html`, 你`必须用`此文件中的方法做题，不然判题将出现问题

1. 在将`rhel-master.zip`上传到foundation的`/root`中后，执行解压操作

```bash
cd /root/
unzip rhel-master.zip
```

2. 开始部署EX294环境，这个过程需要较长时间，请耐心等待

```bash
cd /root/rhel-master/rhce9
bash ex294-setup.sh
```

3. 根据`rh294.html`答题完毕后，执行以下步骤进行判断对错

```bash
cd /root/rhel-master/rhce9
bash ex294-grade.sh
```
