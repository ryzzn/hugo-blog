---
title: 域名解析cname和mx冲突
tags:
  - 域名
  - 博客
  - 解决方案
date: 2019-01-03 23:13:09
---

最近折腾这个站点，想到原来的http://sydi.org网站内容都丢了有点可惜。所以打算搞个`git pages`把网站再搞起来。问题来了，突然原来cname和mx是无法在一个解析项中共存的。这个问题以前并没有遇到，因为sydi的网站我是使用独立IP使用A规则指定的。难道我只能把我的网站地址从 http://sydi.org 变成 http://www.sydi.org 了么？

想了一下，决定把cname目标的IP自己解析出来，然后再人肉的通过A的方式加上去。结果可行。

动机参考这篇文章 {% post_link backup_sydi_org %}

不能共存的RFC解释：**RFC 1034**

> If a CNAME RR is present at a node, no other data should be present; this ensures that the data for a canonical name and its aliases cannot be different.

参考文章：http://krzer.com/2016/11/21/Something-about-cname-and-mx-conflicts/
