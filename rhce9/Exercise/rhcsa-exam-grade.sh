#!/bin/bash
####################################################################
# create for servera
# created by Xiaohui Li
# contact me via wechat: Lxh_Chat
# self test only, please do not use it on production or others

serveraip=172.25.250.111
serverbip=172.25.250.11

count=0
score=0
ssh root@$serveraip "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
ssh root@$serveraip "sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
ssh root@$serveraip 'systemctl restart sshd'

sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@serverb "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@serverb 'systemctl restart sshd'

function servera_sshpasscmd {
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$1 $2
}

function serverb_sshpasscmd {
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$1 $2
}

function pass {
  echo -ne "\033[32m PASS \033[0m\t"
}

function fail {
  echo -ne "\033[31m FAIL \033[0m\t"
}
ssh root@$serveraip ls &> /dev/null
servera_sshpasscmd servera ls &> /dev/null
serverb_sshpasscmd $serverbip ls &> /dev/null
serverb_sshpasscmd serverb ls &> /dev/null
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
        fail && echo "Q1 主机名不是servera.lab.example.com"
    fi
    if servera_sshpasscmd $serveraip "nmcli connection show 'System eth0' | grep -q '172.25.250.220'"; then
        score=$(expr $score + 1 )
        score1=$(expr $score1 + 2 )
    else
        fail && echo "Q1 DNS不是172.25.250.220"
    fi
    if servera_sshpasscmd $serveraip "nmcli connection show 'System eth0' | grep -q '172.25.250.254'"; then
        score=$(expr $score + 1 )
        score1=$(expr $score1 + 2 )
    else
        fail && echo "Q1 网关不是172.25.250.254"
    fi
    if [ $score1 -gt 7 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q1 配置网络设置"
    fi
}
function repository-q2 {
    score2=0
    if servera_sshpasscmd $serveraip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.3/x86_64/dvd/BaseOS"; then
        score=$(expr $score + 1 )
        score2=$(expr $score2 + 2 )
    else
        fail && echo "Q2 BaseOS 不存在"
    fi
    if servera_sshpasscmd $serveraip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.3/x86_64/dvd/AppStream"; then
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
        count=$(expr $count + 1 )
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
        count=$(expr $count + 1 )
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
        count=$(expr $count + 1 )   
        pass && echo "Q4 创建用户账号"
    fi

}
function cron-q5a {
    score5a=0
    if servera_sshpasscmd $serveraip "crontab -u harry -l 2> /dev/null | grep -q '23 14'"; then
        score=$(expr $score + 1 )
        score5a=$(expr $score5a + 2 )
        count=$(expr $count + 1 )     
        pass && echo "Q5A 配置Cron作业"
    else
        fail && echo "Q5A harry用户不存在或crontab的时间设置不正确"
    fi

}
function cron-q5b {
    score5b=0
    if servera_sshpasscmd $serveraip "crontab -u natasha -l 2> /dev/null | grep -q '*/2'"; then
        score=$(expr $score + 1 )
        score5b=$(expr $score5b + 2 )
        count=$(expr $count + 1 )     
        pass && echo "Q5B 配置Cron作业"
    else
        fail && echo "Q5B harry用户不存在或crontab的时间设置不正确"
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
        count=$(expr $count + 1 )
        pass && echo "Q6 创建协作目录"
    fi
}
function configure-ntp-q7 {
    q7score=0
    if servera_sshpasscmd $serveraip "chronyc sources" | grep -qE "materials|classroom"; then
        score=$(expr $score + 1 )
        q7score=$(expr $q7score + 2 )
        count=$(expr $count + 1 )
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
        count=$(expr $count + 1 )
        pass && echo "Q8 配置 autofs"
    fi
}
function configure-user-q9 {
    q9score=0
    if servera_sshpasscmd $serveraip "id manalo" 2> /dev/null | grep -q 3533; then
        score=$(expr $score + 1 )
        q9score=$(expr $q9score + 2 )
        count=$(expr $count + 1 )
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
        count=$(expr $count + 1 )
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
        count=$(expr $count + 1 )
        pass && echo "Q11 查找字符串"
    fi

}
function tar-q12 {
    q12score=0
    if servera_sshpasscmd $serveraip "file /root/backup.tar" | grep -q bzip2; then
        score=$(expr $score + 1 )
        q12score=$(expr $q12score + 2 )
        count=$(expr $count + 1 )
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
        count=$(expr $count + 1 )
        pass && echo "Q13 创建一个容器镜像"
    else
        fail && echo "Q13 本地没有pdf镜像"
    fi
}
function podman-q14a {
    q14score=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman ps 2> /dev/null | grep -q ascii2pdf; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14A ascii2pdf容器不存在"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman inspect ascii2pdf 2> /dev/null | grep -q '/opt/file'; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14A 容器没有使用/opt/file"
    fi

    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman inspect ascii2pdf 2> /dev/null | grep -q '/opt/progress'; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14A 容器没有使用/opt/progress"
    fi

    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip systemctl --user is-enabled container-ascii2pdf &> /dev/null \
    && sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip loginctl show-user wallah | grep -q Linger=yes &>/dev/null; then
        score=$(expr $score + 1 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14A container-ascii2pdf服务不存在或者未enable和linger=yes"
    fi
      
    if [ $q14score -gt 7 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q14A 将容器配置为服务"
    fi

}
function podman-q14b {
    q14bscore=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman ps 2> /dev/null | grep -q nginx; then
        score=$(expr $score + 1 )
        q14bscore=$(expr $q14bscore + 2 )
    else
        fail && echo "Q14B nginx容器不存在"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip podman inspect nginx 2> /dev/null | grep -q '/home/wallah/www'; then
        score=$(expr $score + 1 )
        q14bscore=$(expr $q14bscore + 2 )
    else
        fail && echo "Q14B 容器没有使用/home/wallah/www"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip systemctl --user is-enabled container-nginx &> /dev/null \
    && sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no wallah@$serveraip loginctl show-user wallah | grep -q Linger=yes &>/dev/null; then
        score=$(expr $score + 1 )
        q14bscore=$(expr $q14bscore + 2 )
    else
        fail && echo "Q14B container-nginx服务不存在或者未enable和linger=yes"
    fi
      
    if [ $q14bscore -gt 5 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q14B 将容器配置为服务"
    fi

}
function sudo-q15 {
    q15score=0
    if servera_sshpasscmd $serveraip "grep ^'%sysmgrs' /etc/sudoers" | grep -q NOPASSWD; then
        score=$(expr $score + 1 )
        q15score=$(expr $q15score + 2 )
        count=$(expr $count + 1 )
        pass && echo "Q15 添加sudo免密操作"
    else
        fail && echo "Q15 sysmgrs组的NOPASSWD没配置好"
    fi

}

function umask-q16 {
    q16score=0
    sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password manalo@$serveraip 2> /dev/null 'grep -q ^umask.*222$ /home/manalo/.bashrc'

    if [ $? -eq 0 ]; then
        score=$(expr $score + 1 )
        q16score=$(expr $q16score + 2 )
        count=$(expr $count + 1 )
        pass && echo "Q16A 设置用户的默认权限"
    else
        fail && echo "Q16A 没有在manalo用户家目录的.bashrc中发现正确的umask"
    fi

}

function alias-q16b {
    q16bscore=0
    sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password natasha@$serveraip 2> /dev/null 'grep -q ^alias.*ex200 /home/natasha/.bashrc'
    if [ $? -eq 0 ]; then
        score=$(expr $score + 1 )
        q16bscore=$(expr $q16bscore + 2 )
        count=$(expr $count + 1 )
        pass && echo "Q16B 配置应用"
    else
        fail && echo "Q16B 没有在natasha用户家目录的.bashrc中发现ex200的alias定义"
    fi

}

function pass-max-q16c {
    q16cscore=0
    sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'grep -q ^PASS_MAX_DAYS.*20 /etc/login.defs'
    if [ $? -eq 0 ]; then
        score=$(expr $score + 1 )
        q16cscore=$(expr $q16cscore + 2 )
        count=$(expr $count + 1 )
        pass && echo "Q16C 配置新用户的密码策略"
    else
        fail && echo "Q16C 没有在/etc/login.defs中发现正确的PASS_MAX_DAYS定义"
    fi

}

function script-q16d {
    q16dscore=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'test -x /usr/bin/myresearch'; then
        score=$(expr $score + 1 )
        q16dscore=$(expr $q16dscore + 2 )
        count=$(expr $count + 1 )
    else
        fail && echo "Q16D /usr/bin/myresearch不存在或不具有执行权限"
    fi

    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'test -e /root/myfiles'; then
        score=$(expr $score + 1 )
        q16dscore=$(expr $q16dscore + 2 )
        count=$(expr $count + 1 )
    else
        fail && echo "Q16D /root/myfiles路径不存在"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'test -g /root/myfiles/16d.txt'; then
        score=$(expr $score + 1 )
        q16dscore=$(expr $q16dscore + 2 )
        count=$(expr $count + 1 )
    else
        fail && echo "Q16D /root/myfiles/16d.txt不存在或者不具有SGID权限"
    fi

    if [ $q16dscore -gt 5 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q16D 创建脚本A"
    fi

}


function script-q16e {
    q16escore=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'test -x /usr/bin/newsearch'; then
        score=$(expr $score + 1 )
        q16escore=$(expr $q16escore + 2 )
        count=$(expr $count + 1 )
    else
        fail && echo "Q16E /usr/bin/newsearch不存在或不具有执行权限"
    fi

    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'test -e /root/newfiles'; then
        score=$(expr $score + 1 )
        q16escore=$(expr $q16escore + 2 )
        count=$(expr $count + 1 )
    else
        fail && echo "Q16E /root/newfiles路径不存在"
    fi
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serveraip 2> /dev/null 'test -u /root/newfiles/16e.txt'; then
        score=$(expr $score + 1 )
        q16escore=$(expr $q16escore + 2 )
        count=$(expr $count + 1 )
    else
        fail && echo "Q16E /root/newfiles/16e.txt不存在或者不具有SUID权限"
    fi
    if [ $q16escore -gt 5 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q16E 创建脚本B"
    fi

}






function root-password-q17 {
    q17score=0
    if sshpass -p flectrag ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@$serverbip "ls" 2> /dev/null; then
        score=$(expr $score + 1 )
        q17score=$(expr $q17score + 2 )
        count=$(expr $count + 1 )
        pass && echo "Q17 设置 root 密码"
    else
        fail && echo "Q17 serverb的root密码不是flectrag,正式考试中后续题目算作0分"
        exit 1
    fi

}
function repository-q18 {
    score18=0
    if servera_sshpasscmd $serverbip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.3/x86_64/dvd/BaseOS" 2> /dev/null; then
        score=$(expr $score + 1 )
        score18=$(expr $score18 + 2 )
    else
        fail && echo "Q18 BaseOS 不存在"
    fi
    if servera_sshpasscmd $serverbip "dnf repoinfo 2>/dev/null | grep -q http://content/rhel9.3/x86_64/dvd/AppStream" 2> /dev/null; then
        score=$(expr $score + 1 )
        score18=$(expr $score18 + 2 )
    else
        fail && echo "Q18 AppStream 不存在"
    fi
    if servera_sshpasscmd $serverbip 'dnf install ftp -y' &> /dev/null; then
        score=$(expr $score + 1 )
        score18=$(expr $score18 + 2 )
    else
        fail && echo "Q18 无法从你的仓库中安装软件"
    fi
    if [ $score18 -gt 5 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q18 配置您的系统以使用默认存储库"
    fi


}

function lvm-q19 {

size=$(servera_sshpasscmd $serverbip lvs /dev/myvol/vo | grep vo | awk '{print $4}' | sed 's/.00m//')
q19score=0
if [ $size -gt 200 2> /dev/null ]; then
    score=$(expr $score + 1 )
    count=$(expr $count + 1 )
    pass && echo "Q19 调整逻辑卷大小"
else
    fail && echo "Q19 调整逻辑卷大小没有成功"
fi
}

function swap-q20 {

servera_sshpasscmd $serverbip 'fdisk -l /dev/vdb | grep -i swap | awk "{print $5}" | grep -q 512'

if [ $? -eq 0 ]; then
  score=$(expr $score + 1 )
  count=$(expr $count + 1 )
  pass && echo "Q20 添加交换分区"
else
  fail && echo "Q20 未找到512大小的swap"
fi

}

function create-lvm-q21 {
    q21score=0
    if servera_sshpasscmd $serverbip "vgdisplay qagroup | grep 'PE Size' | grep -q 16" 2> /dev/null; then
        score=$(expr $score + 1 )
        q21score=$(expr $q21score + 2 )
    else
        fail && echo "Q21 qagroup VG不存在或者PE不是16M"
    fi
    if servera_sshpasscmd $serverbip "lvs" | grep -qE '960|qa' &> /dev/null; then
        score=$(expr $score + 1 )
        q21score=$(expr $q21score + 2 )
    else
        fail && echo "Q21 qa LV不存在或者不是60个PE"
    fi
    if servera_sshpasscmd $serverbip "blkid" | grep qagroup | grep -q vfat &> /dev/null; then
        score=$(expr $score + 1 )
        q21score=$(expr $q21score + 2 )
    else
        fail && echo "Q21 qa LV不存在或者不是vfat格式化"
    fi
    if [ $q21score -gt 5 ]; then
        count=$(expr $count + 1 )
        pass && echo "Q21 创建逻辑卷"
    fi
}

function tuned-q22 {
    q22score=0
    if servera_sshpasscmd $serverbip "tuned-adm active" 2> /dev/null | grep -q virtual-guest; then
        score=$(expr $score + 1 )
        q22score=$(expr $q22score + 2 )
        count=$(expr $count + 1 )
        pass && echo "Q22 配置系统调优"
    else
        fail && echo "Q22 virtual-guest不是当前值"
   fi

}



##############################################################################3

if ! [ "$(id -u)" -eq 0 ]; then  
     echo "必须用root用户运行, 使用su - root切换到root用户"
     exit 1
fi

echo '正在重启servera和serverb'
ssh root@$serveraip 'reboot' &> /dev/null
servera_sshpasscmd $serverbip 'reboot' &> /dev/null

echo '正在等待servera和serverb上线'

for host in 172.25.250.111 172.25.250.11;do
    while true;do sshpass -p flectrag ssh -o PreferredAuthentications=password -o ConnectTimeout=3 -o StrictHostKeyChecking=no root@$host ls &> /dev/null
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
cron-q5a
cron-q5b
create-folder-q6
configure-ntp-q7
autofs-q8
configure-user-q9
findfile-q10
findchar-q11
tar-q12
podman-q13
podman-q14a
podman-q14b
sudo-q15
umask-q16
alias-q16b
pass-max-q16c
script-q16d
script-q16e
root-password-q17
repository-q18
lvm-q19
swap-q20
create-lvm-q21
tuned-q22

echo
echo '===================================================================='
echo
# total score is 61, calc your score

yourscore=$((score * 300 / 61))

if [ $yourscore -gt 210 ];then
  pass && echo "你本次的得分为: $yourscore, 通过了测试"
else
  fail && echo "你本次的得分为: $yourscore, 暂未通过测试, 加油"
fi
echo