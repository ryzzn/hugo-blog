---
title: FlexGet与Transmission结合
tags:
  - NAS
  - 折腾
abbrlink: a2bb8fd
date: 2018-03-31 01:26:02
---

前段时间把我群晖的PT客户端从**Download Station**改成了**Transmission**，感觉瞬间轻松了很多（可能是假象）。**Download Station**会在执行一些操作的时候卡个一两分钟，**RSS订阅**的功能还会经常失效。转到**Transmission**以后，由于它支持本地客户端通过RPC接口连接到服务器上，使用起来和本地用迅雷的感觉差不多，很舒服。虽然如此，它有一个不太友好的地方是，它不支持**RSS订阅**功能。所以现在我每次都是下载种子文件以后再打开种子进行下载的，这在大多数情况下也够用了，可当在手机上看到好的资源要下载的时候就比较麻烦了。

所以我就上网搜了一下，发现有一个神器：**FlexGet**。它就是专门用来做**RSS订阅**这个功能的。可惜DSM6中没有这个软件的安装包，需要自己在命令行中安装。参考了[这篇文章](http://www.gebi1.com/thread-264073-1-1.html)，也没想象中的那么复杂，主要分这几步：

1. 安装python3，和pip模块
2. 用pip安装flexget和transmissionrpc模块
3. 配置flexget
4. 配置crontab定时运行flexget

至此，**RSS订阅**功能又回归了。
