#!/bin/bash
####################################################################
# create for servera
# created by Xiaohui Li
# contact me via wechat: Lxh_Chat
# self test only, please do not use it on production or others

serveraip=172.25.250.111
serverbip=172.25.250.11

score=0
ssh root@$serveraip "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
ssh root@$serveraip 'systemctl restart sshd'

ssh root@serverb "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
ssh root@serverb 'systemctl restart sshd'

function servera_sshpasscmd {
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$1 $2
}

function servera_sshpasscmd {
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$1 $2
}

function pass {
  echo -ne "\033[32m PASS \033[0m\t"
}

function fail {
  echo -ne "\033[31m FAIL \033[0m\t"
}
ssh root@$serveraip ls &> /dev/null
ssh root@serverb ls &> /dev/null
ssh root@$serveraip ls &> /dev/null
ssh root@$serverbiprverb ls &> /dev/null
function network-q1 {
    score1=0
    if servera_sshpasscmd $serveraip "ip a s | grep -q 172.25.250.100/24"; then
        score=$(expr $score + 1 )
        score1=$(expr $score1 + 2 )
    else
        fail && echo "Q1 IP地址不是172.25.250.100/24, 如果是正式考试, 就正式宣告需要补考"
    fi
    if servera_sshpasscmd $serveraip "hostname" | grep -q 'servera.lab.example.com'; then
        score=$(expr $score + 1 )
        score1=$(expr $score1 + 2 )
    else
        fail && echo "Q1 主机名不是serverb.lab.example.com"
    fi
    if servera_sshpasscmd $serveraip "nmcli connection show 'Wired connection 1' | grep -q '172.25.250.220'"; then
        score=$(expr $score + 1 )
        score1=$(expr $score1 + 2 )
    else
        fail && echo "Q1 DNS不是172.25.250.220"
    fi
    if servera_sshpasscmd $serveraip "nmcli connection show 'Wired connection 1' | grep -q '172.25.250.254'"; then
        score=$(expr $score + 1 )
        score1=$(expr $score1 + 2 )
    else
        fail && echo "Q1 网关不是172.25.250.254"
    fi
    if [ $score1 -gt 7 ]; then
        pass && echo "Q1 配置网络设置"
    fi
}
function repository-q2 {
    score2=0
    if servera_sshpasscmd $serveraip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.0/x86_64/dvd/BaseOS"; then
        score=$(expr $score + 1 )
        score2=$(expr $score2 + 2 )
    else
        fail && echo "Q2 BaseOS 不存在"
    fi
    if servera_sshpasscmd $serveraip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.0/x86_64/dvd/AppStream"; then
        score=$(expr $score + 1 )
        score2=$(expr $score2 + 2 )
    else
        fail && echo "Q2 AppStream 不存在"
    fi
    if servera_sshpasscmd $serveraip "dnf install ftp -y" &> /dev/null; then
        score=$(expr $score + 1 )
        score2=$(expr $score2 + 2 )
    else
        fail && echo "Q2 无法从你的仓库中安装软件"
    fi
    if [ $score2 -gt 5 ]; then
        pass && echo "Q2 配置您的系统以使用默认存储库"
    fi

}
function selinux-q3 {
    score3=0
    if curl -s http://servera:82/file1 | grep -q EX200 &> /dev/null; 
    then
        score=$(expr $score + 1 )
        score3=$(expr $score3 + 2 )
    else
        fail && echo "Q3 无法从外部访问http://servera:82/file1"
    fi

    if curl -s http://servera:82/file2 | grep -q EX200 &> /dev/null; 
    then
        score=$(expr $score + 1 )
        score3=$(expr $score3 + 2 )
    else
        fail && echo "Q3 无法从外部访问http://servera:82/file2"
    fi

    if curl -s http://servera:82/file3 | grep -q EX200 &> /dev/null; 
    then
        score=$(expr $score + 1 )
        score3=$(expr $score3 + 2 )
    else
        fail && echo "Q3 无法从外部访问http://servera:82/file3"
    fi

    if servera_sshpasscmd $serveraip "systemctl is-enabled httpd" &> /dev/null; 
    then
        score=$(expr $score + 1 )
        score3=$(expr $score3 + 2 )
    else
        fail && echo "Q3 httpd服务没有enable"
    fi

    if [ $score3 -gt 7 ]; then
        pass && echo "Q3 调试 SELinux"
    fi
}
function create-user-q4 {
    score4=0
    if servera_sshpasscmd $serveraip "cat /etc/group" | grep -q sysmgrs; then
        score=$(expr $score + 1 )
        score4=$(expr $score4 + 2 )
    else
        fail && echo "Q4 sysmgrs组不存在"
    fi

    if servera_sshpasscmd $serveraip "id natasha 2> /dev/null" | grep -qE "natasha|sysmgrs"; then
        score=$(expr $score + 1 )
        score4=$(expr $score4 + 2 )
    else
        fail && echo "Q4 natasha不存在或者不在sysmgrs组"
    fi

    if servera_sshpasscmd $serveraip "id harry 2> /dev/null" | grep -qE "harry|sysmgrs"; then
        score=$(expr $score + 1 )
        score4=$(expr $score4 + 2 )
    else
        fail && echo "Q4 harry不存在或者不在sysmgrs组"
    fi

    if servera_sshpasscmd $serveraip "cat /etc/passwd" | grep -qE "sarah|nologin"; then
        score=$(expr $score + 1 )
        score4=$(expr $score4 + 2 )
    else
        fail && echo "Q4 sarah不存在或者shell不是nologin"
    fi

    if sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no natasha@$serveraip "ls" &> /dev/null; then        score=$(expr $score + 1 )
        score=$(expr $score + 1 )
        score4=$(expr $score4 + 2 )        
    else
        fail && echo "Q4 natasha、harry等用户密码不是flectrag"
    fi
    if [ $score4 -gt 9 ]; then
        pass && echo "Q4 创建用户账号"
    fi

}
function cron-q5 {
    score5=0
    if servera_sshpasscmd $serveraip "crontab -u harry -l 2> /dev/null | grep -q '23 14'"; then
        score=$(expr $score + 1 )
        score5=$(expr $score5 + 2 )        
        pass && echo "Q5 配置Cron作业"
    else
        fail && echo "Q5 harry用户不存在或crontab的时间设置不正确"
    fi

}
function create-folder-q6 {
    score6=0
    if servera_sshpasscmd $serveraip "test -e /home/managers"; then
        score=$(expr $score + 1 )
        score6=$(expr $score6 + 2 )
    else
        fail && echo "Q6 /home/managers文件夹不存在"
    fi
    if servera_sshpasscmd $serveraip "getfacl /home/managers" 2> /dev/null | grep group | grep -q sysmgrs; then
        score=$(expr $score + 1 )
        score6=$(expr $score6 + 2 )
    else
        fail && echo "Q6 /home/managers的组身份不是sysmgrs"
    fi
    if servera_sshpasscmd $serveraip "stat /home/managers" 2> /dev/null | grep -qE "2070|2770"; then
        score=$(expr $score + 1 )
        score6=$(expr $score6 + 2 )
    else
        fail && echo "Q6 /home/managers权限不对"
    fi
    if servera_sshpasscmd $serveraip "stat /home/managers" 2> /dev/null | grep -qE "2070|2770"; then
        score=$(expr $score + 1 )
        score6=$(expr $score6 + 2 )
    else
        fail && echo "Q6 /home/managers权限不对"
    fi
    if [ $score6 -gt 7 ]; then
        pass && echo "Q6 创建协作目录"
    fi
}
function configure-ntp-q7 {
    q7score=0
    if servera_sshpasscmd $serveraip "chronyc sources" | grep -qE "materials|classroom"; then
        score=$(expr $score + 1 )
        q7score=$(expr $q7score + 2 )
        pass && echo "Q7 配置 NTP"
    else
        fail && echo "Q7 materials|classroom其中一项没有配置成功"
    fi
}

function autofs-q8 {
    q8score=0
    if servera_sshpasscmd $serveraip "dnf list installed" | grep -q autofs; then
        score=$(expr $score + 1 )
        q8score=$(expr $q8score + 2 )
    else
        fail && echo "Q8 autofs软件没安装"
    fi
    if servera_sshpasscmd $serveraip "systemctl is-enabled autofs" &> /dev/null; then
        score=$(expr $score + 1 )
        q8score=$(expr $q8score + 2 )
    else
        fail && echo "Q8 autofs服务没有enable"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no remoteuser1@$serveraip touch /rhome/remoteuser1/testfile &> /dev/null; then
        score=$(expr $score + 1 )
        q8score=$(expr $q8score + 2 )
    else
        fail && echo "Q8 remoteuser1用户无法登录或没有写入权限"
    fi
    if [ $q8score -gt 5 ]; then
        pass && echo "Q8 配置 autofs"
    fi
}
function configure-user-q9 {
    q9score=0
    if servera_sshpasscmd $serveraip "id manalo" 2> /dev/null | grep -q 3533; then
        score=$(expr $score + 1 )
        q9score=$(expr $q9score + 2 )
        pass && echo "Q9 配置用户帐号"
    else
        fail && echo "Q9 manalo uid不是3533"
    fi
}
function findfile-q10 {

    q10score=0
    if servera_sshpasscmd $serveraip "test -e /root/findfiles"; then
        score=$(expr $score + 1 )
        q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 /root/findfiles不存在"
    fi
    if servera_sshpasscmd $serveraip "ls -l /root/findfiles" 2> /dev/null | grep -q jacques; then
        score=$(expr $score + 1 )
        q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 /root/findfiles中的文件不属于jacques"
    fi
    if [ $q10score -gt 3 ]; then
        pass && echo "Q10 查找文件"
    fi

}
function findchar-q11 {
    q11score=0
    if servera_sshpasscmd $serveraip "test -e /root/list"; then
        score=$(expr $score + 1 )
        q11score=$(expr $q11score + 2 )
    else
        fail && echo "Q11 /root/list不存在"
    fi
    if servera_sshpasscmd $serveraip "grep -q ng /root/list" 2> /dev/null; then
        score=$(expr $score + 1 )
        q11score=$(expr $q11score + 2 )
    else
        fail && echo "Q11 /root/list中没有ng行"
    fi
    if [ $q11score -gt 3 ]; then
        pass && echo "Q11 查找字符串"
    fi

}
function tar-q12 {
    q12score=0
    if servera_sshpasscmd $serveraip "file /root/backup.tar" | grep -q bzip2; then
        score=$(expr $score + 1 )
        q12score=$(expr $q12score + 2 )
        pass && echo "Q12 创建存档"
    else
        fail && echo "Q12 /root/backup.tar不存在或不是bzip2数据"
    fi
}
function podman-q13 {
    q13score=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman images 2> /dev/null | grep -q pdf; then
        score=$(expr $score + 1 )
        q13score=$(expr $q13score + 2 )
        pass && echo "Q13 创建一个容器镜像"
    else
        fail && echo "Q13 本地没有pdf镜像"
    fi
}
function podman-q14 {
    q14score=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman ps 2> /dev/null | grep -q ascii2pdf; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14 ascii2pdf容器不存在"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman inspect ascii2pdf 2> /dev/null | grep -q '/opt/file'; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14 容器没有使用/opt/file"
    fi

    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman inspect ascii2pdf 2> /dev/null | grep -q '/opt/progress'; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14 容器没有使用/opt/progress"
    fi

    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip systemctl --user is-enabled container-ascii2pdf &> /dev/null \
    && sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip loginctl show-user wallah | grep -q Linger=yes &>/dev/null; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14 container-ascii2pdf服务不存在或者未enable和linger=yes"
    fi
      
    if [ $q14score -gt 7 ]; then
        pass && echo "Q14 将容器配置为服务"
    fi

}
function sudo-q15 {
    q15score=0
    if servera_sshpasscmd $serveraip "grep ^'%wheel' /etc/sudoers" | grep -q NOPASSWD; then
        score=$(expr $score + 1 )
        q15score=$(expr $q15score + 2 )
        pass && echo "Q15 添加sudo免密操作"
    else
        fail && echo "Q15 wheel组的NOPASSWD没配置好"
    fi

}
function root-password-q16 {
    q16score=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serverbip "ls" 2> /dev/null; then
        score=$(expr $score + 2 )
        q15score=$(expr $q16score + 2 )
        pass && echo "Q16 设置 root 密码"
    else
        fail && echo "Q16 serverb的root密码不是flectrag,正式考试中后续题目算作0分"
        exit 1
    fi

}
function repository-q17 {
    score17=0
    if servera_sshpasscmd $serverbip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.0/x86_64/dvd/BaseOS" 2> /dev/null; then
        score=$(expr $score + 1 )
        score17=$(expr $score17 + 2 )
    else
        fail && echo "Q17 BaseOS 不存在"
    fi
    if servera_sshpasscmd $serverbip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.0/x86_64/dvd/AppStream" 2> /dev/null; then
        score=$(expr $score + 1 )
        score17=$(expr $score17 + 2 )
    else
        fail && echo "Q17 AppStream 不存在"
    fi
    if servera_sshpasscmd $serverbip 'dnf install ftp -y' &> /dev/null; then
        score=$(expr $score + 1 )
        score17=$(expr $score17 + 2 )
    else
        fail && echo "Q17 无法从你的仓库中安装软件"
    fi
    if [ $score17 -gt 5 ]; then
        pass && echo "Q17 配置您的系统以使用默认存储库"
    fi


}

function lvm-q18 {

size=$(ssh root@$serverbip lvs /dev/myvol/vo 2> /dev/null --noheadings --units M --nosuffix -o lv_size | tr -d ' ' | cut -d . -f 1 )
q18score=0
if [ $size -gt 200 2> /dev/null ]; then
    score=$(expr $score + 2 )
    pass && echo "Q18 调整逻辑卷大小"
else
    fail && echo "Q18 调整逻辑卷大小没有成功"
fi
}

function swap-q19 {

sizes=$(ssh root@$serverbip lsblk | grep -i swap 2> /dev/null | awk '{print $4}' | cut -d M -f 1)
q19score=0
found=0
for size in $sizes; do
  if [ "$size" -eq 512 ]; then
    found=1
  fi
done
if [ "$found" -eq 1 2> /dev/null ]; then
  score=$(expr $score + 2 )
  pass && echo "Q19 添加交换分区"
else
  fail && echo "Q19 未找到512大小的swap"
fi

}

function create-lvm-q20 {
    q20score=0
    if servera_sshpasscmd $serverbip "vgdisplay qagroup | grep 'PE Size' | grep -q 16" 2> /dev/null; then
        score=$(expr $score + 2 )
        q20score=$(expr $q20score + 2 )
    else
        fail && echo "Q20 qagroup VG不存在或者PE不是16M"
    fi
    if servera_sshpasscmd $serverbip "lvs" | grep -qE '960|qa' &> /dev/null; then
        score=$(expr $score + 2 )
        q20score=$(expr $q20score + 2 )
    else
        fail && echo "Q20 qa LV不存在或者不是60个PE"
    fi
    if servera_sshpasscmd $serverbip "blkid" | grep qagroup | grep -q vfat &> /dev/null; then
        score=$(expr $score + 2 )
        q20score=$(expr $q20score + 2 )
    else
        fail && echo "Q20 qa LV不存在或者不是vfat格式化"
    fi
    if [ $q20score -gt 5 ]; then
        pass && echo "Q20 创建逻辑卷"
    fi
}

function tuned-q21 {
    q21score=0
    if servera_sshpasscmd $serverbip "tuned-adm active" 2> /dev/null | grep -q virtual-guest; then
        score=$(expr $score + 2 )
        q21score=$(expr $q21score + 2 )
        pass && echo "Q21 配置系统调优"
    else
        fail && echo "Q21 virtual-guest不是当前值"
   fi

}



##############################################################################3

if ! [ "$(id -u)" -eq 0 ]; then  
     echo "必须用root用户运行, 使用su - root切换到root用户"
     exit 1
fi

echo '正在重启servera和serverb'
ssh root@$serveraip 'reboot' &> /dev/null
ssh root@serverb 'reboot' &> /dev/null

echo '正在等待servera和serverb上线'

for host in 172.25.250.111 serverb;do
    while true;do ssh root@$host ls &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
            break
        fi
    done
done


network-q1
repository-q2
selinux-q3
create-user-q4
cron-q5
create-folder-q6
configure-ntp-q7
autofs-q8
configure-user-q9
findfile-q10
findchar-q11
tar-q12
podman-q13
podman-q14
sudo-q15
root-password-q16
repository-q17
lvm-q18
swap-q19
create-lvm-q20
tuned-q21
echo
echo
echo '===================================================================='
echo
echo

pass_score=`echo "scale=0; 53 * 0.7"|bc -l|cut -d'.' -f1`

if [ $score -gt $pass_score ];then
  pass && echo "本试卷满分为53分, 你本次得分为: $score 分，通过了考试" 
else
  fail && echo "本试卷满分为53分, 你本次得分为: $score 分，暂未通过考试，加油哦，看好你" 
fi
echo
echo