# 基于ACME的自动化证书管理

```textile
作者：李晓辉

微信联系：lxh_chat

联系邮箱: 939958092@qq.com
```

# 什么是ACME

## 1.1 什么是ACME（Automated Certificate Management Environment）？

ACME（自动证书管理环境）是一个由IETF（互联网工程任务组）制定的协议，旨在简化和自动化HTTPS证书的获取、更新、吊销等过程。它通过定义标准的接口和协议，使得证书颁发机构（CA）能够与域名持有者的服务器进行交互，以验证其对域名的控制权，并为其颁发数字证书。

## 1.2 ACME的工作原理和其在证书管理中的重要性

ACME的工作原理基于挑战-应答机制，用于验证域名所有权。主要流程包括：

- **请求证书**：服务器向CA提交证书请求，指定要包含在证书中的域名。
- **验证域名所有权**：CA通过向服务器发送挑战（如创建特定文件、修改DNS记录等）来验证服务器是否有权管理域名。
- **颁发证书**：验证成功后，CA颁发证书，服务器下载并安装证书。
- **自动续签**：证书在接近到期时，服务器会自动更新证书，确保持续有效。

ACME的自动化特性使得证书管理过程更加高效、安全，降低了手动操作的错误风险，同时促进了Web安全的普及和推广。

# 准备工作

## 客户端的选择

准备一个ACME标准的客户端，以下是可选的客户端

> a. Cerbot
> 
> b. acme.sh

## 验证域名所有权的方法

确定验证域名所有权的方法常用的有以下办法

> 1. Web服务器的文件添加方法，这个需要服务器可被公网访问
> 
> 2. DNS条目验证方法，这个方法则<mark>不需要</mark>服务器可被公网访问

### 1. HTTP 验证方法

**工作原理**：

- **验证过程**：ACME 服务器会向你的 Web 服务器发送一个特定的 HTTP 请求，要求在你的网站根目录下放置一个临时文件或修改某个特定的 URL。
- **验证条件**：你的 Web 服务器必须能够公网访问，并且能够在指定的路径下放置或修改文件。
- **优点**：
  - **实时性**：验证过程通常较快，可以即时完成。
  - **简单性**：对于具备公网访问权限的服务器，配置和操作相对简单。
- **适用场景**：
  - 适合于可以公开访问的 Web 服务器，例如 Nginx、Apache 等。
  - 通常用于申请单个域名的证书或者少量域名的证书。

### 2. DNS 验证方法

**工作原理**：

- **验证过程**：ACME 服务器要求你在域名的 DNS 记录中添加一个特定的 TXT 记录，记录内容由 ACME 服务器指定。
- **验证条件**：不需要你的 Web 服务器可以被公网访问，只需要你能够登录到 DNS 服务商的控制面板，并且具备修改 DNS 记录的权限。
- **优点**：
  - **灵活性**：不受服务器访问性能的限制，适用于内部网络或无法公网访问的服务器。
  - **安全性**：不需要在服务器上暴露临时文件，减少了安全风险。
- **适用场景**：
  - 适合于不能公开访问的服务器环境，例如内部网络、CDN 后面、有访问限制的服务器等。
  - 特别适用于申请包含通配符的证书，因为通配符证书要求 DNS 验证。

## 添加DNS条目

如果你需要为哪些域名提供证书，就需要在DNS中，先把A记录添加好，我这里已经将需要申请证书的域名指向了我有公网IP的服务器

# 安装Certbot客户端

### Ubuntu系列

```bash
apt update
apt install certbot -y
```

## RHEL系列

```bash
yum install https://mirrors.nju.edu.cn/epel/epel-release-latest-9.noarch.rpm -y
yum install certbot -y
```

# 申请证书

## 基于公网HTTP服务器的申请

在这种情况下，服务器上<mark>已安装Web服务，并可被公网访问</mark>

<mark>这一步之前，已经完成域名到此服务器的解析</mark>

### 模拟测试

因为初期不熟悉的时候，频繁发起证书申请，会导致超过服务器可接收的频率，导致你无法申请证书，先模拟一下

下方的<mark>--dry-run是模拟测试</mark>，并不会真的去申请证书，所有流程都通了之后，去掉这个参数发起真的证书申请

```bash
certbot certonly --webroot -w /var/www/html/ -d mail.credclouds.com -d autodiscover.credclouds.com --dry-run
```

注意回答下方的问题，我在这里输入了我的邮箱，用于接收续签和安全通知

```textile
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Enter email address (used for urgent renewal and security notices)
 (Enter 'c' to cancel): 939958092@qq.com
```

输入<mark>Y</mark>同意协议

```textile
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.4-April-3-2024.pdf. You must agree in
order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
```

下面还有一个问你是不是接收行业新闻的提示，自行选择

```textile
Would you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: n
```

看上去这次的模拟是非常成功的

```textile
Simulating a certificate request for mail.credclouds.com and autodiscover.credclouds.com
The dry run was successful.
```

### 正式申请证书

去掉<mark>--dry-run</mark>发起证书申请

```bash
certbot certonly --webroot -w /var/www/html/ -d mail.credclouds.com -d autodiscover.credclouds.com
```

从下面来看，已成功申请到证书，并把证书存放于<mark>/etc/letsencrypt/live</mark>

```textile
Account registered.
Requesting a certificate for mail.credclouds.com and autodiscover.credclouds.com

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/mail.credclouds.com/privkey.pem
This certificate expires on 2024-10-20.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

### 验证证书

```bash
certbot certificates
```

```textfile
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Found the following certs:
  Certificate Name: mail.credclouds.com
    Serial Number: 441952ff27f513f73e9f29d8766d9978b22
    Key Type: ECDSA
    Domains: mail.credclouds.com autodiscover.credclouds.com
    Expiry Date: 2024-10-20 00:38:05+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/mail.credclouds.com/privkey.pem
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

或者用openssl命令验证

```bash
openssl x509 -in /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem -text | grep -A 4 Validity
```

在输出中，可以看到有效期和所验证的域名都符合预期

```textfile
        Validity
            Not Before: Jul 22 00:38:06 2024 GMT
            Not After : Oct 20 00:38:05 2024 GMT
        Subject: CN = mail.credclouds.com
        Subject Public Key Info:
```

```bash
openssl x509 -in /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem -text | grep -A 4 Alternative
```

```textfile
            X509v3 Subject Alternative Name: 
                DNS:autodiscover.credclouds.com, DNS:mail.credclouds.com
            X509v3 Certificate Policies: 
                Policy: 2.23.140.1.2.1
            CT Precertificate SCTs: 
```

## 基于DNS条目的证书申请

基于 DNS 条目的证书申请是一种通过在域名的 DNS 记录中<mark>添加特定的 TXT 记录</mark>来验证域名所有权的方法。这种方法适用于<mark>无法公网访问或希望增强安全性</mark>的服务器环境，特别是<mark>申请通配符证书时常用</mark>的一种方式。

### 安装DNS插件

 安装相应的certbot的DNS插件，可以自动化的在你的DNS服务器汇总添加特定的TXT记录，而无需你自己动手

我的DNS托管在cloudflare，所以用下面的命令安装，如果你的是在别的地方注册的DNS，需要自己查找具体的插件或手工添加TXT

#### Ubuntu系列

```bash
apt update
apt install python3-certbot-dns-cloudflare -y
```

#### RHEL系列

```bash
yum install https://mirrors.nju.edu.cn/epel/epel-release-latest-9.noarch.rpm -y
yum install python3-certbot-dns-cloudflare.noarch -y
```

### 获取 Cloudflare API 密钥

在以下页面中，可以查看API密钥，并妥善保管

```textile
https://dash.cloudflare.com/profile/api-tokens
```

在API密钥处，点击<mark>global api key</mark>，并点击查看，输入密码后，复制密钥

**生成DNS API令牌文件**

```bash
cat > /etc/letsencrypt/cloudflare.ini <<-'EOF'
dns_cloudflare_email = 939958092@qq.com
dns_cloudflare_api_key = XXXXXXXXXXXXX
EOF

chmod 400 /etc/letsencrypt/cloudflare.ini
```

### 证书申请

#### 模拟测试

给<mark>lixiaohui.credclouds.com</mark>和<mark>lxh.credclouds.com</mark>申请域名

```bash
certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini \
-d 'lixiaohui.credclouds.com' -d 'lxh.credclouds.com' \
--dns-cloudflare-propagation-seconds 60 --dry-run
```

输出中，看上去已可以成功申请证书

这里需要注意的是，由于DNS验证并不那么实时，你可以<mark>加大命令中的60秒等待时间</mark>或多次尝试

```textile
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Simulating a certificate request for lixiaohui.credclouds.com and lxh.credclouds.com
Waiting 60 seconds for DNS changes to propagate
The dry run was successful.
```

#### 正式申请证书

<mark>去掉--dry-run</mark>

```bash
certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini \
-d 'lixiaohui.credclouds.com' -d 'lxh.credclouds.com' \
--dns-cloudflare-propagation-seconds 60
```

输出中，看上去已可以成功申请证书

这里需要注意的是，由于DNS验证并不那么实时，你可以<mark>加大命令中的60秒等待时间</mark>或多次尝试

```textile
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Requesting a certificate for lixiaohui.credclouds.com and lxh.credclouds.com
Waiting 60 seconds for DNS changes to propagate

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/lixiaohui.credclouds.com/privkey.pem
This certificate expires on 2024-10-20.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

#### 验证证书

```bash
certbot certificates
```

```textfile
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Found the following certs:
  Certificate Name: lixiaohui.credclouds.com
    Serial Number: 325601268a6280a838f61058c83b5106690
    Key Type: ECDSA
    Domains: lixiaohui.credclouds.com lxh.credclouds.com
    Expiry Date: 2024-10-20 01:58:37+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/lixiaohui.credclouds.com/privkey.pem
  Certificate Name: mail.credclouds.com
    Serial Number: 441952ff27f513f73e9f29d8766d9978b22
    Key Type: ECDSA
    Domains: mail.credclouds.com autodiscover.credclouds.com
    Expiry Date: 2024-10-20 00:38:05+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/mail.credclouds.com/privkey.pem
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

或者用openssl命令验证

```bash
openssl x509 -in /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem -text | grep -A 4 Validity
```

在输出中，可以看到有效期和所验证的域名都符合预期

```textfile
        Validity
            Not Before: Jul 22 01:58:38 2024 GMT
            Not After : Oct 20 01:58:37 2024 GMT
        Subject: CN = lixiaohui.credclouds.com
        Subject Public Key Info:
```

```bash
openssl x509 -in /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem -text | grep -A 4 Alternative
```

```textfile
            X509v3 Subject Alternative Name: 
                DNS:lixiaohui.credclouds.com, DNS:lxh.credclouds.com
            X509v3 Certificate Policies: 
                Policy: 2.23.140.1.2.1
            CT Precertificate SCTs: 
```

# 自动续签证书

Certbot工具本身提供了续签的方式，我们可以做一个计划任务，让它每天执行证书到期时间的检查和续签

在Linux中，添加一个计划任务用于自动续签，我添加了一个在早上九点自动执行续签的计划任务

```bash
crontab -e
```

```textile
0 9 * * * certbot renew --quiet
```

等待定时任务生效后，Certbot 将在需要时自动检查证书的到期情况，并在证书接近到期时进行续签操作。如果续签成功，新的证书文件将会更新到 `/etc/letsencrypt/live/lixiaohui.credclouds.com/` 目录中，当然，最后的这个目录名字取决于你的证书名字

当然，这个续签要快到期的时候才行，所以你直接续签不会有效果，你可以手工执行以下续签命令查看详细情况

```bash
certbot renew
```

```textile
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/lixiaohui.credclouds.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Certificate not yet due for renewal

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/mail.credclouds.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Certificate not yet due for renewal

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
The following certificates are not due for renewal yet:
  /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem expires on 2024-10-20 (skipped)
  /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem expires on 2024-10-20 (skipped)
No renewals were attempted.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

就像刚才说的，没有到期，会跳过续签，为了看到效果，我们可以强制续签一次

```bash
certbot renew --force-renewal
```

从下面的输出来看，证书已成功续签

```textile
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/lixiaohui.credclouds.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewing an existing certificate for lixiaohui.credclouds.com and lxh.credclouds.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/mail.credclouds.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewing an existing certificate for mail.credclouds.com and autodiscover.credclouds.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations, all renewals succeeded: 
  /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem (success)
  /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem (success)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

重新看看证书有效期情况

```bash
certbot certificates
```

从下面的内容和上面证书申请时验证的时间来看，的确续签成功

```textile
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Found the following certs:
  Certificate Name: lixiaohui.credclouds.com
    Serial Number: 492728985241af7f467fbccc180ab41c1c9
    Key Type: ECDSA
    Domains: lixiaohui.credclouds.com lxh.credclouds.com
    Expiry Date: 2024-10-20 02:32:22+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/lixiaohui.credclouds.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/lixiaohui.credclouds.com/privkey.pem
  Certificate Name: mail.credclouds.com
    Serial Number: 49f218915c0127e3667cdb7ca4c6e24d0aa
    Key Type: ECDSA
    Domains: mail.credclouds.com autodiscover.credclouds.com
    Expiry Date: 2024-10-20 02:32:26+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/mail.credclouds.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/mail.credclouds.com/privkey.pem
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```
