---
title: "在archLinux上使用CLion开发stm32"
date: 2026-02-22T15:12:20+08:00
url: "/2026/02/22/15"
draft: false
description: "本文介绍了如何在archLinux上使用CLion开发stm32，包括安装CLion、安装stm32cubeclt和stm32cubemx，以及新建工程的详细步骤。"
comment: true
weight: 0
tags:
  - "stm32"
  - "clion"
  - "教程"
categories:
  - "嵌入式开发"
  - "教程"
summary: "本文介绍了如何在archLinux上使用CLion开发stm32，包括安装CLion、安装stm32cubeclt和stm32cubemx，以及新建工程的详细步骤。"
featured_image_preview: "https://img.san3.cn/img/1b305c16104e6738.webp"
---
## 1.0 安装CLion

#### 1.1 在终端中输入以下命令先安装``jetbrains-toolbox``
```
yay -S jetbrains-toolbox
```

#### 1.2 安装成功后打开jetbrains-toolbox
按照要求登录自己的账号并在里面选择安装`CLion`安装成成功后如下图所示
{{< image src="https://img.san3.cn/img/fbb7daca5ecad2b5.webp" width="30%" alt="CLion安装界面" >}}

## 2.0 安装stm32cubeclt
```
yay -S stm32cubeclt
```
第一次运行后会提示错误(原因:这个软件包需要登录后下载)

> [!NOTE]+
> ==> 正在创建软件包：stlink-server 2.1.1-9 (2026年02月22日 星期日 19时51分06秒)
> ==> 获取源代码...
> ==> 错误： st-link-server-v2-1-1.zip 没有在创建目录中找到，也不是一个 URL。
> 错误： 未能下载 'stlink-server-2.1.1-9' 的源:
> 错误： 无法构建 stm32cubeclt-1.20.0-1，未满足以下依赖关系：stlink-server
> 错误： 未能构建的软件包：stlink-server-2.1.1-9  stm32cubeclt-1.20.0-1

#### 2.1手动下载`st-link-server`
这个时候需要我们手动下载`st-link-server-v2-1-1.zip`，下载地址为：<https://www.st.com/en/development-tools/st-link-server.html>
打开后向下滑动 点击`Get latest`下载(根据提示同意用户协议后会跳转到登录界面，登录后就可以下载了)
{{< image src="https://img.san3.cn/img/a9ff17f3f72c2ee3.webp" width="90%" alt="下载st-link-server-v2-1-1.zip" >}}
下载完成后，将文件重命名为 `st-link-server-v2-1-1.zip`（确保文件名与 PKGBUILD 中 source 完全一致），然后放入构建目录：
- 如果你用 yay：~/.cache/yay/stlink-server/
- 如果你用 paru：~/.cache/paru/stlink-server/
- 如果你用 makepkg：在你运行 makepkg 的目录下

#### 2.2手动下载`stm32cubeclt`
如同上面的 2.1 手动下载stm32cubeclt-1.20.0-1,下载地址为:<https://www.st.com/en/development-tools/stm32cubeclt.html>
{{< image src="https://img.san3.cn/img/00069d3e723531f7.webp" width="90%" alt="下载stm32cubeclt-1.20.0-1" >}}
下载完成后，将文件重命名为 `en.st-stm32cubeclt_1.20.0_26822_20251117_1245_amd64.sh.zip`（确保文件名与 PKGBUILD 中 source 完全一致），然后放入构建目录：
- 如果你用 yay：~/.cache/yay/stm32cubeclt/
- 如果你用 paru：~/.cache/paru/stm32cubeclt/
- 如果你用 makepkg：在你运行 makepkg 的目录下

#### 2.3完成后再次运行安装命令就可以成功安装了：
```bash
yay -S stm32cubeclt
```

## 3.0 安装stm32cubemx
```bash
yay -S stm32cubemx
```
## 4.0 新建工程
打开CLion，点击`新建项目`，选择`STM32CubeMX`
如果CLion显示STM32CubeMX找不到，则编辑**STM32CubeMX**位置 设置为`/opt/stm32cubemx/STM32CubeMX`  **stm32cubeclt**位置设置为`/opt/stm32cubeclt/`
#### 4.1使用STM32CubeMX生成初始化代码
手动启动STM32CubeMX 点击**ACCESS TO MCU SELECTOR** 等待下载完成
{{< image src="https://img.san3.cn/img/8090eff40ef42003.webp" width="90%" alt="STM32CubeMX界面" >}}
搜索自己的芯片型号
{{< image src="https://img.san3.cn/img/e1cb9c91e3b2a99a.webp" width="90%" alt="搜索芯片型号" >}}
选择好了后在右上角点击Staret Project
将Debug设置为 `Serial Wire`
{{< image src="https://img.san3.cn/img/544ce8df62cd67c2.webp" width="90%" alt="设置Debug" >}}

切换到Project Manager界面，如下图进行设置
{{< image src="https://img.san3.cn/img/da07590f35a698ed.webp" width="90%" alt="Project Manager界面" >}}
设置好了之后点击右上角的GENERATE CODE，(如果提示缺少固件包点击yes会自动下载)等待生成完成后就可以在CLion中打开了
在CLion中将位置修改为刚刚生成的代码位置，点击继续
{{< image src="https://img.san3.cn/img/846ff8186d9350e3.webp" width="90%" alt="CLion打开工程界面" >}}
注意 在项目向导中将CMake构建类型设置为**Debug-Debug**，点击完成
{{< image src="https://img.san3.cn/img/abf940ea180f7776.webp" width="90%" alt="设置构建类型" >}}

在高级设置中勾选为所有项目启用调试服务器
{{< image src="https://img.san3.cn/img/ef42ec5d4eaf1bcc.webp" width="90%" alt="启用调试服务器" >}}

点击右上角的编辑调试服务器
{{< image src="https://img.san3.cn/img/08cb30758b9f39ae.webp" width="90%" alt="编辑调试服务器" >}}
新建一个ST-Link调试服务器，设置保持默认
然后点击绿色小三角就可以开始烧录了

> [!TIP]
> 可以写一个led灯闪烁的代码，如果成功就说明配置好了
