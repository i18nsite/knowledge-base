---
title: "Authing配置单点登录、配置SSO登录"
description: "在Authing中配置单点登录教程"
date: "2024-05-10T10:00:00+08:00"
url: "https://docs.flashcat.cloud/zh/flashduty/authing-integration-guide"
---


快速了解
---
[Authing](https://www.authing.cn/)是一家提供身份识别和访问控制管理的供应商，通过Authing平台，可实现以OIDC、SAML2.0或CAS协议的方式登录FlashDuty管理控制台

## 准备工作
---
### 1. 登录或注册 Authing
- 如果是新注册用户，需先创建用户池，根据提示创建即可
### 2. 创建应用
- 选择标准 web 应用
- 填写应用名称
- 填写认证地址(SSO 登录时跳转的地址)

![image.png](https://img.github.io/rFaOo-DGswfKSPSbWGS-FebSKSdFDAaJo3_ZHWgK_wQ.avif)

### 3.记录相关信息

![image.png](https://img.github.io/fGGU2F0PnKeRglPMvHaQN3TN_CfapC7bCv3_Vy8BfOU.avif)

|字段|描述|
|---|---|
|App ID|对应 FlashDuty 的 Client ID|
|APP Secret|对应 FlashDuty 的 Client Secret|
|Issuer|对应 FlashDuty 的 Issuer|
|认证地址|通过 SSO 登录时跳转的地址|



## 开始配置 OIDC 协议
---
### 1. 打开 [FlashDuty](console.flashcat.cloud) 控制台并开启单点登录配置

![image.png](https://img.github.io/KZ0bU4AgfrxBFrbiDy_aMlMw0OAovw8d5iX6eDbvV4s.avif)

### 2.配置相关信息复制到对应的填写框中

#### 2.1 将 Authing 应用的相关信息复制到对应的填写框中
![image.png](https://img.github.io/EnWuL87KZb8WkGRFWWeCbuL71AKXlskG4mXl5pa5lIo.avif)

#### 2.2 将 Redirect UR L域名复制到 Authing 的登录回调 URL中

![image.png](https://img.github.io/AeIek4wYqa6GcRPqBYxP7FumgpZzgc1LD_x0ZqYbf6s.avif)

### 3.更改 Authing 配置

#### 3.1 按图配置，只需将 id_token 签名算法更改为 RS256 即可

![image.png](https://img.github.io/wcUYTZJtdrz7pJK07m203p9XGGmKdgmHGB1t5MGH8s0.avif)

#### 3.2 配置登录控制

![image.png](https://img.github.io/Q99TWiFqHE9MZVkQS7Bq3SO0hoOPIWpNBff8OvZtCxY.avif)

#### 3.3 更改权限

![image.png](https://img.github.io/xz9eG4P2Cx6LhdzB5gqUU0FHtO7wahe-nEhelpSCRW0.avif)

### 4.创建用户并测试登录

#### 4.1 在 Authing 中创建用户

:::tip
FlashDuty 只支持用户邮箱关联，所以需要用邮箱创建用户
:::


![image.png](https://img.github.io/wJC3EQjcBkksln8c1Yetxw-EqkMQpM7O-3nGITx7604.avif)

#### 4.2 使用 SSO 地址测试登录

![image.png](https://img.github.io/z9i-MqlbSY5iUstNJ8ApL8MPmY9otvMtB1aUxVMSSaY.avif)

:::tip
**可以访问 console.flashcat.cloud 通过 SSO 的方式登录**
:::

#### 4.3 SSO 地址跳转到登录页面

![image.png](https://img.github.io/te7WxbegivYwwq0vTcN4i_v8Z8eO5TctotvNNbMQhbE.avif)

:::tip
使用在 Authing 创建的用户，登录 FlashDuty 控制台
:::


## 开始配置 SAML2.0 协议
---

:::tip
可以新创建应用或者在已有的应用中修改，这里通过修改应用进行演示
:::

### 1.协议配置

#### 1.1 选择 SAML2.0

![image.png](https://img.github.io/FLJsSEpdqdy0U4HsEClrmG0ynti-TiKoxv7eyEsiNs4.avif)

#### 1.2 将 FlashDuty 的单点登录协议改成 SAML 协议，并复制 acs 地址

![image.png](https://img.github.io/QrzVo2DKOIUF4ueiMMN5d1-svypFEEiB774hYJ57SiI.avif)

#### 1.3 acs 地址复制到 authing 应用中后，点击保存并修改协议类型

![image.png](https://img.github.io/WEk3joVymAUwHiKpW8_6FEBoitqmF5TDKH_h4sCGIKw.avif)

### 2.在 FlashDuty 中配置

#### 2.1 下载 metadata 数据，点击链接并保存到本地

![image.png](https://img.github.io/heB07DtLDMuL9U9fpAKCl7VXrRrWY4uNNgDT_Xiwfj4.avif)

#### 2.2 上传到 FlashDuty 的单点登录配置中并保存

![image.png](https://img.github.io/5p4rgQ127lvqz9vVtvR1gNjjTys9uMmDvax0iJzn8BI.avif)

#### 2.3 测试登录（参考 OIDC 协议的登录）
![image.png](https://img.github.io/te7WxbegivYwwq0vTcN4i_v8Z8eO5TctotvNNbMQhbE.avif)

:::tip
以上是两种方式的全部配置方式，两个平台在配置时有穿插，所以请务必小心不要遗忘关键信息，如在配置过程中有任何问题，可以联系 FlashDuty 技术支持协助
:::


## 开始配置 CAS 协议
---
### 1. 打开 [FlashDuty](console.flashcat.cloud) 控制台并开启单点登录配置

![image.png](https://img.github.io/KZ0bU4AgfrxBFrbiDy_aMlMw0OAovw8d5iX6eDbvV4s.avif)

### 2.配置相关信息复制到对应的填写框中

#### 2.1 将 Authing 应用的相关信息复制到对应的填写框中
![image.png](https://img.github.io/_zRk5lRlLaIJ2pR5Gn3G_AJRG1l1a5Ge9zlaZXWdArQ.avif)

#### 2.2 将 Redirect URL 复制到 Authing 的登录回调URL 中

![image.png](https://img.github.io/y33ADY93aySH--oBiwzD_DzD6lRm8J_E-UkVrWXxliQ.avif)

### 3.更改 Authing 配置

#### 3.1 按图配置

![image.png](https://img.github.io/_e5BujT71dx4Lh5uiaNcvgIxEL493d5n2rZXWfnEB78.avif)

#### 3.2 配置登录控制

![image.png](https://img.github.io/Q99TWiFqHE9MZVkQS7Bq3SO0hoOPIWpNBff8OvZtCxY.avif)

#### 3.3 更改权限

![image.png](https://img.github.io/xz9eG4P2Cx6LhdzB5gqUU0FHtO7wahe-nEhelpSCRW0.avif)

### 4.创建用户并测试登录

#### 4.1 在 Authing 中创建用户

:::tip
FlashDuty 只支持用户邮箱关联，所以需要用邮箱创建用户
:::


![image.png](https://img.github.io/wJC3EQjcBkksln8c1Yetxw-EqkMQpM7O-3nGITx7604.avif)

#### 4.2 使用 SSO 地址测试登录

![image.png](https://img.github.io/dII3AxQNII7gMXCoB0qo_PNjiVrH1km-IBFJTjlGKxY.avif)


#### 4.3 SSO 地址跳转到登录页面

![image.png](https://img.github.io/te7WxbegivYwwq0vTcN4i_v8Z8eO5TctotvNNbMQhbE.avif)

:::tip
使用在 Authing 创建的用户，登录 FlashDuty 控制台
:::