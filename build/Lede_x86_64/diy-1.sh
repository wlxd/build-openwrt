#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 基本不需要添加啥插件了,我搜集了各位大神的插件都集成一个软件包直接打入源码里面了
# 要了解增加了什么东西，就到我的专用软件包里面看看看吧，如果还是没有你需要的插件，请不要一下子就拉取别人的插件包
# 相同的文件都拉一起，因为有一些可能还是其他大神修改过的容易造成编译错误的
# 想要什么插件就单独的拉取什么插件就好，或者告诉我，我把插件放我的插件包就行了
# 软件包地址：https://github.com/281677160/openwrt-package
# 拉取插件请看《各种命令的简单介绍》第4条、第5条说明,不管大神还是新手请认真的看看,再次强调请不要一下子就拉取别人一堆插件的插件包,容易造成编译错误的

# 以下为添加 full cone nat ，没有测试过！！！
# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# fullcone NAT patch
# # git clone -b master --single-branch https://github.com/LGA1150/openwrt-fullconenat package/diy/fullconenat
# https://github.com/LGA1150/openwrt-fullconenat/issues/4
# # sed -i 's/SUBDIRS/M/' package/diy/fullconenat/Makefile
# following two lines need to be added in iptables
# iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT
# iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT
# # 和sfe冲突的话 看这里 https://www.right.com.cn/forum/thread-319827-1-1.html
