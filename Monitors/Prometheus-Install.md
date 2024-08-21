```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

|机器名|IP地址|操作系统|角色
|-|-|-|-|
|monitor|192.168.8.10|CentOS Stream 9|Prometheus<br>Grafana|
|node|192.168.8.20|CentOS Stream 9|被监控的机器|

# Prometheus 服务端

## 互相解析

```bash
cat > /etc/hosts <<-'EOF'
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.8.10 monitor
192.168.8.20 node
EOF
```

## 下载安装Prometheus

安装来源

```text
https://github.com/prometheus/prometheus/releases
```

下载对应版本的软件包，并将二进制程序放进/usr/bin中

```bash
[root@monitor ~]# wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz

[root@monitor ~]# tar xf prometheus-2.52.0.linux-amd64.tar.gz ^C

[root@monitor ~]# cd prometheus-2.52.0.linux-amd64

[root@monitor prometheus-2.52.0.linux-amd64]# ll
total 262492
drwxr-xr-x. 2 1001 127        38 May  9 06:11 console_libraries
drwxr-xr-x. 2 1001 127       173 May  9 06:11 consoles
-rw-r--r--. 1 1001 127     11357 May  9 06:11 LICENSE
-rw-r--r--. 1 1001 127      3773 May  9 06:11 NOTICE
-rwxr-xr-x. 1 1001 127 138438117 May  9 05:58 prometheus
-rw-r--r--. 1 1001 127       934 May  9 06:11 prometheus.yml
-rwxr-xr-x. 1 1001 127 130329948 May  9 05:58 promtool

[root@monitor prometheus-2.52.0.linux-amd64]# cp prometheus promtool /usr/bin/

[root@monitor prometheus-2.52.0.linux-amd64]# prometheus --version
prometheus, version 2.52.0 (branch: HEAD, revision: 879d80922a227c37df502e7315fad8ceb10a986d)
  build user:       root@1b4f4c206e41
  build date:       20240508-21:56:43
  go version:       go1.22.3
  platform:         linux/amd64
  tags:             netgo,builtinassets,stringlabels
[root@monitor prometheus-2.52.0.linux-amd64]#
[root@monitor prometheus-2.52.0.linux-amd64]# promtool --version
promtool, version 2.52.0 (branch: HEAD, revision: 879d80922a227c37df502e7315fad8ceb10a986d)
  build user:       root@1b4f4c206e41
  build date:       20240508-21:56:43
  go version:       go1.22.3
  platform:         linux/amd64
  tags:             netgo,builtinassets,stringlabels
```

## 生成配置文件

压缩包里自带一个prometheus.yml文件，我们可以根据这个文件来生成自己的配置文件

```bash
[root@monitor prometheus-2.52.0.linux-amd64]# mkdir /etc/prometheus
[root@monitor prometheus-2.52.0.linux-amd64]# cp prometheus.yml /etc/prometheus/
[root@monitor prometheus-2.52.0.linux-amd64]# cd
[root@monitor ~]#
```

```bash
cat > /etc/prometheus/prometheus.yml <<-'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  query_log_file: /var/log/prometheus-query.log
alerting:
  alertmanagers:
    - static_configs:
        - targets:
rule_files:
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
  - job_name: "node"
    static_configs:
      - targets: ["192.168.8.20:9100"]
EOF
```

## 启用账号密码认证

默认情况下，匿名都可以访问web页面，现在启用密码认证

```bash
[root@monitor ~]# yum install mkpasswd -y
[root@monitor ~]# echo -n "password" | mkpasswd -m bcrypt -s
$2b$05$BTeh41YLEbT/aQofHfAs9uM3EXzh7CiSWEipSRHBDmZ.YqZ9sW99u
```

```bash
cat > /etc/prometheus/auth.yml <<-'EOF'
basic_auth_users:
  admin: $2b$05$BTeh41YLEbT/aQofHfAs9uM3EXzh7CiSWEipSRHBDmZ.YqZ9sW99u
EOF
```

## 启动服务

```bash
cat > /etc/systemd/system/prometheus.service <<-'EOF'
[Unit]
Description=Prometheus
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --web.config.file=/etc/prometheus/auth.yml

[Install]
WantedBy=multi-user.target
EOF
```

```bash
systemctl daemon-reload
systemctl enable prometheus --now
```

## 开通防火墙

```bash
firewall-cmd --add-port=9090/tcp --permanent
firewall-cmd --reload
```

## 启用日志轮转

防止Prometheus查询撑爆硬盘

```bash
cat > /etc/logrotate.d/prometheus <<-'EOF'
/prometheus/query.log {
    daily
    rotate 7
    dateext
    compress
    delaycompress
    postrotate
        killall -HUP prometheus
    endscript
}
```

```bash
systemctl enable crond --now
```

## 验证服务正常

你可以打开浏览器访问http://192.168.8.10:9090/metrics或用下面的方法提供账号密码验证

```bash
[root@monitor ~]# curl -s -u admin:password http://localhost:9090/metrics | more
# HELP go_gc_duration_seconds A summary of the pause duration of garbage collection cycles.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 4.3764e-05
go_gc_duration_seconds{quantile="0.25"} 7.3718e-05
go_gc_duration_seconds{quantile="0.5"} 0.000137124
```

# 被监控 Linux 节点

这里是被监控的节点

## 下载node_exporter

## 互相解析

```bash
cat > /etc/hosts <<-'EOF'
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.8.10 monitor
192.168.8.20 node
EOF
```

下载对应版本的软件包，并将二进制程序放进/usr/bin中

```bash
[root@node ~]# wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz

[root@node ~]# tar xf node_exporter-1.8.1.linux-amd64.tar.gz

[root@node ~]# cd node_exporter-1.8.1.linux-amd64/

[root@node node_exporter-1.8.1.linux-amd64]# cp node_exporter /usr/bin/

[root@node node_exporter-1.8.1.linux-amd64]# node_exporter --version
node_exporter, version 1.8.1 (branch: HEAD, revision: 400c3979931613db930ea035f39ce7b377cdbb5b)
  build user:       root@7afbff271a3f
  build date:       20240521-18:36:22
  go version:       go1.22.3
  platform:         linux/amd64
  tags:             unknown
[root@node node_exporter-1.8.1.linux-amd64]# cd
[root@node ~]#
```

## 启动服务

Node Exporter通常不需要额外的配置，默认配置已经足够

```bash
cat > /etc/systemd/system/node_exporter.service <<-'EOF'
[Unit]
Description=Node Exporter
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF
```

```bash
systemctl daemon-reload
systemctl enable node_exporter --now
```

## 开通防火墙

```bash
firewall-cmd --add-port=9100/tcp --permanent
firewall-cmd --reload
```

# Grafana 安装

## 准备软件仓库

```bash
wget -q -O gpg.key https://rpm.grafana.com/gpg.key
rpm --import gpg.key

cat > /etc/yum.repos.d/grafana.repo <<-'EOF'
[grafana]
name=grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF
```

## 安装Grafana

```bash
dnf install grafana -y
```

## 启动服务

```bash
systemctl daemon-reload
systemctl enable grafana-server --now
```

## 开通防火墙

```bash
firewall-cmd --add-port=3000/tcp --permanent
firewall-cmd --reload
```

## 测试功能正常

http://192.168.8.10:3000/login

