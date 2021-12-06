#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 基本不需要添加啥插件了,源码都基本自带了
# 如果还是没有你需要的插件，请不要一下子就拉取别人的插件包
# 相同的文件都拉一起，因为有一些可能还是其他大神修改过的容易造成编译错误的
# 想要什么插件就单独的拉取什么插件就好，或者告诉我，我把插件放我的插件包就行了
# 软件包地址：https://github.com/281677160/openwrt-package
# 拉取插件请看《各种命令的简单介绍》第4条、第5条说明,不管大神还是新手请认真的看看,再次强调请不要一下子就拉取别人一堆插件的插件包,容易造成编译错误的
# 天灵自带turboACC已经包括了sfe或者flowofflowad加速，选择一个就行了，不用再另行添加源
# svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-sfe package/diy/luci-app-sfe
# svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-flowoffload package/diy/luci-app-flowoffload
# 添加 京东签到,这个无法添加，暂时未解决
 # svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk package/diy/luci-app-jd-dailybonus  #京东签到
 
# git clone https://github.com/kenzok78/jeii package/jeii
# git clone https://github.com/kenzok8/jell package/jell
 
 # 添加ddnsto成功, 
 # 天灵的源码自带ddnsto但是需要手动开启，所以也不需要额外添加了，但是没有gowebdav
sed -i '$a src-git nas https://github.com/linkease/nas-packages.git;master' feeds.conf.default
sed -i '$a src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' feeds.conf.default

 # sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
 # svn co https://github.com/Lienol/openwrt/trunk/package/default-settings package/emortal/default-settings

