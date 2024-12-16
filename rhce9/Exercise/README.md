```text
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# 仓库概述

本仓库中的模拟环境部分适用于RHCE9的模拟题部署和结果判断，仅限于本人使用，未经授权，其他人不得`使用、修改、传播`等

# RHCE9 虚拟机环境使用指南

如果你是初次上课，需要了解以下信息，请阅读`课程虚拟机环境使用指南`

1. 下载的资料如何使用

2. 具体的硬件需求

3. 虚拟机账号密码多少

4. 如何设置课程代码

5. 如何初始化嵌套的虚拟机

# RHCE9 模拟环境部署指南

## 准备工作

1. 恢复最开始`虚拟机自带`的快照，并使虚拟机开机

2. 使用MobaXterm等工具将Exercise.zip上传到foundation0中  ，在MobaXterm上用kiosk身份登录foundation0后，上传到foundation虚拟机中的`/home/kiosk`，MobaXterm工具下载地址如下：

```bash
https://download.mobatek.net/2402024022512842/MobaXterm_Portable_v24.0.zip
```

登录服务器步骤如下：

解压并打开下载好的MobaXterm软件，点击左上角的 `session` 按钮

![mobaxterm-session-on-gui](https://gitee.com/cnlxh/images/raw/master/mobaxterm/mobaxterm-session-on-gui.png)

选择左上角的 `SSH` ，然后确保Remote Host是 `172.25.254.250` , 已勾选Specify Username，并输入了 `kiosk` 用户名，端口号是默认的 `22` ,第一次连接会弹出窗口问你是否 `accept` ，点击 `accept` 即可

![mobaxterm-session-ssh-create](https://gitee.com/cnlxh/images/raw/master/mobaxterm/mobaxterm-foundation-session-ssh-create.png)

此时会问你kiosk的密码是多少，请输入小写的 `redhat` ，输入的内容不可见，请确认输入正确，输入完毕后回车即可登录，在回车后，点击 `yes` 来保存密码

![foundation-kiosk-password](https://gitee.com/cnlxh/images/raw/master/mobaxterm/foundation-kiosk-password.png)

切换到`root`用户，输入`Asimov`密码

```bash
su - root
```

3. 点击左侧的SFTP按钮，确认我们位于 `/home/kiosk/`，点击上传按钮，将我们准备的 `Exercise.zip` 上传到/home/kiosk下

![mobaxterm-sftp](https://gitee.com/cnlxh/images/raw/master/mobaxterm/mobaxterm-kiosk-sftp.png)

## RHCSA 环境部署

执行RHCSA 环境部署之前，必须已经完成准备工作

本环境对应的题目是解压后的`rh200.md`, 在本次模拟中，衡量的角度有限，你`必须用`此文件中的方法做题，不然模拟判题将出现问题，正式考试中，不限制做题思路，只要你只要达到题目效果即可

1. 在将`Exercise.zip`上传到foundation的`/home/kiosk`中后，切换到root身份并解压
   
   ```bash
   su - #，不要忘了su后面的中横杠, 请输入Asimov作为密码
   cd /home/kiosk
   unzip Exercise.zip
   ```

2. 开始部署EX200环境，这个过程需要较长时间，请耐心等待

```bash
cd /home/kiosk/Exercise
bash rhcsa-exam-setup.sh
```

3. 根据`rh200.md`答题完毕后，执行以下步骤进行判断对错

```bash
cd /home/kiosk/Exercise
bash rhcsa-exam-grade.sh
```

## RHCE 环境部署

注意： `请在执行RHCE 环境部署之前，重新恢复虚拟机自带的快照，并使其开机，重新完成准备工作，而不要在RHCSA的基础上执行`

本环境对应的题目是解压后的`rh294.md`,  在本次模拟中，衡量的角度有限，你`必须用`此文件中的方法做题，不然模拟判题将出现问题，正式考试中，不限制做题思路，只要你只要达到题目效果即可

1. 在将`Exercise.zip`上传到foundation的`/home/kiosk`中后，切换到root身份并解压
   
   ```bash
   su #请输入Asimov作为密码
   cd /home/kiosk
   unzip Exercise.zip
   ```

2. 开始部署EX294环境，这个过程需要较长时间，请耐心等待

```bash
cd /home/kiosk/Exercise
bash rhce-exam-setup.sh
```

3. 根据`rh294.md`答题完毕后，执行以下步骤进行判断对错

```bash
cd /home/kiosk/Exercise
bash rhce-exam-grade.sh
```
