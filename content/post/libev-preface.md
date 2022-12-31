---
title: libev序
tags:
  - libev
  - linux
abbrlink: 6af6004f
date: 2017-11-02 00:47:06
---

最近在做协程方面的工作，需要完成一个用户态调度的框架，主要逻辑一直在参考Linux2.6的调度器。需要用协程完成同步转异步的工作势必要封装一系列同步的接口，包括锁、各种同步原语、IO处理等等。同步的代码则是参考的NPTL的实现，但是IO部分在Linux下没有完全的异步接口，比如像Windows的IOCP一样。查了一堆资料，最终还是继续走epoll的逻辑。裸用epoll怕坑太多，于是找了一下封装了epoll的简单的网络框架。最终选择了libev有两个原因：一是原来项目中用了五年的网络框架底层也是libev，好歹了解一些，二则是libev功能相比libuv和libevent[更全一些](http://blog.csdn.net/lijinqi1987/article/details/71214974)。所以接下来我会写几篇libev相关的文章，剖析下这个高性能的网络框架，由于水平所限，不正之处还望指正。

另外根据slideshare上面看到的一个[测试结果](https://www.slideshare.net/sm9kr/iocp-vs-epoll-perfor)，IOCP和EPOLL的性能差别不大，cpu使用差别也不大，一般情况下不太需要考虑这个问题。或者很多时候考虑也没用。

libev的官网：http://software.schmorp.de/pkg/libev.html

libev的文档说明：http://cvs.schmorp.de/libev/ev.pod

libev下载地址：http://dist.schmorp.de/libev/

该系列基于libev-4.24版本

