#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# DIY扩展二合一了，在此处可以增加插件
# 自行拉取插件之前请SSH连接进入固件配置里面确认过没有你要的插件再单独拉取你需要的插件
# 不要一下就拉取别人一个插件包N多插件的，多了没用，增加编译错误，自己需要的才好
# 修改IP项的EOF于EOF之间请不要插入其他扩展代码，可以删除或注释里面原本的代码
# 如果你的OP是当主路由的话，网关、DNS、广播都不需要，代码前面加 # 注释掉，只保留后台地址和子网掩码就可以
# 如果你有编译ipv6的话，‘去掉LAN口使用内置的 IPv6 管理’代码前面也加 # 注释掉



#cat > package/base-files/files/etc/networkip <<-EOF
#uci set network.lan.ipaddr='192.168.3.2'                                    # IPv4 地址(openwrt后台地址)
#uci set network.lan.netmask='255.255.255.0'                                 # IPv4 子网掩码
#uci set network.lan.gateway='192.168.3.1'                                   # IPv4 网关
#uci set network.lan.broadcast='192.168.3.255'                               # IPv4 广播
#uci set network.lan.dns=''                         # DNS(多个DNS要用空格分开)
#uci set network.lan.delegate='0'                                            # 去掉LAN口使用内置的 IPv6 管理
#uci commit network                                                          # 不要删除跟注释,除非上面全部删除或注释掉了
#uci set dhcp.lan.ignore='1'                                                 # 关闭DHCP功能
#uci commit dhcp                                                             # 跟‘关闭DHCP功能’联动,同时启用或者删除跟注释
#uci set system.@system[0].hostname='MyRouter'                            # 修改主机名称为OpenWrt-123
#sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd             # 设置ttyd免帐号登录，如若开启，进入OPENWRT后可能要重启一次才生效
#EOF


# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile            # 选择argon为默认主题

# sed -i "s/OpenWrt /${Author} Compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/emortal/default-settings/files/zzz-default-settings  # 增加个性名字${Author}默认为你的github账号

# sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/emortal/default-settings/files/zzz-default-settings   # 设置密码为空

#sed -i 's/PATCHVER:=4.19/PATCHVER:=4.14/g' target/linux/x86/Makefile                               # x86机型,默认内核4.19，修改内核为4.14或者4.9


# K3专用，编译K3的时候只会出K3固件
#sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3|' target/linux/bcm53xx/image/Makefile


# 在线更新时，删除不想保留固件的某个文件，在EOF跟EOF直接加入删除代码，记住这里对应的是固件的文件路径，比如： rm /etc/config/luci
#cat >$DELETE <<-EOF
#EOF


# 修改插件名字
sed -i 's/"BaiduPCS Web"/"百度网盘"/g' package/ctcgfw/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
sed -i 's/cbi("qbittorrent"),_("qBittorrent")/cbi("qbittorrent"),_("BT下载")/g' package/lean/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
sed -i 's/"aMule设置"/"电驴下载"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/ctcgfw/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/"实时流量监测"/"流量"/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/"KMS 服务器"/"KMS激活"/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
sed -i 's/"TTYD 终端"/"命令窗"/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/"USB 打印服务器"/"打印服务"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/"Web 管理"/"Web管理"/g' package/lean/luci-app-webadmin/po/zh-cn/webadmin.po
sed -i 's/"管理权"/"改密码"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"带宽监控"/"监视"/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po


# 整理固件包时候,删除您不想要的固件或者文件,让它不需要上传到Actions空间
#cat >${GITHUB_WORKSPACE}/Clear <<-EOF
#rm -rf config.buildinfo
#rm -rf feeds.buildinfo
#rm -rf openwrt-x86-64-generic-kernel.bin
#rm -rf openwrt-x86-64-generic.manifest
#rm -rf openwrt-x86-64-generic-squashfs-rootfs.img.gz
#rm -rf sha256sums
#rm -rf version.buildinfo
#EOF
