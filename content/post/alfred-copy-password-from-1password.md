---
title: 使用alfred输入1password的密码
date: 2020-07-23 13:43:54
updated: 2020-07-26 14:59:48
tags: [alfred, macos, tool, 1password, applescript]
---

一直在用`1password`管理密码，最近把公司的SSO密码也放在了它上面，每次手动输入密码是不可能的，所以想结合`alfred`输入密码效率更高一些，不用每次打开`1password`界面操作了。

<!-- more -->

看了`alfred`默认和`1password`结合的方式是快速打开一个网页并填充好密码，这对我而言是不够的，因为很多时候我需要在终端输入密码。参考 https://www.alfredforum.com/topic/9083-how-to-copy-a-password-from-1password/ 这里改了一个workflow适配自己，AS代码如下：

```appscript
tell application "System Events"
	set frontmostApplicationName to name of 1st process whose frontmost is true
	open location "onepassword://extension/search/{query}"
	set frontmost of process "1Password 7" to true
	key code 48
	key code 126
	key code 48
	key code 48
	key code 125
	key code 36
	set frontmost of process frontmostApplicationName to true
end tell

delay 0.3
tell application "System Events" to key code 9 using command down
```

![image-20200723134905104](https://img.ryzn.me/images/image-20200723134905104.png!webp)

效果就是在需要输入密码的地方启动`alfred`，然后输入p+关键字，就会自动将密码黏贴好。目前已经满足了我正常使用的需求，后面看有必要的话看是否需要增加**解锁检测**的功能。
