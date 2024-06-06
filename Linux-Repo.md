```textile
作者：李晓辉

微信联系：Lxh_Chat

联系邮箱: 939958092@qq.com
```

# CentOS 7

## 阿里云

```bash
mkdir /opt/repo
mv /etc/yum.repos.d/* /opt/repo
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
curl -o /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo
yum install vim bash-completion wget -y
```

## 清华大学

```bash
mkdir /opt/repo
mv /etc/yum.repos.d/* /opt/repo
cat > /etc/yum.repos.d/centos7.repo <<EOF
[QingHua-atomic]
name=QingHua-atomic
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/atomic/x86_64/
enabled=1
gpgcheck=0
[QingHua-centosplus]
name=QingHua-centosplus
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/centosplus/x86_64/
enabled=1
gpgcheck=0
[QingHua-dotnet]
name=QingHua-dotnet
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/dotnet/x86_64/
enabled=1
gpgcheck=0
[QingHua-extras]
name=QingHua-extras
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/extras/x86_64/
enabled=1
gpgcheck=0
[QingHua-fasttrack]
name=QingHua-fasttrack
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/fasttrack/x86_64/
enabled=1
gpgcheck=0
[QingHua-infra-common]
name=QingHua-infra-common
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/infra/x86_64/infra-common/
enabled=1
gpgcheck=0
[QingHua-buildtools-common]
name=QingHua-buildtools-common
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/infra/x86_64/buildtools-common/
enabled=1
gpgcheck=0
[QingHua-gitforge-pagure]
name=QingHua-gitforge-pagure
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/infra/x86_64/gitforge-pagure/
enabled=1
gpgcheck=0
[QingHua-qpid-dispatch]
name=QingHua-qpid-dispatch
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/messaging/x86_64/qpid-dispatch/
enabled=1
gpgcheck=0
[QingHua-qpid-proton]
name=QingHua-qpid-proton
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/messaging/x86_64/qpid-proton/
enabled=1
gpgcheck=0
[QingHua-nfv-common]
name=QingHua-buildtools-common
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/nfv/x86_64/common/
enabled=1
gpgcheck=0
[QingHua-nfv-fdio]
name=QingHua-nfv-fdio
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/nfv/x86_64/fdio/
enabled=1
gpgcheck=0
[QingHua-opstools]
name=QingHua-opstools
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/opstools/x86_64/
enabled=1
gpgcheck=0
[QingHua-os]
name=QingHua-os
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/os/x86_64/
enabled=1
gpgcheck=0
[QingHua-rt]
name=QingHua-rt
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/rt/x86_64/
enabled=1
gpgcheck=0
[QingHua-sclo-rh]
name=QingHua-sclo-rh
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/sclo/x86_64/rh/
enabled=1
gpgcheck=0
[QingHua-sclo-sclo]
name=QingHua-sclo-sclo
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/sclo/x86_64/sclo/
enabled=1
gpgcheck=0
[QingHua-updates]
name=QingHua-updates
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/updates/x86_64/
enabled=1
gpgcheck=0
[QingHua-libvirt-latest]
name=QingHua-libvirt-latest
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/virt/x86_64/libvirt-latest/
enabled=1
gpgcheck=0
[QingHua-azure]
name=QingHua-azure
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/virt/x86_64/azure/
enabled=1
gpgcheck=0
[QingHua-azure-kernel]
name=QingHua-azure-kernel
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/virt/x86_64/azure-kernel/
enabled=1
gpgcheck=0
[QingHua-kvm-common]
name=QingHua-kvm-common
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/virt/x86_64/kvm-common/
enabled=1
gpgcheck=0
[QingHua-ovirt-common]
name=QingHua-ovirt-common
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/virt/x86_64/ovirt-common/
enabled=1
gpgcheck=0
EOF
```

# CentOS 8

## 阿里云

```bash
mkdir /opt/repo
mv /etc/yum.repos.d/* /opt/repo
cat > /etc/yum.repos.d/system.repo <<EOF
[HighAvailability]
name=HighAvailability
baseurl=https://mirrors.aliyun.com/centos/8-stream/HighAvailability/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[BaseOS]
name=BaseOS
baseurl=https://mirrors.aliyun.com/centos/8-stream/BaseOS/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[extras]
name=extras
baseurl=https://mirrors.aliyun.com/centos/8-stream/extras/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[centosplus]
name=centosplus
baseurl=https://mirrors.aliyun.com/centos/8-stream/centosplus/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[AppStream]
name=AppStream
baseurl=https://mirrors.aliyun.com/centos/8-stream/AppStream/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[nfv]
name=AppStream
baseurl=https://mirrors.aliyun.com/centos/8-stream/nfv/x86_64/openvswitch-2
enabled=1
gpgcheck=0
module_hotfixes=1
[cloud]
name=cloud
baseurl=https://mirrors.aliyun.com/centos/8-stream/cloud/x86_64/openstack-yoga
enabled=1
gpgcheck=0
module_hotfixes=1
[devel]
name=devel
baseurl=https://mirrors.aliyun.com/centos/8-stream/Devel/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[PowerTools]
name=PowerTools
baseurl=https://mirrors.aliyun.com/centos/8-stream/PowerTools/x86_64/os/
enabled=1
gpgcheck=0
module_hotfixes=1
[epel-release]
name=epel-release
baseurl=https://mirrors.aliyun.com/epel/8/Everything/x86_64
enabled=1
gpgcheck=0
module_hotfixes=1
EOF
yum install vim bash-completion wget -y
```

## 清华大学

```bash
mkdir /opt/repo
mv /etc/yum.repos.d/* /opt/repo
cat > /etc/yum.repos.d/system.repo <<EOF
[Qinghua-HighAvailability]
name=Qinghua-HighAvailability
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/HighAvailability/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-BaseOS]
name=Qinghua-BaseOS
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/BaseOS/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-extras]
name=Qinghua-extras
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/extras/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-centosplus]
name=Qinghua-centosplus
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/centosplus/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-AppStream]
name=Qinghua-AppStream
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/AppStream/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-nfv]
name=Qinghua-nfv
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/nfv/x86_64/openvswitch-2
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-cloud]
name=Qinghua-cloud
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/cloud/x86_64/openstack-yoga
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-devel]
name=Qinghua-devel
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/Devel/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-PowerTools]
name=Qinghua-PowerTools
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/8-stream/PowerTools/x86_64/os/
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-epel-release]
name=Qinghua-epel-release
baseurl=https://mirrors.tuna.tsinghua.edu.cn/epel/8/Everything/x86_64
enabled=1
gpgcheck=0
module_hotfixes=1
EOF
yum install vim bash-completion wget -y
```

# CentOS 9

## 阿里云

```bash
mkdir /opt/repo
mv /etc/yum.repos.d/* /opt/repo
cat > /etc/yum.repos.d/system.repo <<EOF
[Qinghua-BaseOS]
name=Qinghua-BaseOS
baseurl=https://mirrors.aliyun.com/centos-stream/9-stream/BaseOS/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-AppStream]
name=Qinghua-AppStream
baseurl=https://mirrors.aliyun.com/centos-stream/9-stream/AppStream/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-HighAvailability]
name=Qinghua-HighAvailability
baseurl=https://mirrors.aliyun.com/centos-stream/9-stream/HighAvailability/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-epel-release]
name=Qinghua-epel-release
baseurl=https://mirrors.aliyun.com/epel/9/Everything/x86_64
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-extras]
name=Qinghua-extras
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/extras/x86_64/extras-common
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-nfv]
name=Qinghua-nfv
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/nfv/x86_64/openvswitch-2
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-cloud]
name=Qinghua-cloud
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/cloud/x86_64/openstack-yoga
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-Core]
name=Qinghua-Core
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/core/x86_64/centos-plus
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-infra]
name=Qinghua-infra
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/infra/x86_64/infra-common
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-kmods-main]
name=Qinghua-kmods-main
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/kmods/x86_64/packages-main
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-kmods-rebuild]
name=Qinghua-kmods-rebuild
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/kmods/x86_64/packages-rebuild
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-messaging]
name=Qinghua-messaging
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/messaging/x86_64/rabbitmq-38
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-opstools]
name=Qinghua-opstools
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/opstools/x86_64/collectd-5
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghu-virt-45]
name=Qinghua-virt-45
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/virt/x86_64/ovirt-45
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-kata-containers]
name=Qinghua-kata-containers
baseurl=https://mirrors.aliyun.com/centos-stream/SIGs/9-stream/virt/x86_64/kata-containers
enabled=1
gpgcheck=0
module_hotfixes=1
EOF
yum install vim bash-completion wget -y
```

## 清华大学

```bash
mkdir /opt/repo
mv /etc/yum.repos.d/* /opt/repo
cat > /etc/yum.repos.d/system.repo <<EOF
[Qinghua-BaseOS]
name=Qinghua-BaseOS
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/9-stream/BaseOS/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-AppStream]
name=Qinghua-AppStream
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/9-stream/AppStream/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-HighAvailability]
name=Qinghua-HighAvailability
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/9-stream/HighAvailability/x86_64/os
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-epel-release]
name=Qinghua-epel-release
baseurl=https://mirrors.tuna.tsinghua.edu.cn/epel/9/Everything/x86_64
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-extras]
name=Qinghua-extras
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/extras/x86_64/extras-common
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-nfv]
name=Qinghua-nfv
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/nfv/x86_64/openvswitch-2
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-cloud]
name=Qinghua-cloud
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/cloud/x86_64/openstack-yoga
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-Core]
name=Qinghua-Core
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/core/x86_64/centos-plus
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-infra]
name=Qinghua-infra
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/infra/x86_64/infra-common
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-kmods-main]
name=Qinghua-kmods-main
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/kmods/x86_64/packages-main
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-kmods-rebuild]
name=Qinghua-kmods-rebuild
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/kmods/x86_64/packages-rebuild
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-messaging]
name=Qinghua-messaging
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/messaging/x86_64/rabbitmq-38
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-opstools]
name=Qinghua-opstools
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/opstools/x86_64/collectd-5
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghu-virt-45]
name=Qinghua-virt-45
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/virt/x86_64/ovirt-45
enabled=1
gpgcheck=0
module_hotfixes=1
[Qinghua-kata-containers]
name=Qinghua-kata-containers
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-stream/SIGs/9-stream/virt/x86_64/kata-containers
enabled=1
gpgcheck=0
module_hotfixes=1
EOF
yum install vim bash-completion wget -y
```

# Ubuntu

## 南京大学

```bash
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat > /etc/apt/sources.list <<EOF
deb https://mirror.nju.edu.cn/ubuntu focal main restricted
deb https://mirror.nju.edu.cn/ubuntu focal-updates main restricted
deb https://mirror.nju.edu.cn/ubuntu focal universe
deb https://mirror.nju.edu.cn/ubuntu focal-updates universe
deb https://mirror.nju.edu.cn/ubuntu focal multiverse
deb https://mirror.nju.edu.cn/ubuntu focal-updates multiverse
deb https://mirror.nju.edu.cn/ubuntu focal-backports main restricted universe multiverse
deb https://mirror.nju.edu.cn/ubuntu focal-security main restricted
deb https://mirror.nju.edu.cn/ubuntu focal-security universe
deb https://mirror.nju.edu.cn/ubuntu focal-security multiverse
deb https://mirror.nju.edu.cn/docker-ce/linux/ubuntu/ focal stable
deb https://mirror.nju.edu.cn/kubernetes/apt/ kubernetes-xenial main
EOF
apt update && apt install vim wget curl bash-completion -y
```

# Python PIP仓库

```bash
pip install xxx -i url
```

```text
清华大学 ：https://pypi.tuna.tsinghua.edu.cn/simple/

阿里云：http://mirrors.aliyun.com/pypi/simple/

中国科学技术大学 ：http://pypi.mirrors.ustc.edu.cn/simple/

华中科技大学：http://pypi.hustunique.com/

豆瓣源：http://pypi.douban.com/simple/

腾讯源：http://mirrors.cloud.tencent.com/pypi/simple

华为镜像源：https://repo.huaweicloud.com/repository/pypi/simple/

```