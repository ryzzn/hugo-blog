---
title: 使用chunkwm
tags: 
 - 工具
 - macos
date: 2019-01-17 01:35:06
---

我是从**Linux**转到**MacOS**的，转过来以后最大的两个感受是：

1. 界面比我之前的*awesome*漂亮多了。
2. 快捷键风格统一了，但是比较难配置。
3. 窗口管理弱爆了，并且没有很好的第三方窗口管理器。

今天介绍的**chunwm**，主要是针对第三点“窗口管理器”。那时候刚转到**MacOS**上，尝试后各种窗口管理器，比如Spectacle，Moom，SizeUp，Amethyst，Hammerspoon等，最后放弃了各种功能后定格在了Magnet。直到前段时间，偶遇了**chunkwm**，相见恨晚的那种感觉油然而生。

**chunkwm官网**：https://koekeishiya.github.io/chunkwm/

### 印象

**chunkwm**给我的第一感觉就是，它的设计者肯定是一个键盘偏执狂。它使用了一个后台的可配置服务（skhd）来触发键盘消息后执行命令，让chunkwm本身不需要做任何键盘快捷键处理。

第二个感觉就是，终于可以自定义规则来放置我的应用窗口了。

第三个感觉是，这家伙应该还有很多bug需要修复。

### 功能

**chunkwm**提供的功能比我现在用到的要多很多，以下几点是我需要并且用到的功能：

- *工作区*（Mac叫Desktop）管理：可以新建、删除工作区。工作区内 可以自定义窗口排列规则。
- 窗口管理：自动对应用窗口进行排列，允许快捷键调整窗口（工作区内或者跨工作区）。
- 其它快捷键支持：定义全局快捷键执行命令

以上功能，窗口管理部分都是由**chunwm**完成的，快捷键部分则是用**skhd**完成的。

### 安装

```shell
# 安装chunkwm
brew install chunkwm-tiling
# 安装skhd
brew install koekeishiya/formulae/skhd
# 启动skhd，可以先不启动，配置好以后再启动。
brew services start skhd
```

P.S. 详细内容可以参考它们的官网（Github项目地址）：https://github.com/koekeishiya/

### 配置

我目前的需求比较简单，所以配置内容比较少。只选一些重要的配置来说。

#### chunkwm

```shell
## file: ~/.chunkwmrc
# 全局工作区配置，bsp就是平铺自动切分大小。
chunkc set global_desktop_mode           bsp
chunkc set global_desktop_offset_top     0
chunkc set global_desktop_offset_bottom  0
chunkc set global_desktop_offset_left    0
chunkc set global_desktop_offset_right   0
chunkc set global_desktop_offset_gap     0

# 1: iTerm
chunkc set 1_desktop_offset_gap          0
# 2: Emacs
chunkc set 2_desktop_mode          monocle
# 3: Chrome
chunkc set 3_desktop_mode          monocle

chunkc tiling::rule --owner Finder --name Copy --state float &
chunkc tiling::rule --owner \"App Store\" --state float &
chunkc tiling::rule --owner "iTerm" --except "Preferences" -d 1 --state tile &
chunkc tiling::rule --owner Emacs --except '^$' --state tile -d 2 &
chunkc tiling::rule --owner Chrome --except '^$' -d 3 --state tile &
chunkc tiling::rule --owner \"Typora\" --except "Preferences" -d 5 --state tile &
```

大致的含义就是：

- 全局默认使用bsp的窗口管理模式（自动平铺，新窗口切分当前活跃窗口位置）
- 2、3两个工作区使用单窗口最大化模式
- 剩下的是各种应用的窗口位置和属性

#### skhd

```shell
## file: ~/.skhdrc
# close focused window
cmd + alt + ctrl - w : chunkc tiling::window --close

# focus window
cmd + alt + ctrl - j : chunkc tiling::window --focus west
cmd + alt + ctrl - k : chunkc tiling::window --focus south
cmd + alt + ctrl - i : chunkc tiling::window --focus north
cmd + alt + ctrl - l : chunkc tiling::window --focus east

cmd + alt + ctrl - u : chunkc tiling::window --focus prev
cmd + alt + ctrl - o : chunkc tiling::window --focus next

# equalize size of windows
cmd + alt + ctrl - 0 : chunkc tiling::desktop --equalize

# move window
cmd + alt + ctrl + shift - j : chunkc tiling::window --warp west
cmd + alt + ctrl + shift - k : chunkc tiling::window --warp south
cmd + alt + ctrl + shift - i : chunkc tiling::window --warp north
cmd + alt + ctrl + shift - l : chunkc tiling::window --warp east
cmd + alt + ctrl + shift - u : chunkc tiling::window --warp prev
cmd + alt + ctrl + shift - o : chunkc tiling::window --warp next

# fast focus desktop
cmd + alt + ctrl - x : chunkc tiling::desktop --focus $(chunkc get _last_active_desktop)
cmd + alt + ctrl - z : chunkc tiling::desktop --focus prev
cmd + alt + ctrl - c : chunkc tiling::desktop --focus next
cmd + alt + ctrl - 1 : chunkc tiling::desktop --focus 1
cmd + alt + ctrl - 2 : chunkc tiling::desktop --focus 2
cmd + alt + ctrl - 3 : chunkc tiling::desktop --focus 3
cmd + alt + ctrl - 4 : chunkc tiling::desktop --focus 4
cmd + alt + ctrl - 5 : chunkc tiling::desktop --focus 5
cmd + alt + ctrl - 6 : chunkc tiling::desktop --focus 6
cmd + alt + ctrl - 7 : chunkc tiling::desktop --focus 7
cmd + alt + ctrl - 8 : chunkc tiling::desktop --focus 8
cmd + alt + ctrl - 9 : chunkc tiling::desktop --focus 9

# send window to desktop
# send window to desktop
cmd + alt + ctrl + shift - x : chunkc tiling::window --send-to-desktop $(chunkc get _last_active_desktop)
cmd + alt + ctrl + shift - z : chunkc tiling::window --send-to-desktop prev
cmd + alt + ctrl + shift - c : chunkc tiling::window --send-to-desktop next
cmd + alt + ctrl + shift - 1 : chunkc tiling::window --send-to-desktop 1
cmd + alt + ctrl + shift - 2 : chunkc tiling::window --send-to-desktop 2
cmd + alt + ctrl + shift - 3 : chunkc tiling::window --send-to-desktop 3
cmd + alt + ctrl + shift - 4 : chunkc tiling::window --send-to-desktop 4
cmd + alt + ctrl + shift - 5 : chunkc tiling::window --send-to-desktop 5
cmd + alt + ctrl + shift - 6 : chunkc tiling::window --send-to-desktop 6
cmd + alt + ctrl + shift - 7 : chunkc tiling::window --send-to-desktop 7

# focus monitor
cmd + alt + ctrl - q  : chunkc tiling::monitor -f prev
cmd + alt + ctrl - e  : chunkc tiling::monitor -f next

# change layout of desktop
cmd + alt + ctrl - b : chunkc tiling::desktop --layout bsp
cmd + alt + ctrl - m : chunkc tiling::desktop --layout monocle
cmd + alt + ctrl - n : chunkc tiling::desktop --layout float
```

P.S. 所有的操作都是通过`chunkc`实现的，有时间的话可以把`chunkc`的命令都玩一遍，再定制专属自己的快捷键。

P.P.S. 我的配置里面大量出现`cmd + alt + ctrl`是因为我把它绑定在一个物理按键上了。
