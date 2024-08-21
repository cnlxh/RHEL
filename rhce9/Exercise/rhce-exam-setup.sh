#!/bin/bash
####################################################################
# create for rh294
# created by Xiaohui Li
# contact me via wechat: Lxh_Chat
# self test only, please do not use it on production or others

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


# main setup

function ansible_setup {
echo "正在准备/home/greg/.ansible-navigator.yml"
cat > /tmp/ansible-navigator.yml <<- EOF
---
ansible-navigator:
  execution-environment:
    image: utility.lab.example.com/ee-supported-rhel8:latest
    pull:
      policy: missing
  playbook-artifact:
    enable: false 
EOF
scp -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey /tmp/ansible-navigator.yml root@bastion:/home/greg/.ansible-navigator.yml &> /dev/null
ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@bastion 'chown greg:greg /home/greg/.ansible-navigator.yml -R' &> /dev/null
rm -rf /tmp/ansible-navigator.yml
}
function remove_repo_from_managed {
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@servera 'rm -rf /etc/yum.repos.d/*'
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@serverb 'rm -rf /etc/yum.repos.d/*'
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@serverc 'rm -rf /etc/yum.repos.d/*'
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@serverd 'rm -rf /etc/yum.repos.d/*'
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@workstation 'rm -rf /etc/yum.repos.d/*'
}
function set_selinux {
for host in servera serverb serverc serverd workstation;do
    sshpasscmd $host 'setenforce 0'
    sshpasscmd $host 'sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config'
done
}
function collection {
    echo "正在准备集合内容"
    cp ./redhat-insights-1.0.7.tar.gz /content/courses/rh294/rhel9.0/materials/ &> /dev/null
    cp ./community-general-5.5.0.tar.gz /content/courses/rh294/rhel9.0/materials/ &> /dev/null
    cp ./redhat-rhel_system_roles-1.19.3.tar.gz /content/courses/rh294/rhel9.0/materials/ &> /dev/null
    if ! [ -e /content/courses/rh294/rhel9.0/materials/redhat-insights-1.0.7.tar.gz ] && ! [ -e /content/courses/rh294/rhel9.0/materials/community-general-5.5.0.tar.gz ] && ! [ -e /content/courses/rh294/rhel9.0/materials/redhat-rhel_system_roles-1.19.3.tar.gz ];then
        fail && echo "没有在/content/courses/rh294/rhel9.0/materials检测到三个集合, 请手工把三个集合压缩包复制到/content/courses/rh294/rhel9.0/materials中"
    fi
    sshpasscmd classroom systemctl restart httpd &> /dev/null
}

function galaxy_install {
    echo "正在准备phpinfo和haproxy 角色"
    cp ./haproxy.tar /content/courses/rh294/rhel9.0/materials/ &> /dev/null
    cp ./phpinfo.tar /content/courses/rh294/rhel9.0/materials/ &> /dev/null
    if ! [ -e /content/courses/rh294/rhel9.0/materials/haproxy.tar ] || ! [ -e/content/courses/rh294/rhel9.0/materials/phpinfo.tar ];then
        fail && echo "没有在/content/courses/rh294/rhel9.0/materials检测到两个角色安装包, 请手工把压缩包复制到/content/courses/rh294/rhel9.0/materials中"
    fi
    sshpasscmd classroom systemctl restart httpd &> /dev/null
    sshpasscmd serverd 'systemctl disable firewalld --now' &> /dev/null

}
function create_lvm {
    echo "正在准备research vg"
    sshpasscmd servera 'vgcreate research /dev/vdb' &> /dev/null
    sshpasscmd serverb 'vgcreate research /dev/vdb' &> /dev/null
    sshpasscmd serverc 'vgcreate research /dev/vdb' &> /dev/null
    sshpasscmd serverd 'vgcreate research /dev/vdc' &> /dev/null
}

function genarate_hostfile {
    echo "正在准备hosts.j2和hosts.yml"
cat > /content/courses/rh294/rhel9.0/materials/hosts.j2 << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
EOF
touch /content/courses/rh294/rhel9.0/materials/hosts.yml
sshpasscmd classroom systemctl restart httpd &> /dev/null
}

function create_webcontent {
    echo "正在准备webdev组"
    sshpasscmd workstation 'groupadd webdev' &> /dev/null
}
function genarate_hardware_report {
echo "正在准备hwreport.empty"
cat > /content/courses/rh294/rhel9.0/materials/hwreport.empty << EOF
# Hardware report
HOST=inventoryhostname
MEMORY=memory_in_MB
BIOS=BIOS_version
DISK_SIZE_VDA=disk_vda_size
DISK_SIZE_VDB=disk_vdb_size
EOF
sshpasscmd classroom systemctl restart httpd &> /dev/null
}
function create_user_account {
echo "正在准备user_list.yml"
cat > /content/courses/rh294/rhel9.0/materials/user_list.yml << EOF
users:
  - name: bob
    job: developer
    password_expire_max: 30
    uid: 3000
  - name: sally
    job: manager
    password_expire_max: 30
    uid: 3001
  - name: fred
    job: developer
    password_expire_max: 30
    uid: 3002
EOF
sshpasscmd classroom 'systemctl restart httpd' &> /dev/null
}
function update_vault_pass {
echo "正在准备salaries.yml"
cat > /content/courses/rh294/rhel9.0/materials/salaries.yml << "EOF"
$ANSIBLE_VAULT;1.1;AES256
30663136613361646566623236613636363637666234336639643037353861373066643366343764
3166313830316162333838623537386161353637373935300a316463633364616461636335323336
36316163656266303261343763666432623931326530623934663930393939663233306535346631
3236306163633833300a623836616639303732663833353832346435373736313230373036336132
6235
EOF
sshpasscmd classroom 'systemctl restart httpd' &> /dev/null
sshpasscmd bastion 'echo bbs2you9527 > /tmp/vault'

}

function configure_contab {
echo "正在准备natasha用户"
sshpasscmd servera 'useradd natasha' &> /dev/null
sshpasscmd servera 'echo flectrag | passwd --stdin natasha' &> /dev/null
}

# configure vdb

function prepare_servera {
    rht-vmctl poweroff servera -q &> /dev/null
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-b.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-c.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-d.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/servera-e.qcow2
    virsh detach-disk servera vdb --live --config &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-b.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk servera /var/lib/libvirt/images/servera-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    rht-vmctl start servera -q &> /dev/null
}


function prepare_serverb {
    rht-vmctl poweroff serverb -q &> /dev/null
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-b.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-c.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-d.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverb-e.qcow2
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
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-b.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-c.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-d.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverc-e.qcow2
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
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-b.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-c.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-d.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/serverd-e.qcow2
    virsh attach-disk serverd /var/lib/libvirt/images/serverd-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverd /var/lib/libvirt/images/serverd-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk serverd /var/lib/libvirt/images/serverd-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    virsh detach-disk serverd vdb --live --config &> /dev/null
    rht-vmctl start serverd -q &> /dev/null
}

function prepare_workstation {
    rht-vmctl poweroff workstation -q &> /dev/null
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-b.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-c.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-d.qcow2
    cp /content/rhel9.0/x86_64/vms/rh134-servera-vdb.qcow2 /var/lib/libvirt/images/workstation-e.qcow2
    virsh detach-disk workstation vdb --config &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-b.qcow2 vdb --config --subdriver qcow2 &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-c.qcow2 vdc --config --subdriver qcow2 &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-d.qcow2 vdd --config --subdriver qcow2 &> /dev/null
    virsh attach-disk workstation /var/lib/libvirt/images/workstation-e.qcow2 vde --config --subdriver qcow2 &> /dev/null
    rht-vmctl start workstation -q &> /dev/null
for host in servera serverb serverc serverd workstation;do
    while true;do ping -c 1 $host &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
        else
            rht-vmctl start $host &> /dev/null
        break
        fi
    done
done
}


#############################################################################3
# excute

if ! [ "$(id -u)" -eq 0 ]; then  
     echo "必须用root用户运行, 使用su - root切换到root用户, root密码Asimov"
     exit 1
fi

echo "请稍后, 正在将你的所有虚拟机关机"
rht-vmctl poweroff all -q &>/dev/null
rht-clearcourse 0 &>/dev/null

echo "请稍后, 正在设置课程代码"
rht-setcourse rh294 &>/dev/null
    if ! grep -q 294 /etc/rht; then
        fail && echo "课程设置失败, 请恢复foundation快照, 手工设置为RH294"
        exit 1
    fi

# add classroom hosts for fix classroom hang

echo 172.25.254.254 classroom.example.com classroom >> /etc/hosts &>/dev/null

echo "请稍后, 正在启动classroom并等待其上线"
rht-vmctl fullreset classroom -q &> /dev/null
while true;do ping -c 1 classroom &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
    break
    fi
done

echo "请稍后, 正在启动bastion和utility并等待其上线"
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

# prepare repository on bastion

cat > /tmp/ansible.repo <<EOF
[ansible-automation-platform-2.2-for-rhel-9-x86_64-rpms]
baseurl = http://content.example.com/rhel9.0/x86_64/rhel9-additional/ansible-automation-platform-2.2-for-rhel-9-x86_64-rpms
enabled = true
gpgcheck = false
name = Red Hat Ansible Automation Platform 2.2 for RHEL 9 x86_64 (RPMs)

[rhel-9-for-x86_64-baseos-rpms-updates]
baseurl = http://content.example.com/rhel9.0/x86_64/rhel9-additional/rhel-9-for-x86_64-baseos-rpms
enabled = true
gpgcheck = false
name = Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs) - Updates

[rhel-9-for-x86_64-appstream-rpms-updates]
baseurl = http://content.example.com/rhel9.0/x86_64/rhel9-additional/rhel-9-for-x86_64-appstream-rpms
enabled = true
gpgcheck = false
name = Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs) - Updates
EOF
scp -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no /tmp/ansible.repo root@bastion:/etc/yum.repos.d/ &> /dev/null
rm -rf /tmp/ansible.repo

echo "请稍后, 正在批量重置servera|serverb|serverc|serverd|workstation"
for host in workstation servera serverb serverc serverd;do
    rht-vmctl fullreset $host -q &> /dev/null
done

echo "请稍后, 正在准备虚拟机硬件"
prepare_servera
prepare_serverb
prepare_serverc
prepare_serverd
prepare_workstation

echo "请稍后, 正在启动servera并等待其上线"
while true;do ping -c 1 servera &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动serverb并等待其上线"
while true;do ping -c 1 serverb &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动serverc并等待其上线"
while true;do ping -c 1 serverc &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动serverd并等待其上线"

while true;do ping -c 1 serverd &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在启动workstation并等待其上线"

while true;do ping -c 1 workstation &> /dev/null
    if [ $? -eq 0 ]; then
        sleep 5s
        break
    fi
done

echo "请稍后, 正在最终确认虚拟机是否全部上线"
for host in servera serverb serverc serverd workstation;do
    while true;do ping -c 1 $host &> /dev/null
        if [ $? -eq 0 ]; then
            sleep 5s
            break
        else
            rht-vmctl start $host &> /dev/null
        fi
    done
done

# permitrootlogin on all hosts

for host in classroom bastion workstation servera serverb serverc serverd;do
    ssh -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no root@$host "echo flectrag | passwd --stdin root" &> /dev/null
    ssh -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no root@$host "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config" &> /dev/null
    ssh -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no root@$host 'systemctl restart sshd' &> /dev/null
done


# update ca certificate on bastion for utility registry
cat > /tmp/ca.cert <<EOF
-----BEGIN CERTIFICATE-----
MIIGFTCCA/2gAwIBAgIUSXUQiU9WrLJrG4wDpmJY1Et4tLYwDQYJKoZIhvcNAQEL
BQAwgZgxCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJOQzEQMA4GA1UEBwwHUmFsZWln
aDEWMBQGA1UECgwNUmVkIEhhdCwgSW5jLjERMA8GA1UECwwIVHJhaW5pbmcxPzA9
BgNVBAMMNlJlZCBIYXQgVHJhaW5pbmcgKyBDZXJ0aWZpY2F0aW9uIENlcnRpZmlj
YXRlIEF1dGhvcml0eTAeFw0yMjA5MTUyMDQ2NDNaFw0zMjA5MTIyMDQ2NDNaMHkx
CzAJBgNVBAYTAlVTMQswCQYDVQQIDAJOQzEQMA4GA1UEBwwHUmFsZWlnaDEWMBQG
A1UECgwNUmVkIEhhdCwgSW5jLjERMA8GA1UECwwIVHJhaW5pbmcxIDAeBgNVBAMM
F3V0aWxpdHkubGFiLmV4YW1wbGUuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8A
MIICCgKCAgEAr+WPNe5RF0KPF3t8izL0oH9ziNToVL17drXcmZXpzTy1JU/jgsPK
BsJdL+8H7anVsibYLYppEaIymc2Mwlqbs+jyFECwOMv+nFqCkalW6PtoT6Ov7kt4
a9MzvIUjzLfZaGGKtDsntgDvVbjH2ButgDIfAtiA8FZUvF6yaOgioulQfJGEXG+C
PJK81nB5NSbpxANEEOsDzZM6al9GUyWKUu4cxTsf74oe9jvqy7NWYVutFCNc8fSM
Ashyy7ErPvFCzgar8AemD5wWOEJdSoOdUAnPNQszKDOjOOPPAiSHzPKdRMjmKCP8
bJq8aNNNF0hDPFKSuJw2ihh9uikBpX8wXCjinhMeREVmasE1lclRaWekTMyZazYu
2T6FPC2WsQek+dWLcvgKdkcT+WxR31oirGK+t83vuy2bTXkUqPI9YJkAba4HnegN
eFsietwSWGlQ93dATO3ol54xXGR98ealttdXwltmN5NExd8RiGPJJoD9P2ju44uR
z45MlBqRpzLyHW1WMBAQW1RtT+mCiltJg9SpEnXR2YxuYfmjoBuFOjaBqVr7oO3l
/EskOj8x+XKqmx4oM9jERdxCqJHYAa8xJkcsmJuL2ISZLss3PFpC99Ux1EzE9vq2
qA+q0sv8ciXkhleUTtgqefiCXfYVVSB6oiWK2Gv8UaIqJbytm+5KsK8CAwEAAaN1
MHMwMQYDVR0RBCowKIIXdXRpbGl0eS5sYWIuZXhhbXBsZS5jb22CB3V0aWxpdHmH
BKwZ+twwHQYDVR0OBBYEFJK1RJQ9kzAN3qefwEYysivOhS3DMB8GA1UdIwQYMBaA
FMvXIy8/ap3NXLS2sVQbLO3xRljOMA0GCSqGSIb3DQEBCwUAA4ICAQCaOS3A/05y
rq7fh6Q8wOC+1NIQt6awxG74ROM3muA+rZdm3mwukEDQAUKb3j5H1U+Xo2tIfF6A
NYHOaDlrnc4lbT68X7LbLDlTCGR2J8/6qm/u0vi0Gn8WJ/DMuHxkdQ6oa9r9lcUA
h+4QEjEPKbTOE7Hu4ofaMak10/pQYDM6NcpVcCY/JZoAqinPeSoFWPylBO4/1Gzt
QxdtXsOlhcvfYt9nF/s6w+CS7BDtywS38xAUWtbrwFWZ/2NUR2jPaFnV/Xs/m4SV
keSgordl1OdFhF7FK+CzRkULlB2GWcIRfFy7NCTCmofYa9dOGg4U2XlxFUi0G60T
ZxFiqx5uJaLtnBynMkpdAvnHJFTWHUKTSN9naMBxDGm1lg9MthN/5d7aKyU2DfOU
ncAuTqvise3O2WQsTjaGV4x/lEYO/+XnqftM51gOXIEAtzIuOeO8nmxW+q065ppy
rlxIu97Bmiw4zc2u4+wQrBujWByTiwr6GxmracA1tFB7r5VBNFqdJ6oIziTVcQND
pE2aVwJiAEEQmbmWJJgy/YB77L1vFoPkdpY/QdhAc0npZfImNyQwsdX9Mnb00I0g
p22bz8Q+pj3/3xRY7JNHfwGkoTZcoGEBHbcIlJ7BmipL/FE6BlO9/5mdf+g1+bab
0b2EW0X/dWotcdHsAkHI1MDGusM7pv/vYA==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
wS2ZmgBJ
-----END CERTIFICATE-----
EOF

scp -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey /tmp/ca.cert root@bastion:/etc/pki/tls/certs/utility.crt &> /dev/null
ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@bastion 'update-ca-trust'
rm -rf /tmp/ca.cert

echo "正在准备greg账号"
# greg on bastion

sshpasscmd bastion "useradd -G wheel greg" &> /dev/null
sshpasscmd bastion "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd bastion "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd bastion "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd bastion "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd bastion "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd bastion "chown greg:greg /home/greg/ -R" &> /dev/null

# greg on workstation
sshpasscmd workstation "useradd -G wheel greg" &> /dev/null
sshpasscmd workstation "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd workstation "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd workstation "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd workstation "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd workstation "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd workstation "chown greg:greg /home/greg/ -R" &> /dev/null

# greg on servera
sshpasscmd servera "useradd -G wheel greg" &> /dev/null
sshpasscmd servera "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd servera "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd servera "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd servera "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd servera "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd servera "chown greg:greg /home/greg/ -R" &> /dev/null

# greg on serverb
sshpasscmd serverb "useradd -G wheel greg" &> /dev/null
sshpasscmd serverb "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd serverb "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd serverb "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd serverb "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd serverb "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd serverb "chown greg:greg /home/greg/ -R" &> /dev/null

# greg on serverc
sshpasscmd serverc "useradd -G wheel greg" &> /dev/null
sshpasscmd serverc "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd serverc "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd serverc "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd serverc "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd serverc "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd serverc "chown greg:greg /home/greg/ -R" &> /dev/null

# greg on serverd
sshpasscmd serverd "useradd -G wheel greg" &> /dev/null
sshpasscmd serverd "echo flectrag | passwd --stdin greg" &> /dev/null
sshpasscmd serverd "sed -i 's/^%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers"
sshpasscmd serverd "rm -rf /home/greg/.ssh" &> /dev/null
sshpasscmd serverd "mkdir /home/greg/.ssh" &> /dev/null
sshpasscmd serverd "ssh-keygen -f /home/greg/.ssh/id_rsa -N ''" &> /dev/null
sshpasscmd serverd "chown greg:greg /home/greg/ -R" &> /dev/null

# copy key to hosts

for host in bastion workstation servera serverb serverc serverd; do
    sshpass -p flectrag ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@bastion "sshpass -p flectrag ssh-copy-id -o PreferredAuthentications=password -o StrictHostKeyChecking=no greg@$host" &> /dev/null;
done

ansible_setup
remove_repo_from_managed
set_selinux
collection
galaxy_install
create_lvm
genarate_hostfile
create_webcontent
genarate_hardware_report
create_user_account
update_vault_pass
configure_contab


# detach vdb from serverd and set multi-user on workstation for reduce hardware resources
virsh detach-disk serverd vdb --live --config &> /dev/null
ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@workstation 'systemctl set-default multi-user.target' &> /dev/null
ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey root@workstation 'reboot' &> /dev/null

