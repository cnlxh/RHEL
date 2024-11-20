#!/bin/bash
####################################################################
# create for rh294
# created by Xiaohui Li
# contact me via wechat: Lxh_Chat
# self test only, please do not use it on production or others

score=0
count=0
# prepare user and ssh key

function sshpasscmd {
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$1 $2
}

# defined pass or fail

function pass {
  echo -ne "\033[32m PASS \033[0m\t"
}

function fail {
  echo -ne "\033[31m FAIL \033[0m\t"
}

function f0_ansible {
    scp root@bastion:/home/greg/ansible/inventory /etc/ansible/hosts &> /dev/null

}
function ansible_install {
q1score=0
    if sshpasscmd bastion 'dnf list installed' | grep -qE 'ansible-core|ansible-navigator' &> /dev/null;then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 ansible-core|ansible-navigator软件未安装"
    fi
    sshpasscmd bastion 'test -e /home/greg/ansible/inventory'
    if [ $? -eq 0 ];then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 未检测到/home/greg/ansible/inventory"
    fi
    sshpasscmd bastion 'test -e /home/greg/ansible/ansible.cfg'
    if [ $? -eq 0 ];then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 未检测到/home/greg/ansible/ansible.cfg"
    fi
    sshpasscmd bastion 'grep roles_path /home/greg/ansible/ansible.cfg' 2> /dev/null | grep -qw '/home/greg/ansible/roles'
    if [ $? -eq 0 ];then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 未检测到/home/greg/ansible/ansible.cfg或角色路径不对"
    fi
    sshpasscmd bastion 'grep collections_path /home/greg/ansible/ansible.cfg' 2> /dev/null | grep -qw '/home/greg/ansible/mycollection'
    if [ $? -eq 0 ];then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 未检测到/home/greg/ansible/ansible.cfg或集合路径不对"
    fi
    if ansible dev --list-hosts | grep -q workstation;then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 dev主机组不包含workstation"
    fi
    if ansible test --list-hosts | grep -q servera;then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 test主机组不包含servera"
    fi
    if ansible prod --list-hosts | grep -qE 'serverb|serverc';then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 prod主机组不包含serverb|serverc"
    fi
    if ansible balancers --list-hosts | grep -q 'serverd';then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 balancers 主机组不包含serverd"
    fi
    if ansible webservers --list-hosts | grep -qE 'serverb|serverc';then
        score=$(expr $score + 2 )
        q1score=$(expr $q1score + 2 )
    else
        fail && echo "Q1 prod 不是webservers 的子组"
    fi
    if [ $q1score -gt 19 ];then
        count=$(expr $count + 1 )
        pass && echo "Q1 安装和配置 Ansible"
    fi
}

function configure_repo {
q2score=0
for host in servera serverb serverc serverd workstation;do
    repofilename=`sshpasscmd $host 'ls /etc/yum.repos.d/'`
    repoinfo=`sshpasscmd $host 'dnf repoinfo 2> /dev/null'`
    if echo $repofilename |grep -q EX294_BASE.repo;then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上EX294_BASE.repo文件不存在"
    fi
    if echo $repofilename |grep -q EX294_STREAM.repo;then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上EX294_STREAM.repo文件不存在"
    fi
    if echo $repoinfo | grep -q 'EX294 base software';then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上未找到描述为EX294 base software的仓库"
    fi
    if echo $repoinfo | grep -q 'EX294 stream software';then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上未找到描述为EX294 stream software的仓库"
    fi
    if echo $repoinfo | grep -q 'http://content/rhel9.0/x86_64/dvd/BaseOS';then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上未找到baseurl为http://content/rhel9.0/x86_64/dvd/BaseOS的仓库"
    fi
    if echo $repoinfo | grep -q 'http://content/rhel9.0/x86_64/dvd/AppStream';then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上未找到baseurl为http://content/rhel9.0/x86_64/dvd/AppStream的仓库"
    fi
    if sshpasscmd $host "grep -q 'http://content/rhel9.0/x86_64/dvd/RPM-GPG-KEY-redhat-release' /etc/yum.repos.d/EX294_STREAM.repo" 2> /dev/null && \
    sshpasscmd $host "grep -q 'http://content/rhel9.0/x86_64/dvd/RPM-GPG-KEY-redhat-release' /etc/yum.repos.d/EX294_BASE.repo" 2> /dev/null;then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
        fail && echo "Q2 在$host主机上未找到使用密钥为http://content/rhel9.0/x86_64/dvd/RPM-GPG-KEY-redhat-release的仓库"
    fi    
    if sshpasscmd $host "grep -q 'gpgcheck = 1' /etc/yum.repos.d/EX294_BASE.repo" 2> /dev/null;then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
         fail && echo "Q2 在$host主机上的EX294_BASE未开启gpg校验"
    fi
    if sshpasscmd $host "grep -q 'gpgcheck = 1' /etc/yum.repos.d/EX294_STREAM.repo" 2> /dev/null;then
         score=$(expr $score + 2 )
         q2score=$(expr $q2score + 2 )
    else
         fail && echo "Q2 在$host主机上的EX294_STREAM未开启gpg校验"
    fi
done
    if [ $q2score -gt 89 ];then
        count=$(expr $count + 1 )
        pass && echo "Q2 配置您的系统以使用默认存储库"
    fi
}

function install_software {
q3score=0
for host in dev test prod;do
    if ansible $host -m shell -a 'dnf list installed' 2> /dev/null | grep -qwE "mariadb.x86_64|php.x86_64";then
         score=$(expr $score + 2 )
         q3score=$(expr $q3score + 2 )
    else
        fail && echo "Q3 在$host主机组上未检测到已安装mariadb或php"
    fi
done
    if ansible dev -m shell -a 'dnf grouplist installed' 2> /dev/null | grep -qw 'RPM Development Tools';then
         score=$(expr $score + 2 )
         q3score=$(expr $q3score + 2 )
    else
         fail && echo "Q3 在dev主机组中未检测到已安装RPM Development Tools软件包组"
    fi
    if [ $q3score -gt 5 ];then
        count=$(expr $count + 1 )
        pass && echo "Q3 安装软件包"
    fi
}

function use_sysrole {
q4score=0
    if sshpasscmd bastion 'dnf list installed' | grep -qw 'rhel-system-roles';then
         score=$(expr $score + 2 )
         q4score=$(expr $q4score + 2 )        
    else
        fail && echo "Q4 未安装系统角色软件包"
    fi
    for host in servera serverb serverc serverd workstation;do
        if sshpasscmd $host 'getenforce' | grep -qiw 'Enforcing';then
            score=$(expr $score + 2 )
            q4score=$(expr $q4score + 2 )
        else
            fail && echo "Q4 $host未处于enforcing模式"
        fi
    done
    if [ $q4score -gt 11 ];then
        count=$(expr $count + 1 )
        pass && echo "Q4 使用 RHEL 系统角色"
    fi
}

function configure_collection {
    q5score=0
    if sshpasscmd bastion 'test -e /home/greg/ansible/mycollection/ansible_collections/community/general/';then
         score=$(expr $score + 2 )
         q5score=$(expr $q5score + 2 )        
    else
        fail && echo "Q5 未在/home/greg/ansible/mycollection找到general"
    fi
    if sshpasscmd bastion 'test -e /home/greg/ansible/mycollection/ansible_collections/redhat/insights';then
         score=$(expr $score + 2 )
         q5score=$(expr $q5score + 2 )        
    else
        fail && echo "Q5 未在/home/greg/ansible/mycollection找到insights"
    fi
    if sshpasscmd bastion 'test -e /home/greg/ansible/mycollection/ansible_collections/redhat/rhel_system_roles';then
         score=$(expr $score + 2 )
         q5score=$(expr $q5score + 2 )        
    else
        fail && echo "Q5 未在/home/greg/ansible/mycollection找到rhel_system_roles"
    fi
    if [ $q5score -gt 5 ];then
        count=$(expr $count + 1 )
        pass && echo "Q5 配置conllection"
    fi
}
function install_role {
    q6score=0
    if sshpasscmd bastion 'grep -q haproxy /home/greg/ansible/roles/balancer/tasks/main.yml' 2> /dev/null;then
         score=$(expr $score + 2 )
         q6score=$(expr $q6score + 2 )        
    else
        fail && echo "Q6 未在/home/greg/ansible/roles找到balancer"
    fi
    if sshpasscmd bastion 'grep -q php /home/greg/ansible/roles/phpinfo/tasks/main.yml' 2> /dev/null;then
         score=$(expr $score + 2 )
         q6score=$(expr $q6score + 2 )        
    else
        fail && echo "Q6 未在/home/greg/ansible/mycollection找到phpinfo"
    fi
    
    if [ $q6score -gt 3 ];then
        count=$(expr $count + 1 )
        pass && echo "Q6 使用 Ansible Galaxy 安装角色"
    fi      
}
function create_apache_role {
    q7score=0
    if sshpasscmd bastion 'grep -q httpd /home/greg/ansible/roles/apache/tasks/main.yml' 2> /dev/null;then
         score=$(expr $score + 2 )
         q7score=$(expr $q7score + 2 )        
    else
        fail && echo "Q7 未在/home/greg/ansible/roles找到apache角色"
    fi
    if sshpasscmd bastion 'grep -q apache /home/greg/ansible/apache.yml' 2> /dev/null;then
         score=$(expr $score + 2 )
         q7score=$(expr $q7score + 2 )
    else
        fail && echo "Q7 未在/home/greg/ansible/apache.yml使用apache角色"
    fi
    if curl http://serverb 2> /dev/null | grep 'serverb.lab.example.com' 2> /dev/null | grep '172.25.250.11' &> /dev/null;then
         score=$(expr $score + 2 )
         q7score=$(expr $q7score + 2 )
    else
        fail && echo "Q7 访问serverb返回的内容不包含serverb.lab.example.com或172.25.250.11"
    fi
    if curl http://serverc 2> /dev/null | grep 'serverc.lab.example.com' 2> /dev/null | grep '172.25.250.12' &> /dev/null;then
         score=$(expr $score + 2 )
         q7score=$(expr $q7score + 2 )
    else
        fail && echo "Q7 访问serverc返回的内容不包含serverc.lab.example.com或172.25.250.12"
    fi
    if [ $q7score -gt 3 ];then
        count=$(expr $count + 1 )
        pass && echo "Q7 创建和使用角色"
    fi
}
function use_galaxy_role {
    q8score=0
    if curl -s http://172.25.250.13 2> /dev/null > /tmp/q8.txt && curl -s http://172.25.250.13 2> /dev/null >> /tmp/q8.txt && grep 'serverb.lab.example.com' /tmp/q8.txt | grep '172.25.250.11' &> /dev/null;then
         score=$(expr $score + 2 )
         q8score=$(expr $q8score + 2 )
    else
        fail && echo "Q8 访问172.25.250.13返回的内容不包含serverb.lab.example.com或172.25.250.11"
    fi
    if curl -s http://172.25.250.13 2> /dev/null > /tmp/q8.txt && curl -s http://172.25.250.13 2> /dev/null >> /tmp/q8.txt && grep 'serverc.lab.example.com' /tmp/q8.txt | grep '172.25.250.12' &> /dev/null;then
         score=$(expr $score + 2 )
         q8score=$(expr $q8score + 2 )
    else
        fail && echo "Q8 访问172.25.250.13返回的内容不包含serverc.lab.example.com或172.25.250.12"
    fi
    if curl -s http://172.25.250.12/hello.php 2> /dev/null > /tmp/q8.txt && grep -qi php /tmp/q8.txt;then
         score=$(expr $score + 2 )
         q8score=$(expr $q8score + 2 )
         rm -rf /tmp/q8.txt
    else
        fail && echo "Q8 访问http://172.25.250.12/hello.php并不会输出php相关内容"
         rm -rf /tmp/q8.txt
    fi
    if [ $q8score -gt 5 ];then
        count=$(expr $count + 1 )
        pass && echo "Q8 从 Ansible Galaxy 使用角色"
    fi
}
function create_lv {
    q9score=0
    if sshpasscmd serverd 'lvs | grep data | grep -q g';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 serverd上的/dev/research/data不存在, 或不是1.5G"
    fi
    if sshpasscmd serverd 'blkid | grep research | grep -q ext4';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 serverd上的/dev/research/data不存在, 或不是ext4格式"
    fi
    if sshpasscmd servera 'lvs | grep data | grep -q 800';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 servera上的/dev/research/data不存在, 或不是800m"
    fi
    if sshpasscmd servera 'blkid | grep research | grep -q ext4';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 servera上的/dev/research/data不存在, 或不是ext4格式"
    fi    
    if sshpasscmd serverb 'lvs | grep data | grep -q 800';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 serverb上的/dev/research/data不存在, 或不是800m"
    fi
    if sshpasscmd serverb 'blkid | grep research | grep -q ext4';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 serverb上的/dev/research/data不存在, 或不是ext4格式"
    fi    
    if sshpasscmd serverc 'lvs | grep data | grep -q 800';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 serverc上的/dev/research/data不存在, 或不是800m"
    fi
    if sshpasscmd serverc 'blkid | grep research | grep -q ext4';then
         score=$(expr $score + 2 )
         q9score=$(expr $q9score + 2 )
    else
        fail && echo "Q9 serverc上的/dev/research/data不存在, 或不是ext4格式"
    fi
    if [ $q9score -gt 15 ];then
        count=$(expr $count + 1 )
        pass && echo "Q9 创建和使用逻辑卷"
    fi
}


function create_partition {
    q9bscore=0
    vdf1sieze=$(sshpasscmd serverb 'lsblk' | grep vdf1 | awk '{print $4}' | sed 's/M//g')
    if [ $vdf1sieze -gt 750 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverb上的/dev/vdf1不存在, 或不是800M"
    fi

    vdf1sieze=$(sshpasscmd serverc 'lsblk' | grep vdf1 | awk '{print $4}' | sed 's/G//g')
    if echo $vdf1sieze | grep -q 1.5;then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverc上的/dev/vdf1不存在, 或不是1500M"
    fi

    sshpasscmd serverb 'df | grep -qw newpart'
    if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverb上没有/newpart挂载项"

    fi
    sshpasscmd serverc 'df | grep -qw newpart'
    if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverc上没有/newpart挂载项"
    fi
    sshpasscmd serverb 'df | grep -qw newpart1'
    if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverc上没有/newpart1挂载项"
    fi

    sshpasscmd serverb 'blkid | grep vdf1 | grep -q ext4'
     if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverb上vdf1的格式不是ext4"
    fi

    sshpasscmd serverb 'blkid | grep vdg1 | grep -q ext4'
     if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverb上vdg1的格式不是ext4"
    fi

    sshpasscmd serverc 'blkid | grep vdf1 | grep -q ext4'
     if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q9bscore=$(expr $q9bscore + 2 )
    else
        fail && echo "Q9B serverc上vdf1的格式不是ext4"
    fi

    if [ $q9bscore -gt 15 ];then
        count=$(expr $count + 1 )
        pass && echo "Q9B 创建和使用分区"
    fi
}


function create_hosts_file {
    q10score=0
    if sshpasscmd workstation 'cat /etc/myhosts | grep 172.25.250.10 | grep -qE "servera|servera.lab.example.com"' &> /dev/null;then
         score=$(expr $score + 2 )
         q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 workstation上的/etc/myhosts中未找到servera的IP和主机名相关行"
    fi
    if sshpasscmd workstation 'cat /etc/myhosts | grep 172.25.250.11 | grep -qE "serverb|serverb.lab.example.com"' &> /dev/null;then
         score=$(expr $score + 2 )
         q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 workstation上的/etc/myhosts中未找到serverb的IP和主机名相关行"
    fi
    if sshpasscmd workstation 'cat /etc/myhosts | grep 172.25.250.9 | grep -qE "workstation|workstation.lab.example.com"' &> /dev/null;then
         score=$(expr $score + 2 )
         q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 workstation上的/etc/myhosts中未找到workstation的IP和主机名相关行"
    fi
    if sshpasscmd workstation 'cat /etc/myhosts | grep 172.25.250.12 | grep -qE "serverc|serverc.lab.example.com"' &> /dev/null;then
         score=$(expr $score + 2 )
         q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 workstation上的/etc/myhosts中未找到serverc的IP和主机名相关行"
    fi
    if sshpasscmd workstation 'cat /etc/myhosts | grep 172.25.250.13 | grep -qE "serverd|serverd.lab.example.com"' &> /dev/null;then
         score=$(expr $score + 2 )
         q10score=$(expr $q10score + 2 )
    else
        fail && echo "Q10 workstation上的/etc/myhosts中未找到serverd的IP和主机名相关行"
    fi

    if [ $q10score -gt 9 ];then
        count=$(expr $count + 1 )
        pass && echo "Q10 生成主机文件"
    fi    
}

function modify_file_content {
q11score=0
    if sshpasscmd workstation 'grep -q Development /etc/issue';then
      score=$(expr $score + 2 )
      q11score=$(expr $q11score + 2 )            
    else
      fail && echo "Q11 workstation上/etc/issue中没有发现Development"
    fi
    if sshpasscmd servera 'grep -q Test /etc/issue';then
      score=$(expr $score + 2 )
      q11score=$(expr $q11score + 2 )            
    else
      fail && echo "Q11 servera上/etc/issue中没有发现Test"
    fi
    if sshpasscmd serverb 'grep -q Production /etc/issue';then
      score=$(expr $score + 2 )
      q11score=$(expr $q11score + 2 )            
    else
      fail && echo "Q11 serverb上/etc/issue中没有发现Production"
    fi
    if sshpasscmd serverc 'grep -q Production /etc/issue';then
      score=$(expr $score + 2 )
      q11score=$(expr $q11score + 2 )            
    else
      fail && echo "Q11 serverc上/etc/issue中没有发现Production"
    fi
    if [ $q11score -gt 7 ];then
        count=$(expr $count + 1 )
        pass && echo "Q11 修改文件内容"
    fi   
}

function create_web_content {
q12score=0
    if sshpasscmd workstation 'stat /webdev/ 2> /dev/null | grep Access | grep -q 2775';then
        score=$(expr $score + 2 )
        q12score=$(expr $q12score + 2 )
    else
        fail && echo "Q12 workstation 上未找到/webdev目录或权限不是2775"
    fi
    if sshpasscmd workstation 'stat /webdev/ 2> /dev/null | grep Access | grep -q webdev';then
        score=$(expr $score + 2 )
        q12score=$(expr $q12score + 2 )
    else
        fail && echo "Q12 workstation 上未找到/webdev目录或组身份不是webdev"
    fi
    if sshpasscmd workstation 'ls -l /var/www/html/ 2> /dev/null | grep -q lr';then
        score=$(expr $score + 2 )
        q12score=$(expr $q12score + 2 )
    else
        fail && echo "Q12 workstation的/var/www/html中没有链接文件"
    fi
    if sshpasscmd workstation 'grep -q Development /webdev/index.html' 2> /dev/null;then
        score=$(expr $score + 2 )
        q12score=$(expr $q12score + 2 )
    else
        fail && echo "Q12 workstation的/webdev/index.html不存在或内容不是Development"
    fi
    if curl -s http://172.25.250.9/webdev/ | grep -q Development &> /dev/null;then
        score=$(expr $score + 2 )
        q12score=$(expr $q12score + 2 )
    else
        fail && echo "Q12 http://172.25.250.9/webdev/ 无法访问或返回内容不是Development"
    fi
    if [ $q12score -gt 9 ];then
        count=$(expr $count + 1 )
        pass && echo "Q12 创建 Web 内容目录"
    fi   
}

function create_hardware_report {
q13score=0
    for host in servera serverb serverc serverd workstation;do
        MEMORY=`sshpasscmd $host 'grep ^MEMORY= /root/hwreport.txt' 2> /dev/null | cut -d = -f 2`
        if [[ -n $MEMORY ]] && [[ $MEMORY =~ ^[0-9]+$ ]];then
            score=$(expr $score + 2 )
            q13score=$(expr $q13score + 2 )      
        else  
            fail && echo Q13 "在$host上的/root/hwreport.txt中MEMORY为空或非数字"
        fi
    done
    for host in servera serverb serverc serverd workstation;do
        HOSTNAME=`sshpasscmd $host 'grep ^HOST= /root/hwreport.txt' 2> /dev/null | cut -d = -f 2`
        if [[ -z $HOSTNAME || $HOSTNAME = $host ]];then
            score=$(expr $score + 2 )
            q13score=$(expr $q13score + 2 )      
        else  
            fail && echo Q13 "在$host上的/root/hwreport.txt中HOST为空或没有等于$host"
        fi
    done
    for host in servera serverb serverc serverd workstation;do
        BIOS=`sshpasscmd $host 'grep ^BIOS= /root/hwreport.txt' 2> /dev/null | cut -d = -f 2`
        if [[ -z $BIOS || $BIOS = 1.15.0-1.el9 ]];then
            score=$(expr $score + 2 )
            q13score=$(expr $q13score + 2 )      
        else  
            fail && echo Q13 "在$host上的/root/hwreport.txt中BIOS为空或没有等于1.15.0-1.el9, 请在bastion导出$host的facts, 只要bios中有值就忽略掉本错误即可"
        fi
    done
    for host in servera serverb serverc serverd workstation;do
        DISK_SIZE_VDA=`sshpasscmd $host 'grep ^DISK_SIZE_VDA= /root/hwreport.txt' 2> /dev/null | cut -d = -f 2 | cut -d ' ' -f 1 | cut -d . -f 1`
        if [[ -z $DISK_SIZE_VDA || $DISK_SIZE_VDA -eq 10 || $DISK_SIZE_VDA -eq 20 ]];then
            score=$(expr $score + 2 )
            q13score=$(expr $q13score + 2 )      
        else  
            fail && echo Q13 "在$host上的/root/hwreport.txt中DISK_SIZE_VDA不等于10G或者20G"
        fi
    done    
    for host in servera serverb serverc workstation;do
        DISK_SIZE_VDB=`sshpasscmd $host 'grep ^DISK_SIZE_VDB= /root/hwreport.txt' 2> /dev/null | cut -d = -f 2 | cut -d ' ' -f 1 | cut -d . -f 1`
        if [[ -z $DISK_SIZE_VDB || $DISK_SIZE_VDB -eq 1 || $DISK_SIZE_VDB -eq 5 ]];then
            score=$(expr $score + 2 )
            q13score=$(expr $q13score + 2 )
        else  
            fail && echo Q13 "在$host上的/root/hwreport.txt中DISK_SIZE_VDB不等于1G或者5G"
        fi
    done
    if sshpasscmd serverd 'grep -q NONE /root/hwreport.txt' 2> /dev/null;then
        score=$(expr $score + 2 )
        q13score=$(expr $q13score + 2 )
    else
        fail && echo "Q13 serverd上的/root/hwreport.txt中DISK_SIZE_VDB不等于NONE"
    fi
    if [ $q13score -gt 49 ];then
        count=$(expr $count + 1 )
        pass && echo "Q13 生成硬件报告"
    fi   
}

function create_vault {
q14score=0
    if sshpasscmd bastion 'grep -qw 'vault_password_file=/home/greg/ansible/secret.txt' /home/greg/ansible/ansible.cfg';then
        score=$(expr $score + 2 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14 ansible.cfg中未检测到vault_password_file参数"
    fi
    if sshpasscmd bastion 'cd /home/greg/ansible/ && timeout 10 ansible-vault view /home/greg/ansible/locker.yml' &> /dev/null;then
        score=$(expr $score + 2 )
        q14score=$(expr $q14score + 2 )
    else
        fail && echo "Q14 在bastion上未能自动解密/home/greg/ansible/locker.yml"
    fi
    if [ $q14score -gt 3 ];then
        count=$(expr $count + 1 )
        pass && echo "Q14 创建密码库"
    fi   
}

function create_user {
q15score=0
    for host in workstation servera;do
        if sshpass -p Imadev ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password bob@$host "ls" 2> /dev/null;then
            score=$(expr $score + 2 )
            q15score=$(expr $q15score + 2 )
        else
             fail && echo "Q15 未能使用bob的身份以及密码登录$host"
        fi
    done
    for host in workstation servera;do
        if sshpass -p Imadev ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password fred@$host "ls" 2> /dev/null;then
            score=$(expr $score + 2 )
            q15score=$(expr $q15score + 2 )
        else
             fail && echo "Q15 未能使用fred的身份以及密码登录$host"
        fi
    done
    for host in serverb serverc;do
        if sshpass -p Imamgr ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password sally@$host "ls" 2> /dev/null;then
            score=$(expr $score + 2 )
            q15score=$(expr $q15score + 2 )
        else
             fail && echo "Q15 未能使用sally的身份以及密码登录$host"
        fi
    done
    for host in workstation servera;do
        if sshpass -p Imadev ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password bob@$host "id bob" 2> /dev/null | grep -q 3000 && sshpass -p Imadev ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password bob@$host "id bob" 2> /dev/null | grep -q devops;then
            score=$(expr $score + 2 )
            q15score=$(expr $q15score + 2 )
        else
             fail && echo "Q15 $host 上bob的UID不正确或者补充组不是devops"
        fi
    done
    for host in workstation servera;do
        if sshpass -p Imadev ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password fred@$host "id fred" 2> /dev/null | grep -q 3002 && sshpass -p Imadev ssh -A -g -o StrictHostKeyChecking=no -o PreferredAuthentications=password fred@$host "id fred" 2> /dev/null | grep -q devops;then
            score=$(expr $score + 2 )
            q15score=$(expr $q15score + 2 )
        else
             fail && echo "Q15 $host 上fred的UID不正确或者补充组不是devops"
        fi
    done
    if [ $q15score -gt 19 ];then
        count=$(expr $count + 1 )
        pass && echo "Q15 创建用户帐户"
    fi   
}

function update_vault {
q16score=0
    if sshpasscmd bastion 'ansible-vault view --vault-password-file=/tmp/vault /home/greg/ansible/salaries.yml' 2>/dev/null | grep -q 'haha';then
        score=$(expr $score + 2 )
        q16score=$(expr $q16score + 2 )
    else
        fail && echo "Q16 无法使用新密码解密文件"
    fi
    if [ $q16score -gt 1 ];then
        count=$(expr $count + 1 )
        pass && echo "Q16 更新 Ansible 库的密钥"
    fi   
}

function cronfile {
q17score=0
    if sshpasscmd servera 'crontab -l -u natasha 2> /dev/null | grep -q '*/2'';then
        score=$(expr $score + 2 )
        q17score=$(expr $q17score + 2 )        
    else
        fail && echo "Q17 未检测到为natasha用户分配每两分钟的任务"
    fi
    if [ $q17score -gt 1 ];then
        count=$(expr $count + 1 )
        pass && echo "Q17 配置 cron 作业"
    fi       
}

function timesyncrole {
q18score=0
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout timesync.yml --syntax-check' &> /dev/null
    if [ $? -eq 0 ];then
         score=$(expr $score + 2 )
         q18score=$(expr $q18score + 2 )        
    else
        fail && echo "Q18 timesync.yml不存在或语法错误"
    fi
    for host in servera serverb serverc serverd workstation;do
        if ansible $host -m shell -a 'chronyc sources' 2> /dev/null | grep -q '172.25.254.254';then
           score=$(expr $score + 2 )
           q18score=$(expr $q18score + 2 )
        else
           echo "Q18 "$host"执行chronyc sources后, 未发现172.25.254.254"
        fi
    done
    if [ $q18score -gt 11 ];then
        count=$(expr $count + 1 )
        pass && echo "Q18 配置 timesync 角色"
    fi       
}

# configure vdb

function prepare_servera {
    rht-vmctl poweroff servera -q &> /dev/null
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-b.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-c.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-d.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-e.qcow2
    virsh detach-disk servera vdb --live --config &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-b.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    rht-vmctl start servera -q &> /dev/null
}


function prepare_serverb {
    rht-vmctl poweroff serverb -q &> /dev/null
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-b.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-c.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-d.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-e.qcow2
    qemu-img create -f qcow2 /var/lib/libvirt/images/serverb-f.qcow2 1000M &> /dev/null
    qemu-img create -f qcow2 /var/lib/libvirt/images/serverb-g.qcow2 1000M &> /dev/null

    virsh detach-disk serverb vdb --live --config &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-b.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-f.qcow2 vdf --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverb /var/lib/libvirt/images/serverb-g.qcow2 vdg --config --subdriver qcow2 &> /dev/null
    rht-vmctl start serverb -q &> /dev/null
}

function prepare_serverc {
    rht-vmctl poweroff serverc -q &> /dev/null
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-b.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-c.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-d.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-e.qcow2
    qemu-img create -f qcow2 /var/lib/libvirt/images/serverc-f.qcow2 2G &> /dev/null

    virsh detach-disk serverc vdb --live --config &> /dev/null
    virsh attach-disk serverc /var/lib/libvirt/images/serverc-b.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverc /var/lib/libvirt/images/serverc-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverc /var/lib/libvirt/images/serverc-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverc /var/lib/libvirt/images/serverc-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverc /var/lib/libvirt/images/serverc-f.qcow2 vdf --config --subdriver qcow2 &> /dev/null
    rht-vmctl start serverc -q &> /dev/null
}

function prepare_serverd {
    rht-vmctl poweroff serverd -q &> /dev/null
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-b.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-c.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-d.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-e.qcow2
    virsh attach-disk serverd /var/lib/libvirt/images/serverd-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverd /var/lib/libvirt/images/serverd-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverd /var/lib/libvirt/images/serverd-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    virsh detach-disk serverd vdb --live --config &> /dev/null
    rht-vmctl start serverd -q &> /dev/null
}

function prepare_workstation {
    rht-vmctl poweroff workstation -q &> /dev/null
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-b.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-c.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-d.qcow2
    cp /content/rhel9.3/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-e.qcow2
    virsh detach-disk workstation vdb --config &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-b.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    rht-vmctl start workstation -q &> /dev/null

}

############################################################################################33


if ! [ "$(id -u)" -eq 0 ]; then  
     echo "必须用root用户运行, 使用su - root切换到root用户, root密码Asimov"
     exit 1
fi

cd /root

cat > /root/inventory <<-'EOF'
[dev]
workstation
[test]
servera
[prod]
serverb
serverc
[balancers]
serverd
[webservers:children]
prod
EOF

ansible-config init --disabled > ansible.cfg
sed -i 's/^\;inventory=\/etc\/ansible\/hosts$/inventory=\/root\/inventory/' ansible.cfg

echo "正在重置你的所有被管理节点"
for host in servera serverb serverc serverd workstation;do
    rht-vmctl fullreset $host -q &> /dev/null
done

prepare_servera
prepare_serverb
prepare_serverc
prepare_serverd
prepare_workstation

echo "请稍后, 正在启动servera并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 1 servera &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动serverb并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 1 serverb &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动serverc并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 1 serverc &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动serverd并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 1 serverd &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动workstation并等待其上线,如果5分钟还无法上线,请手工重启此虚拟机"
while true;do ping -c 1 workstation &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 10s
        break
    fi
done
virsh detach-disk serverd vdb --live --config &> /dev/null

# permitrootlogin on all hosts

for host in classroom bastion workstation servera serverb serverc serverd;do
    ssh -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no root@$host "echo flectrag | passwd --stdin root" &> /dev/null
    ssh -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no root@$host "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config" &> /dev/null
    ssh -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no root@$host 'systemctl restart sshd' &> /dev/null
done
# prepare for selinux
for host in servera serverb serverc serverd workstation;do
    sshpasscmd $host 'setenforce 0'
    sshpasscmd $host 'sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config'
done

echo "正在准备greg账号"

# greg on workstation
sshpasscmd workstation "useradd -G wheel greg" &> /dev/null
sshpasscmd workstation "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd workstation "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd workstation "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd workstation "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd workstation "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd workstation "chown greg:greg /home/greg/ -R" &> /dev/null
sshpasscmd workstation "useradd webdev" &> /dev/null


# greg on servera
sshpasscmd servera "useradd -G wheel greg" &> /dev/null
sshpasscmd servera "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd servera "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd servera "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd servera "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd servera "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd servera "chown greg:greg /home/greg/ -R" &> /dev/null
sshpasscmd servera 'vgcreate research /dev/vdb' &> /dev/null
sshpasscmd servera "useradd natasha" &> /dev/null



# greg on serverb
sshpasscmd serverb "useradd -G wheel greg" &> /dev/null
sshpasscmd serverb "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd serverb "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd serverb "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd serverb "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd serverb "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd serverb "chown greg:greg /home/greg/ -R" &> /dev/null
sshpasscmd serverb 'vgcreate research /dev/vdb' &> /dev/null


# greg on serverc
sshpasscmd serverc "useradd -G wheel greg" &> /dev/null
sshpasscmd serverc "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd serverc "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd serverc "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd serverc "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd serverc "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd serverc "chown greg:greg /home/greg/ -R" &> /dev/null
sshpasscmd serverc 'vgcreate research /dev/vdb' &> /dev/null

# greg on serverd
sshpasscmd serverd "useradd -G wheel greg" &> /dev/null
sshpasscmd serverd "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd serverd "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd serverd "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd serverd "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd serverd "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd serverd "chown greg:greg /home/greg/ -R" &> /dev/null
sshpasscmd serverd "systemctl disable firewalld --now" &> /dev/null
sshpasscmd serverd 'vgcreate research /dev/vdc' &> /dev/null

# copy key to hosts
# remove python3-pyOpenSSL.noarch for fix selinux.yml error on x509 check

for host in bastion workstation servera serverb serverc serverd; do
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion "sshpass -p flectrag ssh-copy-id -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@$host" &> /dev/null;
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no root@$host 'dnf remove python3-pyOpenSSL.noarch -y' &> /dev/null;
done

#######################################################################################################

# running your playbook
echo "正在运行你的playbook,可能需要较多时间，请等待"

sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/yum_repo.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/packages.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/selinux.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/apache.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/roles.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/lv.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/partition.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/hosts.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/issue.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/webcontent.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/hwreport.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/users.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/cron.yml'
sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion 'cd /home/greg/ansible/ && ansible-navigator run -m stdout /home/greg/ansible/timesync.yml'


echo
echo
echo "Playbook 运行完毕, 正在进行结果检测"
echo
echo

ansible_install
configure_repo
install_software
use_sysrole
configure_collection
install_role
create_apache_role
use_galaxy_role
create_lv
create_partition
create_hosts_file
modify_file_content
create_web_content
create_hardware_report
create_vault
create_user
update_vault
cronfile
timesyncrole

echo
echo '===================================================================='
echo
# total score is 303, calc your score

yourscore=$((score * 300 / 303))

if [ $yourscore -gt 210 ];then
  pass && echo "你本次的得分为: $yourscore, 通过了测试"
else
  fail && echo "你本次的得分为: $yourscore, 暂未通过测试, 加油"
fi
echo