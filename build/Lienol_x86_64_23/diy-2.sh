#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
# sed -i 's/192.168.1.1/192.168.3.2/g' package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能使用中文）
# sed -i '/uci commit system/i\uci set system.@system[0].hostname='CSCLEDE'' package/default-settings/files/zzz-default-settings

# 内核显示增加自己个性名称（281677160 build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些为后期增加）
# sed -i "s/OpenWrt /ixxmu build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/default-settings/files/zzz-default-settings

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改内核版本
# sed -i 's/KERNEL_PATCHVER:=4.14/KERNEL_PATCHVER:=4.19/g' target/linux/x86/Makefile
# 删除lionl自带
# rm -rf package/lean/luci-app-sfe
# rm -rf package/lean/luci-app-flowoffload
# 删除small自带的音乐插件，因为我这里不能用
# rm -rf package/small-package/UnblockNeteaseMusic
# rm -rf package/small-package/UnblockNeteaseMusic-Go

# cp -Rf "${Home}"/build/common/LIENOL/diy/* "${Home}"

# rm -rf package/feeds/lienol/luci-app-ssr-mudb-server
# rm -rf feeds/packages/libs/libcap
# rm -rf package/luci-app-passwall/{v2ray-core,v2ray-plugin,xray-core,xray-plugin}

# find . -name 'luci-app-netdata' -o -name 'netdata' -o -name 'luci-theme-argon' | xargs -i rm -rf {}
# find . -name 'ddns-scripts_aliyun' -o -name 'ddns-scripts_dnspod' -o -name 'luci-app-wol' | xargs -i rm -rf {}
# find . -name 'luci-app-wrtbwmon' -o -name 'wrtbwmon' -o -name 'pdnsd-alt' | xargs -i rm -rf {}
# find . -name 'UnblockNeteaseMusic-Go' -o -name 'UnblockNeteaseMusic' -o -name 'luci-app-unblockmusic' | xargs -i rm -rf {}

# 这个是xray 1.6.4 锁死版
# pushd package/small-package/luci-app-ssr-plus
# git reset --hard 7842f18c33019ec281083ff3f88294fbe5a89bda 
# popd


rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang


# 这个是xray 1.8.4 锁死版
pushd package/small/xray-core
git reset --hard 8abfcaf24ee8e19c5b838dd355515aad91c6af85
popd


# 根据 https://github.com/kenzok8/openwrt_Build/blob/master/.github/workflows/Lienol.yml 改的
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
rm -rf feeds/luci/themes/luci-theme-argon && rm -rf feeds/other/{luci-app-adguardhome,luci-app-dockerman}
rm -rf feeds/lienol/luci-app-fileassistant && rm -rf feeds/packages/net/{adguardhome,smartdns}
cp -f feeds/smpackage/.github/diy/zzz-default-settings package/default-settings/files/zzz-default-settings
cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner
patch -p1 < "feeds/smpackage/.github/diy/patches/0004-luci-mod-status-firewall-disable-legacy-firewall-rul.patch"
rm -rf feeds/smpackage/luci-theme-design && git clone -b js --single-branch https://github.com/kenzok78/luci-theme-design feeds/smpackage/luci-theme-design

# 来自 kenzok8/openwrt_Build
# rm -rf feeds/luci/themes/luci-theme-argon && rm -rf feeds/other/luci-app-adguardhome && rm -rf feeds/packages/net/adguardhome
# rm -rf feeds/lienol/luci-app-fileassistant && rm -rf feeds/other/luci-app-dockerman && rm -rf feeds/packages/net/smartdns
# cp -f feeds/smpackage/.github/diy/zzz-default-settings package/default-settings/files/zzz-default-settings
# cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner && rm -rf feeds/smpackage/upx
# rm -rf feeds/smpackage/luci-theme-design && git clone -b js --single-branch https://github.com/gngpp/luci-theme-design feeds/smpackage/luci-theme-design
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# sed -i "s/%D %V, %C/openwrt $(date +'%m.%d') by kenzo/g" package/base-files/files/etc/banner

# 23.x 版本的坑 这是没改的手的######
# sed -i 's/ +libopenssl-legacy//g' package/small/shadowsocksr-libev/Makefile

# 尝试压缩xray
# sed -i -e "/\/usr\/bin\/xray/a  \\\t$\(STAGING_DIR_HOST\)\/bin\/upx --lzma --best $\(1\)\/usr\/bin\/xray" package/small/xray-core/Makefile

list="\
  autosamba                ddns-scripts_aliyun             ddns-scripts-cloudflare ddns-scripts_dnspod \
  luci-app-accesscontrol   luci-app-adbyby-plus            luci-app-arpbind        luci-app-autoreboot \
  luci-app-control-timewol luci-app-control-webrestriction luci-app-control-weburl luci-app-cpufreq \
  luci-app-ddns            luci-app-filetransfer           luci-app-ipsec-vpnd     luci-app-nlbwmon \
  luci-app-ramfree         luci-app-ssr-plus               luci-app-timecontrol    luci-app-turboacc \
  luci-app-unblockmusic    luci-app-unblockmusic           luci-app-upnp           luci-app-vlmcsd \
  luci-app-vsftpd          luci-app-wol                    luci-app-zerotier \
"
for i in $list; do
  sed -i "/DEFAULT_PACKAGES:=/,/^\s*$/s/$i//" include/target.mk
  sed -i "/DEFAULT_PACKAGES/,//s/$i//" target/linux/ramips/Makefile
done

# 根据 https://github.com/kenzok8/openwrt_Build/blob/master/.github/workflows/Lienol.yml 改的
sed -i 's/192.168.1.1/192.168.3.2/g' package/base-files/files/bin/config_generate
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
sed -i 's/"aMule设置"/"电驴下载"/g' `grep "aMule设置" -rl ./`
sed -i 's/"网络存储"/"NAS"/g' `grep "网络存储" -rl ./`
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `grep "Turbo ACC 网络加速" -rl ./`
sed -i 's/"实时流量监测"/"流量"/g' `grep "实时流量监测" -rl ./`
sed -i 's/"KMS 服务器"/"KMS激活"/g' `grep "KMS 服务器" -rl ./`
sed -i 's/"TTYD 终端"/"命令窗"/g' `grep "TTYD 终端" -rl ./`
sed -i 's/"USB 打印服务器"/"打印服务"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"Web 管理"/"Web"/g' `grep "Web 管理" -rl ./`
sed -i 's/"管理权"/"改密码"/g' `grep "管理权" -rl ./`
sed -i 's/"带宽监控"/"监控"/g' `grep "带宽监控" -rl ./`
sed -i 's/"Argon 主题设置"/"Argon设置"/g' `grep "Argon 主题设置" -rl ./`
