---
title: 给hexo的next主题添加备案号
date: 2021-12-30 23:35:18
tags: [hexo, next, icp, 备案]
---



最近几天接到了多个阿里云的电话，让我对博客进行备案，否则将会被关停。



心想着虽然也不怎么更新，被关了总是一个牵挂，就趁着这几天弄了一下。还好阿里云提供了免费备案申请，两三个小时就申请备案号下来了。

![image-20211230234125799](https://img.ryzn.me/images/1640878887055.png!webp)



根据[这里](https://www.crane0.com/2021/10/29/%E6%B7%BB%E5%8A%A0%E5%A4%87%E6%A1%88%E5%8F%B7/)的步骤给主题加上了备案号，不过实际上操作会略有出入，可能是版本不同。我的配置文件在博客根目录的`_condfig.next.yml`文件中。修改成以下配置：

```yaml
footer:
  # Beian ICP and gongan information for Chinese users. See: https://beian.miit.gov.cn, http://www.beian.gov.cn
  beian:
    enable: true
    icp: 浙ICP备15002642号-1
    # The digit in the num of gongan beian.
    gongan_id:
    # The full num of gongan beian.
    gongan_num:
    # The icon for gongan beian. See: http://www.beian.gov.cn/portal/download
    gongan_icon_url:
```

