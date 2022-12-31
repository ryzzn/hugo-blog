---
title: 为Hexo Next添加近期文章功能
date: 2020-08-09 01:12:42
updated: 2020-08-10 13:25
tags: 
- hexo
- next
- sidebar
- blog
- 博客优化
---

> 特别喜欢原来自己网站的**最近文章**功能，之前也花了很多精力设计。最近文章可以很方便的看到本博客最近更新了哪些内容，可惜Hexo的Next主题并没有这个功能，那我就把它加上来。网上的参考文章都是针对较老版本的Swig文件，而现在Hexo已经迁移到了NJK模板上，所以这个修改花了我个把小时才完成。

<!-- more -->

# 方案

新建`source/_data/sidebar.njk`文件，内容如下：

```html
{# RecentPosts #}
{%- if theme.recent_posts %}
  <div class="links-of-recent-posts motion-element">
    <div class="links-of-recent-posts-title">
      {%- if theme.recent_posts.icon %}
      <i class="{{ theme.recent_posts.icon }} fa-fw"></i>
      {%- endif %}
      {{ theme.recent_posts.title }}
    </div>
    <ul class="links-of-recent-posts-list">
      {%- set posts = site.posts.sort('date', 'desc').toArray() %}
      {%- for post in posts.slice('0', theme.recent_posts.max_count) %}
        <li class="links-of-recent-posts-item">
          {{ next_url(post.path, post.title, {title: post.path}) }}
        </li>
      {%- endfor %}
    </ul>
  </div>
{%- endif %}
```

修改`source/_data/next.yaml`，打开custom_file_path中的sidebar和style两个内容，并新增recent_posts内容。

```yaml
# Define custom file paths.
# Create your custom files in site directory `source/_data` and uncomment needed files below.
custom_file_path:
  #head: source/_data/head.njk
  #header: source/_data/header.njk
  sidebar: source/_data/sidebar.njk
  #postMeta: source/_data/post-meta.njk
  #postBodyEnd: source/_data/post-body-end.njk
  #footer: source/_data/footer.njk
  #bodyEnd: source/_data/body-end.njk
  #variable: source/_data/variables.styl
  #mixin: source/_data/mixins.styl
  style: source/_data/styles.styl


recent_posts:
# 块标题
  title: 最近文章
# 图标
  icon: fa fa-history
# 最多多少文章链接
  max_count: 18
```

剩下的，需要修改styl文件，美化界面。新增`source/_data/styles.styl`文件：

```stylus
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



P.S. 以上内容可以根据个人需要进行调整。
