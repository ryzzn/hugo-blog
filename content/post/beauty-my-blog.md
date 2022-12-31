---
title: Hexo+Next博客美化
date: 2020-08-09 01:07:42
tags:
- hexo
- next
- blog
---

> 前几天想起了自己折腾了很久的org自动生成的网站，突然对next默认的配色不太满意，参考了原先的色系，对hexo-next的主题进行了重新设计。

<!-- more -->

![原先的sydi.org网站截图](https://img.ryzn.me/images/1597038447165.png!webp)

最近在整理博客，看到了原来自己写的网站，感觉配色比Next自带的主题舒服一些。所以就想美化下这个Hexo+Next搭建的博客。主要包含两个部分，一个是功能上的增强（增加了[近期文章的功能](add-recent-posts-sidebar)），另一个则是配色上做了一些调整。

目前来看的界面更符合我的审美一些。

![美化过的网站截图](https://img.ryzn.me/images/1597038697889.png!webp)

![美化前的网站截图](https://img.ryzn.me/images/1597038852984.png!webp)

当然审美方式大家都各有所好，这里只是对自己网站的修改做一下记录，一来方便自己后续查阅和回顾，二来方便他们拿来做参考。

```yaml
### _config.yml
# 使用next主题
theme: next
```

```yaml
### source/_data/next.yml
## 一些关键配置
# 新增styl文件，最终会编译成css代码
custom_file_path:
  style: source/_data/styles.styl

# 版权相关
creative_commons:
  license: by-nc-sa
  sidebar: true
  post: true
  language: zh-CN

# next的子主题
scheme: Gemini

# 不要“阅读更多”的按钮
read_more_btn: false
```

```stylus
body
  background: #e5e6d0 url(/images/bg.jpg) repeat 0 0
  font-size: 0.96em
  line-height: 1.78


.site-brand-container
  background: #172A3A

.site-nav
  font-size: 110%

.sidebar
  font-size: 105%

.header-inner
  border-radius: 0 0 8px 8px

.sidebar-inner
  border-radius: 8px

.post-block + .post-block
  border-radius: 8px

.post-block
  border-radius: 0 0 8px 8px

h1.post-title
    background: coral
    background-image: -webkit-linear-gradient(top, coral, coral)
    -webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25), inset 0 -1px 0 rgba(0, 0, 0, 0.1)
    box-shadow: 0px 1px 3px rgba(0, 0, 0, .05), 0 -1px 0 rgba(255,255,255, .6) inset
    /* position: fixed */
    width: 100%
    z-index: 1000
    border-radius: 16px
    /* height: 50px */
    /* cursor: pointer */
    /* margin-top: 10px */
    padding: 8px 0

.posts-expand .post-meta
  margin-bottom: 30px

.post-button
  margin-top: 0

:root
  --content-bg-color: #fafaf3
  --link-color: #A34D32
  --link-hover-color: cadetblue
  --btn-default-bg: #fafaf3
  --btn-default-color: #A34D32
  --btn-default-hover-bg: #CFCF8C
  --btn-default-hover-color: #508991

.btn
  border: 0

// 近期文章
.links-of-recent-posts
  font-size: 0.8125em
  margin-top: 10px

.links-of-recent-posts-title
  font-size: 1.03em
  font-weight: 600
  margin-top: 0

.links-of-recent-posts-list
  list-style: none
  margin: 0
  padding: 0
```

完整的配置就不记录了，如果有人有兴趣的话可以给我留言。
