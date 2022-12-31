---
title: Hexo集成TW5
date: 2020-11-13 21:37:18
tags:
- blog
- hexo
- TW5
- TiddlyWiki
---

> TiddlyWiki作为一个非常好的知识管理软件，整套系统完全可以用一个html文件来描述。知识需要共享，所以这两天心血来潮研究了一下怎么集成到我的Hexo博客中。顺带升级了一下Hexo+Next，谁知道后者的坑更加多。

<!-- more -->

# 前言

前几个月舍弃了心仪很久的[TheBrain](https://www.thebrain.com/)，又用不惯[Notion](https://www.notion.so/)、[RoamResearch](https://roamresearch.com/)这种在线网页式的，于是就折腾起了[TiddlyWiki](https://tiddlywiki.com/)（后面简称TW5）。TW5是一个设计非常精巧的【非线性个人网络笔记本】，*非线性*的含义是它像文件夹那样的组织关系，*个人*是指它很适合一个人使用，*网络*是指它可以只由一个HTML文件组成，*笔记本*是指它是用来记笔记的。一句话说明它的特点：麻雀虽小五脏俱全。我在它身上也投入了不小的精力：

![TW5更新历史](https://img.ryzn.me/images/1605279569225.png!webp)

# 集成

知识必须记录，更需要分享。所以我曾经研究过怎么把TW5中的笔记[导出为静态网络进行分享](https://ryzn.me/wiki/ExportTW.html)：

![image-20201113215623490](https://img.ryzn.me/images/1605279576989.png!webp)

过程其实还很复杂的，网上的资料也很少。好歹是成功了，并且可以自定义CSS和JS。

因为我有自己的博客 https://ryzn.me ，所以并不想再建一个静态网站存放这些html/css/js文件。我开始了TW5和Hexo整合的尝试。

## 第一步：利用hexo的机制发布到博客服务器上

我在我的`hexo/source/`目录新建了一个wiki目录，软链接到TW5生成的静态网页目录，然后利用`hexo generate`功能将wiki文件随博客文章发布到博客服务器上。需要额外配置Hexo让它不要渲染这个wiki目录，否则会有报错。

这样，我可以使用`hexo server`查看静态wiki页面，也可以使用`hexo deploy`把本地的文件发布到博客服务器上。

并且我在我的博客侧边栏新增了wiki的入口，这样在我的博客上就很容易进入我的wiki了。

![image-20201113221001691](https://img.ryzn.me/images/1605279587423.png!webp)

不过这样TW5导出的静态网页风格和博客风格不一样，非常违和。所以有了第二次改造。

## 第二步：将TW5生成的CSS整合到hexo上

TW5生成静态网页的时候，可以将相应的CSS文件也一起生成，这样访问静态网页的时候就会有对应的CSS特效了。所以我开始在TW5中编写适合我博客风格的CSS特效，然后一起导出放到wiki文件中。做了一半就放弃了，在TW5里面写CSS调试起来太累人了，并且将博客的风格引入到TW5的内容里面并不是一种好的方式。所以我换了一个思路：**在TW5的静态html文件中引用博客css文件，在博客css文件中编写TW5的html文件样式。**

在TW5中主动引用博客css只需要修改它生成html文件的模板就可以了。博客css文件需要修改`hexo/source/_data/styles.styl`文件（我自己设置的路径）。这样博客的主题和wiki页面的主题就一致了。

虽然主题一致了，但是wiki页面的布局和博客还是有差别的，所以还需要统一wiki和博客的页面布局。

## 第三步：编写Hexo插件渲染TW5生成的文件

这里用【渲染】这个词是因为Hexo的这个插件机制叫做[**Renderer**](https://hexo.io/zh-cn/api/renderer)，中文就是渲染引擎。

利用这个机制，可以编写一个插件将TW5的中间html文件用Hexo的渲染进行渲染生成hexo风格的静态页面。整个流程如下：

1. TW5为每个wiki页面生成后缀为.tidhtml的文件，内容是html格式的wiki。
2. Hexo在进行渲染的时候，执行我们注册的渲染插件，逻辑是抽离其中的`<div .tc-tiddler-body>..</div>`内容。
3. Hexo会对渲染后的结果根据设置的Hexo Layout进行其它部分的装饰（加上侧边栏，底部等）。

这和渲染普通的Markdown文件是一个道理。

并且这样做了以后，在第二步中修改TW5模板引用博客css文件的修改也不需要做了，因为TW5生成的静态文件中`stylesheet`是用不到的，会直接使用Hexo框架中设置好的css。

Hexo渲染插件打包放在Github了：https://github.com/ryzzn/hexo-renderer-tiddly

# 升级

集成的过程完成以后，遇到了绕不过去的报错（和渲染TW5无关），尝试了各种办法无法解决，于是打算升级一下Hexo试试。升级Hexo的过程比较简单，不过升级完成以后发现遇到新的问题，于是接着升级我的Next主题。磕磕碰碰都解决了。因为我原来就使用的Hexo 4.2.0 + Next 8.0.0rc4，所以升级并不算困难。主要有两个问题比较费时间：

1. `hexo generate`报错：`Cannot read property 'replace' of null`，升级Next后解决。
2. Next新版动画太慢，自己绕过去了：https://github.com/next-theme/hexo-theme-next/issues/138

# 总结

前前后后花了一天的时间来折腾，勉强符合心理预期了。