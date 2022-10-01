#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 基本不需要添加啥插件了,源码都基本自带了
# 如果还是没有你需要的插件，请不要一下子就拉取别人的插件包
# 相同的文件都拉一起，因为有一些可能还是其他大神修改过的容易造成编译错误的
# 想要什么插件就单独的拉取什么插件就好，或者告诉我，我把插件放我的插件包就行了
# 软件包地址：https://github.com/281677160/openwrt-package
# 拉取插件请看《各种命令的简单介绍》第4条、第5条说明,不管大神还是新手请认真的看看,再次强调请不要一下子就拉取别人一堆插件的插件包,容易造成编译错误的


# Add packages
svn co https://github.com/kiddin9/luci-app-dnsfilter/trunk package/luci-app-dnsfilter
svn co https://github.com/nantayo/passwall/trunk package/luci-app-passwall
svn co https://github.com/ophub/luci-app-amlogic/trunk package/luci-app-amlogic


# firewall custom
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

# Add luci-app-ssr-plus
pushd package/lean
git clone --depth=1 https://github.com/fw876/helloworld
cat > helloworld/luci-app-ssr-plus/root/etc/ssrplus/black.list << EOF
services.googleapis.cn
googleapis.cn
heroku.com
githubusercontent.com 
EOF
popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

#echo '网易云音乐'
#git clone  --depth=1 https://github.com/project-openwrt/luci-app-unblockneteasemusic.git 

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash

# Add luci-theme-argon  主题适配
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git
rm -rf ../lean/luci-theme-argon


