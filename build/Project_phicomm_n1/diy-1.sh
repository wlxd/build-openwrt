#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 基本不需要添加啥插件了,源码都基本自带了
# 如果还是没有你需要的插件，请不要一下子就拉取别人的插件包
# 相同的文件都拉一起，因为有一些可能还是其他大神修改过的容易造成编译错误的
# 想要什么插件就单独的拉取什么插件就好，或者告诉我，我把插件放我的插件包就行了
# 软件包地址：https://github.com/281677160/openwrt-package
# 拉取插件请看《各种命令的简单介绍》第4条、第5条说明,不管大神还是新手请认真的看看,再次强调请不要一下子就拉取别人一堆插件的插件包,容易造成编译错误的

#增加helloworld
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

# Add packages
svn co https://github.com/kiddin9/luci-app-dnsfilter/trunk package/diy/luci-app-dnsfilter
svn co https://github.com/ophub/luci-app-amlogic/trunk package/diy/luci-app-amlogic

#echo '网易云音乐'
git clone  --depth=1 https://github.com/project-openwrt/luci-app-unblockneteasemusic.git  package/diy/luci-app-unblockneteasemusic

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan package/diy/luci-app-serverchan

# Add OpenClash
# git clone --depth=1 https://github.com/vernesong/OpenClash package/diy/OpenClash

# 修改自带主题，删除原主题包
rm -rf package/lean/luci-theme-argon
# rm -rf openwrt/package/lean/luci-theme-netgear

# 添加新的主题包 # Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# git clone https://github.com/sypopo/luci-theme-atmaterial.git package/lean/luci-theme-atmaterial
# git clone https://github.com/sypopo/luci-theme-argon-mc.git package/lean/luci-theme-argon-mc
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/lean/luci-theme-opentomcat
git clone https://github.com/garypang13/luci-theme-edge.git package/lean/luci-theme-edge
# argon 的设置
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git  package/diy/luci-app-argon-config


