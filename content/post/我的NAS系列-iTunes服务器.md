---
title: 我的NAS系列 - iTunes服务器
date: 2020-05-20 16:02:06
---

原来用群晖的时候有一个很好的功能叫做`iTunes Server`，它可以将我再群晖里面的音乐文件以服务的形式提供出来，那在我的iTunes客户端上就可以查看和听歌了。

<!-- more -->

![iTunues示例](https://img.ryzn.me/images/2020-05-20-074942.jpg!webp)iTunues示例

那么换了FreeNAS以后，在它的管理页面上并没有看到相关的功能，简陋的插件也没找到与此相关的。怎么办呢？

谷歌搜索了一下，发现实际上它是搭建了一个[DAAP](https://en.wikipedia.org/wiki/Digital_Audio_Access_Protocol)协议的服务器完成的这个功能，所以只需要在我们的FreeNAS上搭建一个[DAAP](https://en.wikipedia.org/wiki/Digital_Audio_Access_Protocol)协议的服务就可以了。找了很多，发现在FreeBSD上用的比较多的是[forked-daapd](http://ejurgensen.github.io/forked-daapd/)。

实际上这个项目(forked-daapd)是我从[这篇文章](https://www.davd.io/posts-freebsd-itunes-media-server-using-forked-daapd/)中看到的，文章中提到了一个该项目自带一个安装脚本，可以在freebsd上自动安装。所以我的流程也就和他类似了。

整体流程如下：

1. 在freenas上创建一个jail
2. 配置jail，将网络、音乐磁盘、配置目录都挂载好
3. 到jail里面去下载forked-daapd自带的freebsd安装脚本
4. 调整脚本，使安装流程正确走通
5. 调整配置文件，并启动服务

### 创建jail

```
# 创建好jail，并设置好网络
iocage create -n "daap" -t base ip4_addr="vnet0|10.0.0.67/24" defaultrouter="10.0.0.2" vnet="on" allow_raw_sockets="1" boot="on" mount_procfs=1
```

### 将相关目录挂载好

一个配置目录，一个音乐目录

```
iocage fstab -a daap /mnt/tank1/ds1/l3/apps/forked-daapd /config nullfs rw 0 0
iocage fstab -a daap /mnt/tank1/ds1/l1/media/music /mnt/music nullfs rw 0 0
```

### 下载安装脚本

```
iocage console daap
# 下面的命令在daap jail中执行
fetch https://raw.githubusercontent.com/ejurgensen/forked-daapd/master/scripts/freebsd_install_11.0.sh
```

这里写着11.0版本，实际上我是11u3，基本都能使用。

### 修改安装脚本

上一步下载好的脚本是需要进行调整的，主要调整有：

1. 删除sudo指令（因为本身就在root账户，并且没有安装sudo）
2. 好像其它都不需要修改，我是一步一步调过来的。

建议先整体将这个脚本看一遍，它做每一步操作前都会询问是否需要执行该操作，我都是选的Y。如果脚本某一步成功了，那么后面步骤进行调试脚本的时候就可以通过回答N来跳过已经完成的步骤。具体看下这个shell脚本就可以了，难度不大，只要下载和编译都没问题就可以了。

### 调整配置文件

我是将forked-daapd的配置文件和数据库文件都放在外面的（jail外面），这样维护起来方便很多，即使jail销毁也没太大影响，数据和配置都在。

所以我调整了`/usr/local/etc/rc.d/forked-daapd`文件，将配置文件的检查路径从`/usr/local/etc/forked-daapd.conf`调整到了`/config/forked-daapd.conf`路径。然后将原路径的这个文件移动到新的位置（实际上老的路径的文件是上面那个安装脚本生成的，也可以那时候直接改好，这里就不需要移动文件了）。同时需要修改`/etc/rc.conf`文件，调整运行时使用的配置文件位置。增加这两句：

```
forked_daapd_enable="YES"
forked_daapd_flags="-c /config/forked-daapd.conf"
```

第一句是jail启动的时候开启服务，第二句是进程启动额外的参数，使它加载到我们指定位置的配置文件。

然后可以按需修改`/config/forked-daapd.conf`文件了，主要需要改的是目录相关的配置，比如音乐文件夹在哪里，podcasts文件夹在哪里，文件扫描忽略的目录，对外暴露的服务名称等等。文件中已经描述得很清楚了，过一遍就可以了。

### 调试服务，针对性修改

根据上面的步骤可以直接把服务拉起来可能没那么容易，比如我就因为配置文件中目录拼写错误导致服务无法正常启动。这时候就需要查看对应的日志文件排查了，路径是：`/usr/local/var/log/forked-daapd.log`。

调试都通过以后就可以在本地的iTunes客户端上看到这个服务器了。

![iTunes听服务器上的音乐](https://img.ryzn.me/images/2020-05-20-074953.jpg!webp)iTunes听服务器上的音乐
