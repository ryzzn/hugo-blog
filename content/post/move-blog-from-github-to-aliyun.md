---
title: 迁移博客 - 从GitHub到阿里云
date: 2020-08-09 00:28:39
tags: 
- blog
- aliyun
- github
- hexo
---

> 在GitHub上感觉被人监控，访问博客时好时坏，终于忍不住放弃了GitHub的Pages服务，回到老大哥阿里云的怀抱。此文是对本次迁移的过程做的记录。

<!-- more -->

# 背景

说一下这个博客搭建的背景：希望重新开始养成记录的习惯。

原来在学校的时候就折腾过好几个博客（或者网站），比如muse wiki、wordpress、org website，再到现在的这个基于hexo的静态博客网站。可以参考17年10月建站的时候写的[那片文章](beginning)。

原来这个网站是挂在coding.net上的，因为本来就在上面保存了一些信息，正好发现它可以做静态网站的托管。后来coding.net被腾讯收购，重新在新的腾讯云上折腾了很久，当时不太稳定，就搬到到了github上。GitHub能够很方便的解决https问题，这个是非常好的功能。可惜的是，最近一个多月GitHub频频出问题，消磨掉了我继续使用它的决心，虽然是一个小站点，偶尔不能访问或者访问速度巨慢也是不能接受的。于是乎想到了几年前的阿里云OSS，作为国内云厂商的老大哥，托给它我比较放心，按量付费也花不了几个钱。于是，花了一个下午从GitHub迁到了OSS上。顺便提一下，迁的那天正好发布了一篇随笔push到了GitHub，被公司安全扫描到泄露了公司内部的项目地址，一定要我把那篇文章删了，更加觉得了我放弃GitHub的决心，实时被人监控不是一个好兆头。

这次迁移涉及到的内容：

- hexo自动发布到OSS
- 阿里云OSS配置
- 阿里云CDN配置
- hexo备份文章到私有GitHub库（感谢微软提供的免费私有库）

# hexo自动发布到OSS

安装插件：

```shell
npm install hexo-deployer-ali-oss --save
```

修改`_config.yml`文件：

```yaml
deploy:
  type: ali-oss
  region: oss-cn-hangzhou
  accessKeyId: xxxxxxxxxxxxxxxxxxxx
  accessKeySecret: xxxxxxxxxxxxxxxxxxxxxxxxxxx
  bucket: ryzn-me
```

后续执行`hexo deploy`的时候就会自动同步到这个OSS bucket里面了。

# 阿里云OSS配置

https://oss.console.aliyun.com/

# 阿里云CDN配置

https://cdn.console.aliyun.com/overview

# hexo备份文章到私有GitHub库

```shell
npm install --save hexo-git-backup
```

修改`_config.yml`文件：

```yaml
backup:
  type: git
  theme: next
  message: Backup ryzn.me sources
  repository:
    github: git@github.com:ryzzn/backmyblog.git,backup
```

后续执行`hexo backup`就能保存将网站保存到GitHub私有仓库了。

# 参考文章

- https://github.com/lmk123/blog/issues/55 讨论了几个好用的静态网站托管服务

- https://www.imczw.com/post/tech/hexo-on-oss-all.html 本文的内容很多都参考了这里
