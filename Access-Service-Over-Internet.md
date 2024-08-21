```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# 注册ngrok账号

```text
https://dashboard.ngrok.com/signup
```

# 创建一个稳定的域名

```text
https://dashboard.ngrok.com/cloud-edge/domains
```

# 确认自己的Authtoken

```text
https://dashboard.ngrok.com/cloud-edge/domains
```

# 下载安装ngrok

```text
https://ngrok.com/download
tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin
```

# 启动隧道

```text
https://dashboard.ngrok.com/get-started/setup/linux
```

根据隧道引导，添加Authtoken，并启动隧道

```bash
ngrok config add-authtoken xxxxx

# tcp 协议
ngrok tcp 22

# http 协议
ngrok http 80
```

这是我的隧道输出，注意不要按下ctrl c

```text
Session Status                online
Account                       xxxx (Plan: Free)
Version                       3.10.0
Region                        Japan (jp)
Web Interface                 http://127.0.0.1:4041
Forwarding                    tcp://0.tcp.jp.ngrok.io:13674 -> localhost:22

Connections                   ttl     opn     rt1     rt5     p50     p90
                              0       0       0.00    0.00    0.00    0.00
```

# 使用隧道

随便在哪里都可以

```bash
ssh USERNAME@0.tcp.jp.ngrok.io -p 13674
```

```text
The authenticity of host '[0.tcp.jp.ngrok.io]:13674 ([18.177.76.42]:13674)' can't be established.
ED25519 key fingerprint is SHA256:8DUOQ3DT9jCPdqwuBy4tctmWUlOFoZgkihufdYvWFOo.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:1: [0.tcp.jp.ngrok.io]:18148
Are you sure you want to continue connecting (yes/no/[fingerprint])? 'yes'
Warning: Permanently added '[0.tcp.jp.ngrok.io]:13674' (ED25519) to the list of known hosts.
root@0.tcp.jp.ngrok.io's password:
Last login: Sat Jun  1 21:31:57 2024 from ::1
[root@ceph ~]#
```