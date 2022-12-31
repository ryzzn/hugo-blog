---
title: typora-and-picgo
date: 2020-07-13 16:01:28
---

最近换了公司和方向，需要学习很多资料。所以打算整理一部分出来放到博客上。

Typora是用得最舒服的markdown编辑工具，但是它本身处理图片比较麻烦。以前是利用iPic进行上传的，不过它的订阅机制让我很不感冒，所以打算换掉。正好看到https://juejin.im/post/5e6b2341518825493e535e5f这篇文章，所以就顺手弄了一下。

我使用Typera+PicGo-core+阿里云Oss，这种功能用命令行工具更方便一些。

<!-- more -->

## 安装picgo

```shell
# 安装picgo
cnpm install picgo -g
# 配置picgo
picgo set uploader
```

![image-20200713162049562](https://img.ryzn.me/images/image-20200713162049562.png!webp)

使用键盘箭头就可以选择到aliyun了，按照提示设置就可以了。

完成以后使用以下命令选择aliyun

```shell
picgo use uploader
```

现在可以测试一下picgo是否可以工作了。

![image-20200713162430241](https://img.ryzn.me/images/image-20200713162430241.png!webp)

如果显示类似的结果，就是表示picgo配置成功了。

## 配置Tyora

接着配置Typora使用picgo-core，在typora配置中选在自定义命令：

![image-20200713162555585](https://img.ryzn.me/images/image-20200713162555585.png!webp)

测试了下需要显式指定node执行才可以，可以点下Test Uploader测试配置是否成功。

## 参考

https://juejin.im/post/5e6b2341518825493e535e5f

https://support.typora.io/Upload-Image/#option-2-config-via-cli
