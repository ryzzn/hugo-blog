---
title: 使用腾讯镜像加速emacs包管理
date: 2020-07-27 11:52:21
tags: 
- emacs
- prelude
- mirror
- elpa
- 腾讯
---

> 习惯真的是一件可怕的事情。

使用了几天的`vs code`以后，还是重新切到了emacs上面，不得不说的是微软和整个社区已经把`vs code`调教得很好用了，比如[remote develop](https://code.visualstudio.com/docs/remote/remote-overview)这种插件对于服务端开发人员来说就非常有吸引力。不过对于常年（十年以上）使用emacs的人而言切换的代价有点大，即使大多数编辑操作可以替换，但是一些个性化定制的功能还是摸不着头脑，耗费时间。所以我换回了emacs，并打算重新merge prelude上的更新。

一顿操作以后，发现下载安装emacs package的操作实在太慢（大约一个小时），心想各个平台都有自己的镜像，那么emacs里面是不是也会有呢？一搜一下的确有几个（[清华](https://mirrors.tuna.tsinghua.edu.cn/help/elpa/) [EmacsChina](http://elpa.emacs-china.org/)），最后决定用[腾讯](https://mirrors.cloud.tencent.com/help/elpa.html)的。

<!-- more -->

 我使用的是`prelude`管理emacs的配置文件，通过查看代码可以看到它是这样定义的：

```lisp
;; accessing a package repo over https on Windows is a no go, so we
;; fallback to http there
(if (eq system-type 'windows-nt)
    (add-to-list 'package-archives
                 '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t))

;; load the pinned packages
(let ((prelude-pinned-packages-file (expand-file-name "prelude-pinned-packages.el" prelude-dir)))
  (if (file-exists-p prelude-pinned-packages-file)
      (load prelude-pinned-packages-file)))

;; set package-user-dir to be relative to Prelude install path
(setq package-user-dir (expand-file-name "elpa" prelude-dir))
(package-initialize)		
```

可以看到有一个配置文件`prelude-pinned-packages.el`会在默认仓库以后进行执行，所以只需要加一个相应配置即可。

```lisp
;;; prelude-pinnned-packages.el --- Initialization file for Emacs
;;;

;;; Commentary:
;;

;;; Code:

(if (eq system-type 'windows-nt)
    (setq package-archives
          '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
            ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
  (setq package-archives
        '(("gnu"   . "https://mirrors.cloud.tencent.com/elpa/gnu/")
          ("melpa" . "https://mirrors.cloud.tencent.com/elpa/melpa/"))))

(provide 'prelude-pinned-packages)

;;; prelude-pinned-packages.el ends here
```

参考了自带的设置，区分了是否windows。修改后效果提速很明显。

[Github地址](https://github.com/ryzzn/prelude)
