---
title: 备份sydi.org网站文档
tags:
  - 杂事
  - 回忆
abbrlink: cadef949
date: 2019-01-02 00:29:09
---

原来的那个[博客网站](http://sydi.org)是自己用emacs基于org-mode一步一步搭建起来的，并把它部署在Linode上面。现在Linode已经不再使用了：VPN用了成品，网站部署用了pages成品。年纪大了就什么都不想折腾。

今天重新把它搬了上来，放在coding.net的一个项目上。

原先是打算把网站上的org文档转化为md文档，但是折腾了下发现从一种“高级标记式语言”（org）往“低级标记式语言”（markdown）是一件非常痛苦的事情。尝试了ox-gfm，发现它更多的是转化成了html，并还有很多不兼容。遂，决定原样搬了上来，不放在 https://ryzn.me 上了。
