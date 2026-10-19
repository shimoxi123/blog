# 免备案使用域名访问

国内没有备案的域名无法直接访问国内的服务器，本文介绍免备案使用域名访问的方法。
<!--more-->

无需公网IP,无需备案, 直接使用域名访问国内服务器。

用户->https://example.com->Cloudflare Tunnels->HTTP 1.2.3.4:8080->服务器Web 服务

这样用户看到的始终是：

https://example.com

{{< image src="img/Tunnels.png" alt="Tunnels" width="70%" >}}


创建隧道,隧道名称随便 操作系统选择自己的我的是Debian
在服务器上依次运行前两条命令 连接状态显示连接成功就好了
{{< image src="img/2.png" alt="安装并运行" width="50%" >}}
{{< image src="img/连接成功.png" alt="连接成功" width="40%" >}}

在操作中选择配置 > 通过公共主机名将本地应用程序发布到互联网

{{< image src="img/1791176963760134046.png" alt="通过公共主机名发布" width="60%" >}}

点击刚刚创建的域名就可以访问了

{{< image src="img/1791177139628850390.png" alt="访问成功" width="70%" >}}


---

> 作者: [石墨烯积木](https://www.san3.cn)  
> URL: https://www.san3.cn/002/  

