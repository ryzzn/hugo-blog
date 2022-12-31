---
title: 让Diigo用起来舒服点
tags:
- 工具
- Diigo
- Liner
- 网页标注
- chrome
- 广告
date: 2019-01-20 21:22:17
---

最近被安利到了[Diigo](https://diigo.com/)，一个可以随时在网页上标注的工具。虽然读书的时候也不会用马克笔做标记，但是现在每天在电脑上查各种资料，有一个方便的记录工具是非常重要的。可能大家会有这样的经历，经常需要重复的搜索同一个问题的解决方案，或者明明以前读到过一篇文章现在怎么找都找不到。那么就可以尝试下使用Diigo工具给网页做标注，重点一目了然。当然我这几天也尝试过其它类似的工具，比如[Liner](https://getliner.com/)，最终觉得还是Diigo比较稳定可靠（没有进行详细的对比）。

使用Diigo的时候遇到一个问题，广告太多，一年59刀的价格有点犹豫。所以想办法做了一些去广告的操作，便于使用。等后续如果Diigo能给我强烈的归属感的话，再升级支持。

去广告主要用两个工具：Adblock Plus和`Stylish`（实际后者一个也够了，去广告习惯优先用ADP）

### ADP

订阅easylist以后，实际广告就不再显示了，但是还有两个问题：

1. 广告边上的RemoveMe标记还在显示，影响阅读。
2. 显示广告的区域被空白占着，这明显不是我们去广告的目的。

第一个问题，使用ADP的`Block Element`可以解决。第二个问题则需要`Stylish`出马。

```basic
diigo.com###headerADInner
diigo.com##iframe[src="https://www.google.com/afs/ads*"]
diigo.com###footerADInner
```

### Stylish

通过观察网页变化，可以发现Diigo实际通过给相应标签增加`headerGg`和`footerGg`预留了广告区域的位置。通过删除这两个类标记以后广告区域就被消除了。可是后续点击网页又会触发创建这两个标记，所以干脆留着标记直接改这两个标记的*css*内容绕过去。

对应内容：

```css
.library.headerGg .siteActionBarContainer {
    padding-bottom: 0;
}
.library.footerGg .siteActionBarContainer {
    padding-bottom: 0;
}
```

