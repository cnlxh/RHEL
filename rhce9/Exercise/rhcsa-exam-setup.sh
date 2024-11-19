#!/bin/bash
####################################################################
# create for servera
# created by Xiaohui Li
# contact me via wechat: Lxh_Chat
# self test only, please do not use it on production or others

orgserveraip=172.25.250.10
serveraip=172.25.250.111
serverbip=172.25.250.11

function servera_sshpasscmd {
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$1 $2
}

function pass {
  echo -ne "\033[32m PASS \033[0m\t"
}

function fail {
  echo -ne "\033[31m FAIL \033[0m\t"
}
function prepare_network_hostsfile {
ssh root@servera "nmcli connection modify 'System eth1' con-name 'Wired connection 2'"
ssh root@servera "nmcli connection modify 'Wired connection 2' ipv4.method manual ipv4.addresses 172.25.250.111/24 ipv4.gateway 172.25.250.254 ipv4.dns 172.25.250.220 connection.autoconnect yes" &> /dev/null
ssh root@servera "nmcli connection modify 'Wired connection 2' con-name 'Do-not-modify'" &> /dev/null
ssh root@servera "nmcli connection down 'Wired connection 2';nmcli connection up 'Wired connection 2'" &> /dev/null
ssh root@servera "nmcli connection down 'Do-not-modify';nmcli connection up 'Do-not-modify'" &> /dev/null
ssh root@$serveraip "chattr +i /etc/NetworkManager/system-connections/'Wired connection 2.nmconnection'" &> /dev/null

sed -i 's/^172.25.250.10/172.25.250.100/g' /etc/hosts &> /dev/null
cat > /tmp/hosts <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
172.25.254.254 classroom.example.com
172.25.250.100 servera.lab.example.com servera
172.25.250.11 serverb.lab.example.com serverb
EOF
scp /tmp/hosts root@$serveraip:/etc/ &> /dev/null
scp /tmp/hosts root@$serverbip:/etc/ &> /dev/null
rm -rf /tmp/hosts
}
function network-q1 {
    while true;do ssh root@$orgserveraip ls &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
            break
        fi
    done
    ssh root@$serveraip "nmcli connection modify 'Wired connection 1' ipv4.method auto ipv4.addresses 1.1.1.1/24 ipv4.gateway 1.1.1.1 ipv4.dns 1.1.1.1 connection.autoconnect no" &> /dev/null
    ssh root@$serveraip "nmcli connection down 'Wired connection 1 -w 5'" &> /dev/null
    ssh root@$serveraip "hostnamectl hostname lixiaohui" &> /dev/null
    if `ssh root@$serveraip "nmcli connection show 'Do-not-modify'" | grep -q '172.25.250.111'`;then
        pass && echo "Q1 网络设置成功"
    else
        fail && echo "Q1 网络设置失败"
    fi
}
function repository-q2 {
    ssh root@$serveraip "mv /etc/yum.repos.d/* /opt/" &> /dev/null
    if ssh root@$serveraip "ls /etc/yum.repos.d/ | wc -l" | grep -q 0;then
        pass && echo Q2 "仓库清除成功"
    fi
}
function selinux-q3 {
    ssh root@$serveraip "mv /opt/* /etc/yum.repos.d/" &> /dev/null
    ssh root@$serveraip "dnf install httpd -y &> /dev/null"
    ssh root@$serveraip "echo EX200 Testing > /var/www/html/file1"
    ssh root@$serveraip "echo EX200 Testing > /var/www/html/file2"
    ssh root@$serveraip "echo EX200 Testing > /var/www/html/file3"
    ssh root@$serveraip "restorecon -RvF /var/www &> /dev/null"
    ssh root@$serveraip "semanage fcontext -a -t default_t '/var/www/html/file1' &> /dev/null"
    ssh root@$serveraip "restorecon -RvF /var/www/html/file1 &> /dev/null"
    ssh root@$serveraip "sed -i 's/^Listen.*/Listen 82/' /etc/httpd/conf/httpd.conf"
    ssh root@$serveraip 'systemctl disable httpd &> /dev/null'
    if ! ssh root@$serveraip "rpm -q httpd" > /dev/null; then
        fail && echo "Q3 httpd 安装失败"
    elif ! ssh root@$serveraip "grep -q 'EX200 Testing' /var/www/html/file{1,2,3}"; then
        fail && echo "Q3 EX200 Testing字符串file123"
    elif ! ssh root@$serveraip "grep -q 'Listen 82' /etc/httpd/conf/httpd.conf"; then
        fail && echo "Q3 Listen 82 not in httpd.conf"
    else
        pass && echo "Q3 调试 SELinux"

    fi
}

function ntp_set {
    ssh root@$serveraip 'sed -i 's/172.25.254.254/_default/g' /etc/chrony.conf' &> /dev/null
    if ssh root@$serveraip "grep -qw 'server _default iburst' /etc/chrony.conf"; then
        pass && echo Q7 NTP 配置文件已准备好
    fi
}

function autofs-q8 {
    ssh root@classroom mkdir -p /rhome/remoteuser1 &> /dev/null
    ssh root@classroom chmod 777 /rhome -R
    ssh root@classroom 'semanage fcontext -a -t public_content_t "/rhome(/.*)?"' &> /dev/null
    ssh root@classroom restorecon -RF /rhome
    ssh root@classroom "echo '/rhome *(rw)' > /etc/exports.d/autofs.exports"
    ssh root@classroom systemctl enable nfs-server --now &> /dev/null
    ssh root@classroom exportfs -rav &> /dev/null
    ssh root@$serveraip useradd -M -d /rhome/remoteuser1 remoteuser1 &> /dev/null
    ssh root@$serveraip 'echo flectrag | passwd --stdin remoteuser1' &> /dev/null
    if ! showmount -e classroom | grep -q rhome; then
        fail && echo "Q8 classroom nfs部署失败"
    elif ! ssh root@$serveraip "grep -q '/rhome/remoteuser1' /etc/passwd"; then
        fail && echo "Q8 remoteuser1 密码设置失败"
    else
        pass && echo "Q8 配置 autofs"
    fi
}
function findfile-q10 {
    ssh root@$serveraip useradd jacques &> /dev/null
    ssh root@$serveraip 'echo flectrag | passwd --stdin jacques' &> /dev/null
    ssh root@$serveraip touch /home/jacques/gamelan &> /dev/null
    ssh root@$serveraip touch /home/jacques/jacques &> /dev/null
    ssh root@$serveraip touch /home/jacques/libWedgeit.so.1.2.3 &> /dev/null
    ssh root@$serveraip chown jacques /home/jacques -R &> /dev/null
    if ! ssh root@$serveraip grep -q jacques /etc/passwd; then
        fail && echo "Q10 jacques 用户创建失败"
    elif ! ssh root@$serveraip "ls -l /home/jacques | grep -q jacques"; then
        fail && echo "Q10 jacques没有任何文件"
    else
        pass && echo "Q10 查找文件"
    fi
}
function findchar-q11 {
    ssh root@$serveraip dnf install iso-codes -y &> /dev/null
    if ! ssh root@$serveraip dnf list installed | grep -q iso-codes; then
        fail && echo "iso-codes安装失败"
    else
        pass && echo "Q11 查找字符串"
    fi
}
function tar-q12 {
    ssh root@$serveraip touch /usr/local/bzip2filetest &> /dev/null
    pass && echo "Q12 创建存档" 
}
function podman-q13 {
    ssh root@$serveraip useradd -G wheel wallah &>/dev/null
    ssh root@$serveraip 'echo flectrag | passwd --stdin wallah' &> /dev/null
    ssh root@$serveraip 'sed -i "s/^%wheel.*/%wheel        ALL=(ALL)       NOPASSWD: ALL/g" /etc/sudoers'
    ssh root@$serveraip dnf -y install container-tools &>/dev/null
    ssh root@$serveraip mkdir -p /home/wallah/.config/containers &>/dev/null
    ssh root@$serveraip dnf -y install container-tools &>/dev/null

cat > /tmp/Containerfile <<EOF
FROM registry.lab.example.com/ubi9-beta/ubi:latest
RUN mkdir /dir{1,2}
RUN echo -e '[rhel-9.3-for-x86_64-baseos-rpms]\nbaseurl = http://content.example.com/rhel9.3/x86_64/dvd/BaseOS\nenabled = true\ngpgcheck = false\nname = Red Hat Enterprise Linux 9.3 BaseOS (dvd)\n[rhel-9.3-for-x86_64-appstream-rpms]\nbaseurl = http://content.example.com/rhel9.3/x86_64/dvd/AppStream\nenabled = true\ngpgcheck = false\nname = Red Hat Enterprise Linux 9.3 Appstream (dvd)'>/etc/yum.repos.d/rhel_dvd.repo
RUN yum install --disablerepo=* --enablerepo=rhel-9.3-for-x86_64-baseos-rpms --enablerepo=rhel-9.3-for-x86_64-appstream-rpms -y python3
CMD ["/bin/bash", "-c", "sleep infinity"]
EOF
scp /tmp/Containerfile root@classroom:/var/www/html/ &>/dev/null
ssh root@classroom systemctl restart httpd
rm -rf /tmp/Containerfile

ssh root@$serveraip 'cat > /home/wallah/.config/containers/registries.conf <<EOF
unqualified-search-registries = ["registry.lab.example.com"]
[[registry]]
insecure = true
blocked = false
location = "registry.lab.example.com"
EOF'
ssh root@$serveraip chown wallah /home/wallah -R &>/dev/null
    if ! ssh root@$serveraip id wallah | grep -q wheel; then
        fail && echo "Q13 wheel组中没有wallah"
    elif ! ssh root@$serveraip "grep '%wheel' /etc/sudoers | grep -i -q NOPASSWD"; then
        fail && echo "Q13 wheel的sudoersNOPASSWD设置失败"
    elif ! curl -s http://classroom/Containerfile | grep -q "ubi9-beta"; then
        fail && echo "Q13 Containerfile下载失败"
    elif ! ssh root@$serveraip dnf list installed | grep -q "container-tools"; then
        fail && echo "Q13 container-tools安装失败" 
    else
        pass && echo "Q13 创建一个容器镜像"
    fi
}
function podman-q14 {
    ssh root@$serveraip mkdir -p /opt/file/optfiletest &> /dev/null
    ssh root@$serveraip mkdir -p /opt/progress/progressfiletest &> /dev/null
    ssh root@$serveraip chown wallah /opt -R &> /dev/null
    if ! ssh root@$serveraip ls /opt | grep -qE 'file|progress'; then
        fail && echo "Q14 文件没有准备好"
    else
        pass && echo "Q14 将容器配置为服务"
    fi
}


function script-16d {
    ssh root@$serveraip "dd if=/dev/zero of=/usr/16d.txt bs=1M count=9" &> /dev/null
    ssh root@$serveraip "chmod g=xs /usr/16d.txt" &> /dev/null
    if ssh root@$serveraip "test -f /usr/16d.txt" &> /dev/null;then
        pass && echo "Q16D 创建脚本"
    else
        fail && echo "Q16D /usr/16d.txt文件没有准备好"
    fi
}

function script-16e {
    ssh root@$serveraip "dd if=/dev/zero of=/usr/16e.txt bs=40k count=1" &> /dev/null
    ssh root@$serveraip "chmod u=xs /usr/16e.txt" &> /dev/null
    if ssh root@$serveraip "test -f /usr/16e.txt" &> /dev/null;then
        pass && echo "Q16E 创建脚本"
    else
        fail && echo "Q16E /usr/16e.txt文件没有准备好"
    fi
}


function servera-netowrk-auto {
    ssh root@$serveraip "mv /etc/yum.repos.d/* /opt/" &> /dev/null
    ssh root@$serveraip 'rm -rf /etc/yum.repos.d/*' &> /dev/null
    ssh root@$serveraip "reboot" &> /dev/null
}






####################################################################
# create for serverb
function prepare_serverb {
    rht-vmctl poweroff serverb -q &> /dev/null
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-c.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-d.qcow2
    virsh detach-disk serverb vdb --config &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-c.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    rht-vmctl start serverb -q &> /dev/null
    while true;do ping -c 1 $serverbip &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 10s
            break
        fi
    done
    while true;do ssh root@$serverbip ls &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
            break
        fi
    done
ssh root@serverb 'echo lixiaohui | passwd --stdin root' &> /dev/null
}

function lvm-q19 {
    ssh root@$serverbip "wipefs -a /dev/vdb" &>/dev/null
    ssh root@$serverbip "parted /dev/vdb --script mklabel msdos" &>/dev/null
    ssh root@$serverbip "parted /dev/vdb mkpart primary 2048s 501MiB" &>/dev/null
    ssh root@$serverbip vgcreate myvol /dev/vdb1 &>/dev/null
    ssh root@$serverbip lvcreate -n vo -L 184M myvol &>/dev/null
    ssh root@$serverbip mkfs.ext4 /dev/myvol/vo &>/dev/null 
    ssh root@$serverbip mkdir /reports &>/dev/null
    ssh root@$serverbip 'echo "/dev/myvol/vo /reports ext4 defaults 0 0" >> /etc/fstab'
    ssh root@$serverbip mount -a
    if ! ssh root@$serverbip lsblk | grep -q vdb1; then
        fail && echo "Q19 vdb1 不存在"
    elif ! ssh root@$serverbip "lvs | grep -q vo"; then
        fail && echo "Q19 vo lvm 不存在"
    elif ! ssh root@$serverbip blkid | grep myvol | grep -q "ext4"; then
        fail && echo "Q19 vo的格式化不是ext4"
    elif ! ssh root@$serverbip mount -l | grep -q "reports"; then
        fail && echo "Q19 reports没挂载成功" 
    else
        pass && echo "Q19 调整逻辑卷大小"
    fi
}

function swap-q20 {
    ssh root@$serverbip parted /dev/vdb --script mkpart primary 501MiB 1024MiB &>/dev/null
    ssh root@$serverbip mkswap /dev/vdb2 &>/dev/null
    ssh root@$serverbip 'echo "/dev/vdb2 swap swap defaults 0 0" >> /etc/fstab' &>/dev/null
    ssh root@$serverbip swapon -a
    if ! ssh root@$serverbip lsblk | grep -q vdb2; then
        fail && echo "Q20 vdb2 不存在"
    elif ! ssh root@$serverbip "swapon -s | grep -q vdb2"; then
        fail && echo "Q20 vdb2 的swap没激活"
    else
        pass && echo "Q20 添加交换分区"
    fi
}

function tuned-q22 {
    ssh root@$serverbip tuned-adm profile desktop &>/dev/null
    if ! ssh root@$serverbip tuned-adm active | grep -q desktop; then
        fail && echo "tuned 设置失败"
    else
        pass && echo "Q22 配置系统调优"
    fi
}

#############################################################################3
# excute

if ! [ "$(id -u)" -eq 0 ]; then  
     echo "必须用root用户运行, 使用su - root切换到root用户"
     exit 1
fi

# custom ssh config on foundation0

cat > /root/.ssh/config <<EOF
Host 172.25.254.*
    StrictHostKeyChecking no
Host 172.25.250.*
    StrictHostKeyChecking no
Host *.ilt.example.com f* g*
    StrictHostKeyChecking no
    PreferredAuthentications publickey
    User kiosk
Host classroom.example.com classroom c classroom
    StrictHostKeyChecking no
    PreferredAuthentications publickey
    User instructor
Host bastion.lab.example.com bastion
    StrictHostKeyChecking no
Host workstation.lab.example.com workstation
    StrictHostKeyChecking no
Host servera.lab.example.com servera
    StrictHostKeyChecking no
Host serverb.lab.example.com serverb
    StrictHostKeyChecking no
Host serverc.lab.example.com serverc
    StrictHostKeyChecking no
Host serverd.lab.example.com serverd
    StrictHostKeyChecking no
Host *.lab.example.com
    StrictHostKeyChecking no
EOF

echo "请稍后, 正在将你的所有虚拟机关机"
rht-vmctl poweroff all -q &>/dev/null
rht-clearcourse 0 &>/dev/null

echo "请稍后, 正在设置课程代码"
rht-setcourse rh134 &>/dev/null
    if ! grep -q 134 /etc/rht; then
        fail && echo "课程设置失败, 请恢复foundation快照重试"
        exit 1
    fi
## add classroom hosts for fix classroom hang

echo 172.25.254.254 classroom.example.com classroom >> /etc/hosts &>/dev/null

echo "请稍后, 正在启动classroom并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
rht-vmctl fullreset classroom -q &> /dev/null
while true;do ping -c 1 classroom &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动bastion和utility并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
rht-vmctl fullreset bastion -q &> /dev/null
rht-vmctl fullreset utility -q &> /dev/null

while true;do ping -c 1 bastion &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done
while true;do ping -c 1 utility &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done


echo "请稍后, 正在批量重置servera|serverb"
for host in servera serverb;do
    rht-vmctl fullreset $host -q &> /dev/null
    virsh attach-interface --domain servera --type bridge --source privbr0 --model virtio --live --config &> /dev/null
done

echo "请稍后, 正在启动servera并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 1 $orgserveraip &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 10s
        ssh root@$orgserveraip ls &> /dev/null
        break
    fi
done

echo "请稍后, 正在启动serverb并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 2 $serverbip &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 10s
        ssh root@$serverbip ls &> /dev/null
        ssh root@classroom ls &> /dev/null
        ssh root@$serverbip 'sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=10/' /etc/default/grub' &>/dev/null
        ssh root@$serverbip 'grub2-mkconfig -o /boot/grub2/grub.cfg' &>/dev/null
        ssh root@$serverbip "sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config" &>/dev/null
        break
    fi
done

for host in servera serverb;do
    while true;do ssh root@$host ls &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
            break
        else
            rht-vmctl start $host &> /dev/null
        fi
    done
done

# permitrootlogin on all hosts

for host in classroom servera serverb;do
    ssh root@$host "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config" &> /dev/null
    ssh root@$host 'systemctl restart sshd' &> /dev/null
    ssh root@$host "echo flectrag | passwd --stdin root"  &> /dev/null
done

pass && echo "题号不连续是因为有些题目无需做测试准备"
prepare_network_hostsfile
network-q1
repository-q2
selinux-q3
ntp_set
autofs-q8
findfile-q10
findchar-q11
tar-q12
podman-q13
podman-q14
script-16d
script-16e
servera-netowrk-auto
prepare_serverb
lvm-q19
swap-q20
tuned-q22

## prepare rescue kernel on serverb

rht-vmctl fullreset workstation -q &>/dev/null
ssh root@serverb 'sed -i '1d' /etc/.rht_authorized_keys' &>/dev/null

for host in workstation;do
    while true;do ssh root@$host ls &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
            break
        else
            rht-vmctl start $host &> /dev/null
        fi
    done
done

ssh root@workstation 'echo 172.25.250.11 servera >> /etc/hosts' &>/dev/null

ssh student@workstation 'lab start boot-resetting' &>/dev/null

ssh root@workstation 'systemctl poweroff' &>/dev/null

virsh undefine workstation &>/dev/null