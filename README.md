**重要提醒：**
03102023

目前SSRplus不支持reality的实现，并且xray开发者给出了VLESS-XTLS-uTLS-REALITY的提醒和建议，内容有[**此大佬**](https://github.com/chika0801/Xray-examples) 收集和总结,这里投喂给chatgpt总结如下，至于是否升级你的部署**请自行斟酌**

> 以下是XTLS Vision的使用说明和注意事项的主要点：
> 1. 目前几乎没有收到配置正确的XTLS Vision被封端口的报告，但也要确保服务端使用合理的端口，禁回国流量，只配置XTLS Vision，不兼容普通TLS代理，回落到网页，不回落/分流到其它代理协议，客户端启用uTLS（fingerprint）。
> 2. 即使按照配置正确的方式使用XTLS Vision，仍不能保证100%不被封，可能会被封锁。如果发现被封，可以尝试换端口、换IP、换服务商等方法。
> 3. XTLS Vision不支持与纯净入站以外的代理协议共存，但与REALITY H2服务端可以同端口共存，在回落功能上建议使用REALITY VLESS回落至H2C。
> 4. 建议开启混淆以应对机场封锁策略，其中WSS应该被列为deprecated，因为它已经没有必要使用。
> 5. 对于服务端的连接策略，建议修改policy的handshake和connIdle等，以减少特征的暴露。
> 6. 回落功能是必要的，特别是现在大规模使用uTLS模仿浏览器指纹，建议开启服务端的指纹特征。
____________________________________________________________________

R老接手后的xray迎来了reality的新时代1.8.0，其实在我看来可能就是shadowtls的另一种实现，
但是在当前节点03102023时刻，墙加高的同时再次出现了有多人人被墙的现象，另外自此版本之后xtls-splice正式退出历史舞台，
升级新版如果配置文件有xtls配置会直接报错，所以鉴于此暂时不升级继续用xtls，
毕竟偶尔断流也正常，切换到vmess也不影响。当然类似shadowtls的频繁断流也在新的reality中有报告，再鉴于之前的封端口版本，

**强烈建议暂时不要升级！！！**
**强烈建议暂时不要升级！！！** 
**强烈建议暂时不要升级！！！**

_________________

1.7.5 版本第一时间双边升级之后，除了xtls-vision协议继续拉夸之外，其他原来的协议也慢了，xtls_splice直接被废除不能用了,
关于新协议的坑这不是这个大佬第一次偷摸的啥都不提的更新了。
双边回退版本之后一切如常了,速度也上去了。

**强烈建议保留在1.7.2以及之前的版本,勿盲目升级！！！**

> **建议版本：**
> 1. 1.7.2（vision第一版协议的bug解决版之R老回归版）；
> 
> 2. 1.6.4（xtls的utls加强版）；
> 
> 3. 1.4.2（R老消失版）

02092023 *rprx* 出手立即更新到了1.7.5，开始摒弃 xtls-rprx-splice 系列了，此经典协议在这一版彻底不可用；之前的vision速度也上来了，大佬出手就是不一样！ 客户端服务端双端更新迎接吧！

01082023 *rprx* 终于出手解决了vision的bug，版本号为 **1.7.2**,并建议使用此协议取代之前xtls。大佬就是大佬啊！

01012023 **再一次** 服务器端更新到 **1.7.0** 不出意外的**被墙**了，所以现在这一批维护更新的人真是放着bug搞不定只顾刷版本号了！   

已知bug是选择 chrome 特征依旧会被识别为go客户端不管概率高低，vision 依旧会出现错误，并且我的体验是vision的连接非常慢体验，连vmess都不如；
  
触发致命bug一下被击毙了哪还管你出发频率高低呢，继续在服务器端回退到1.6.4，这帮刷版本号到人早晚把xray搞到不能用！  

####################################################### 
12122022 xray 更新到 1.6. 5以及之后版本增加了wireguar协议的出口配置，但是**体积增加了 1M 多**，所以已经是低内存设备不友好了，
所以这里更新到现在仍旧是测试版的1.6.4版本的xray，虽然新的**vision**从1.6.2到1.6.5都**没有解决**使用上的问题，但是
**1.6.4** 解决了 **xtls+vlesss** 的使用**utls 库**的问题，这对于更新来说足够了！

#######################################################  
LEDE大雕的固件其实还是18.06，已经可以正常编译使用了  
09112022 Lieonl大的19.07在编译xray时需要go1.18，在diysh2中进行了官方替换正常通过了。https://github.com/coolsnowwolf/lede/issues/5719

加上了最后一句压缩xray_core效果明显， 14M变为13.3M,Lieonl 和 天灵的都是，但是加上另外四句之后Lieonl体积增加了到了13.9M，但是天灵依旧13.3M，所以xray_core 压缩很重要！

CONFIG_XRAY_CORE_COMPRESS_UPX=y

CONFIG_boost-compile-visibility-hidden=y  
CONFIG_boost-runtime-shared=y  
CONFIG_boost-static-and-shared-libs=y  
CONFIG_boost-variant-release=y  
并且根据搜索的结果，LEDE的固件有后四句，Lieonl的没有见过，所以暂时后四句加载天灵、lede的固件中！

**xray 1.5.0千万不要用，程序记录日志出现一堆错误并且导致用了很久的vps被封！

请严防死守R大的1.4.2版本！！！

122721  
云编译提示报错 *error: RPC failed; curl 56 GnuTLS recv error (-54)* 相关错误，在拉取的时候添加actions认证即可；  
> git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"  
> git config --global user.name "github-actions[bot]"  

好了，Back to normal!  


终于折腾好了，12082021编译的应该没有问题，亲测天灵的也可以了，天灵的是在强制修改为天灵源码中默认自带的zzz-defaullt-settings配置就一切正常了！套用其他人的就会出现各种问题！
集成了automount、DDNSTO和webdav，15.3M基本算是满了，因为mini是15.5M 真坑！你可以愉快的使用USB来穿透了。  

去掉了naiveproxy之后固件缩减了2M，好吧，那就删了它吧，其他都保留，轻量精简13.3M！！！  

下载 Lieonl 和 天灵  
https://github.com/ixxmu/build-openwrt/releases/tag/20211208123854  
https://github.com/ixxmu/build-openwrt/releases/tag/20211208102045  

Lede 和 Lieonl开始出现一些分支，主要是因为 Leionl 是以官方OpenWrt为基准更新，最近官方OpenWrt切换到了wolfssl，目前ssr plus 仍然以openssl为依赖，但是如果你两个都添加也没必要，除了会增加固体积还可能会出错，所以，目前的情况是在 Lieonl 编译的时候需要手动选中 LuCI->Collection 中选中 wolfssl即可正常出现ssr plus；Lede 和 Immortal的固件一样都是默认openssl，所以也不需要额外关注。
  
试过了，如果在Lede和天灵中都选择为wolfssl,编译的配置仍旧需要openssl，所以那就直接openssl算了；  


不知道修改之后能否正常编译。  

Lieonl中在11252021中新增了SFE加速，之前是没有的。  

如何添加DDNSTO？[看这里](https://www.right.com.cn/forum/thread-4081670-1-1.html)

> 可能有用：    
>  1 在make menuconfig进行配置编译选项中，Libraries  --->下面，libustream-openssl和libustream-mbedtls中间去掉一个。    
>  2 在make menuconfig进行配置编译选项中，LuCI->Collection下的libustream-mbedtls和luci-ssl-openssl两个选项都进行了选择，其实只要进行其中一个选择便可。  
>  [参考链接](http://topurl.cn/9KZd)

或者用DDNSTO的官方指引第一条，成功安装点亮！

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 不要随意拉取源地址更新的代码
Github 为限制资源的浪费下手在线编译了，所以所有打开SSH进行编译的操作都会被中断而无法完成，所以大佬修改了逻辑，只需要拿到config配置文件就可以让整个编译继续进行，此老的地址是完成编译之后才上传config文件，所以大佬新的项目逻辑是打开一次ssh得到你的设备config，然后保存在config里面之后自动编译即可。本项目是大佬的旧项目只保留了Glinet-300nV2在天灵和Lieonel下的配置文件，有需要的话请转向 [大佬新项目地址](https://github.com/281677160/build-actions)。  

#### [大佬新项目地址](https://github.com/281677160/build-actions)  

此版算是备份吧，源地址少了很多自定义选项，倾向于自动化！！！只能依赖上游了  

#### 源地址大佬已经更新代码，所以上游可以继续向大佬看齐继续编译了，但是大佬取消掉了4.14内核+18.06的编译，改为了天灵21.02+5.4内核，Lieonl继续19.07+4.14内核，Lede持续保持内核和源码最新。但是天灵的master源码就是18.06，并且我主要用来编译老设备，所以packages源更换为天灵的官方源，编译可以继续通过了。
#### 其实你也可以用这个版本的代码继续编译天灵的21.02及其维护的新版内核，因为我用不到，所以就不尝试了。

Lieonl源码上游出现错误，先回退 即可 git reset --hard fc7a887019b47cb12a9dfa565c2575045f791a4f

workflow_dispatch:  手动触发编译

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Date:20210218 gli300nv2 终于编译成功了，只保留了ssr+xray1.3核心的插件，固件其实还有问题当修改WiFi名称之后，再一次就打不开路由地址了，但是ssh以及路由自身功能不任何受影响，
所以编译以前最好确定好你自己的路由器ip地址和要自定义的名称，否则更改起来不知道会有什么问题。目前运行起来效果良好。
在拉取上游更新以前请先看看上有改变的多不，如果上游不更了，删了再拉取就晚了！
破案了。开启splice就无法登录login页面了，可能是sfe高通加速的锅，turbo acc 不受影响
再次关于加速选哪个，暂时看到的是只有7621支持硬件加速，其他的都是软件算法的软加速，Porject的固件默认是flowoffload加速，取消掉它之后会出现sfe加速选项，所以这里的7628AN选用sfe加速。
试过5.4内核的LEDE的固件编译了两个加速同时存在，实测并无太大差别！不知道4.14表现如何

xray1.31+4.14.222内核开启sfe转发，关闭桥接加速，开启DNS加速和多线程（真的是响应快），并设置了联通代理，观察到的是负载可能更大了，但是下载速度提到了2.5M最大，并且speedtest可以到80左右了。<br/>
可用固件 
> #19   
> #30 xray1.4+18.06  
> #40 xray1.4.2+18.06  
> #55 xray1.4.1+19.07  #87
  
直接编译就行，不用做任何修改，就是GL-MT300N-V2 的天灵18.06固件  
### ~~Lieonl的固件搞不了~~
添加天灵的相对比较新的turbo acc插件，无法被此固件正常拉取融合进去
Lieonl的自带package有很多已经很老了，所以再添加新版本的时候会出重名和冲突，暂时试了一个解决办法不知道可以不，如果不行的话之后就固定天灵的固件了。在 下载${{matrix.target}}源码 的部分
添加要替换的package，如 luci-app-sfe,在rm -rf package/lean/ 语句里添加即可，其他牌子的固件对应修改即可，同时你要在sh-1里面添加上你要替换的package源。编译成功了，新版sfe也编译进去了，但是固件无法正常联网，~~所以Lieonl的固件不折腾了~~。<br/>
因为 acc加速 
>目前仅支持 PDNSD 和 DNSForwarder

而Lieonl使用的是DDNS，所以使用加速要把DNSForwarder加上即可，不出意外编译的就可以用了。默认添加的passwall直接设置了插件选项，但是他折叠了，所以你需要打开它把选中的项目取消掉；
Lieonl 如果要替换自带软件，在对应的sh2文件添加语句即可，如为了要安装最新版的luci-app-sfe,而固件自带了，你只要在sh2文件中添加 rm -rf package/lean/luci-app-sfe 就删除了固件自带的 luci-app-sfe，在sh1中设置好自己的就可以了。

还是终于折腾成功了，Lieonl 大 19.07 Openwrt+xray 1.4.1,xray不是最新（1.4.2），官方的ssrplus虽然是最新但是用官方源编译出来的无法正常联网使用；所以更换为其他人维护的源也有passwall，需要的话自行编译吧！用起来和天灵的固件没啥差异，各取所需吧！ 

Release 通道的版本~~都是~~ 包括 glinet-mt300nv2 和 xiaomi WIFI mini R1C 的固件！

#### 提醒

强烈**不建议**在编译使用xray_core的**同时编译v2ray_core**,除非你有特殊需要，**强烈建议二选一**，不然真的会**偶尔重启**，可能是SFE的锅，但是在没有v2ray_core核心编译的固件中，反复测试 固件稳如老狗！！！

Lede大的固件更新最快最新，编译出来了是21.xx+5.4内核，其余两个为4.1.4内核，内核步伐一致，天灵是18.06，Lieonl是19.07.有DNS加速的SFE速度快了不少！
推荐用天灵的进行编译，稳且快！

 ###                                                                             至此结束折腾！
 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Actions-OpenWrt

#### - 【[Telegram交流群](https://t.me/joinchat/AAAAAE3eOMwEHysw9HMcVQ)】-&nbsp;&nbsp;&nbsp;- 【[Telegram下载](https://telegram.org/)】-&nbsp;&nbsp;&nbsp;- 【[Telegram使用中文方法](https://github.com/danshui-git/shuoming/blob/master/tele.md)】-
#

- 2021月1月26号说明，26号开始插件包取消任何科学上网插件，有需要的请自行拉取《[拉取插件方法](https://github.com/danshui-git/shuoming/blob/master/ming.md)》，如果编译出现错误或者什么情况的，请大家都拉取我的最新仓库使用。

- 弄了一个启动教程视频，mp4格式，存网盘了，需要的自己下载。《[谷歌云](https://drive.google.com/drive/folders/1WEUtVfiVtR5lyG8aX4RcDGdUPV6uMlxt?usp=sharing)》、《[百度（密码：apek）](https://pan.baidu.com/s/1RVi4nN8Y1ak9LTWzhV5bSQ)》、《[微云](https://share.weiyun.com/33SgJdCO)》

- 制作了一个一键重新拉取我编译仓库的脚本，有需要的可以去看看。《[一键重新拉取编译仓库](https://github.com/281677160/sync-forks)》

- 选择Lede_phicomm_n1或Project_phicomm_n1的机型文件夹编译的话，会自动编译出（ N1、微加云、贝壳云、我家云、S9xxx ）OpenWrt固件，固件已经自动打包好【[写入emmc方法](https://github.com/danshui-git/shuoming/blob/master/n1.md)】

- 除了编译 openwrt 机型外，其他机型都直接打入了常用插件了，不需要自己再拉取插件，除非我的插件包跟源码自带的都没有，你就自己添加吧 【[插件包](https://github.com/281677160/openwrt-package)】
#
## 编译说明：
### - 以下的说明教程都是在我另外的仓库的，查看说明时候就跳转到另外仓库了，浏览器回退就会回来，别拉取到我说明的仓库，注意了！
#
- 1、`注册及登录github账号`《[注册链接](https://github.com)》
#
- 2、`拉取我的仓库到你的仓库`《[拉取仓库教程](https://github.com/danshui-git/shuoming/blob/master/1%E6%8B%89%E5%8F%96%E4%BB%93%E5%BA%93.md)》
#
- 3、[必须了解](https://github.com/danshui-git/shuoming/blob/master/%E7%AE%80%E5%8D%95%E4%BB%8B%E7%BB%8D%E6%96%B0%E8%84%9A%E6%9C%AC.md)下脚本的简单介绍《[脚本简单介绍](https://github.com/danshui-git/shuoming/blob/master/%E7%AE%80%E5%8D%95%E4%BB%8B%E7%BB%8D%E6%96%B0%E8%84%9A%E6%9C%AC.md)》
#
- 4、`选择要编译的源码跟机型`《[教程](https://github.com/danshui-git/shuoming/blob/master/%E9%80%89%E6%8B%A9%E6%9C%BA%E5%9E%8B.md)》
#
- 5、设置好要编译的机型后，在build文件夹--你要编译的对应机型文件夹（跟第4步修改的机型一样的文件夹）里的【diy-2.sh】修改登录IP，好等编译完成安装后顺利登录openwrt《[修改ip教程](https://github.com/danshui-git/shuoming/blob/master/ip.md)》
#
- 6、修改好ip后，根据个人需求打开或者关闭各功能，开关控制在build文件夹--你要编译的对应机型文件夹（跟第4步修改的机型一样的文件夹）里的【settings.ini】设置《[各开关控制教程](https://github.com/danshui-git/shuoming/blob/master/kaiguan.md)》
#
- 7、第4、5、6步骤都完成后，就可以启动编译了《[[启动教程](https://github.com/danshui-git/shuoming/blob/master/%E6%89%8B%E5%8A%A8%E5%BC%80%E5%A7%8B.md)]》,启动编译的时候也可以顺手打开SSH连接的，请认真看教程的第一张图片
#
- 8、`SSH远程连接服务器配置固件`《[SSH连接教程](https://github.com/danshui-git/shuoming/blob/master/3SSH%E8%BF%9E%E6%8E%A5%E8%AF%B4%E6%98%8E.md)》，SSH远程默认关闭的，需要打开的请在build文件夹里面的对应机型文件夹的‘settings.ini’设置，或者按钮启动编译的时候顺手打开
#
- 9、`配置固件`《[youtube大神的固件配置视频教程](https://www.youtube.com/watch?v=jEE_J6-4E3Y)》《[恩山大神xtwz整理的插件中文对照](https://www.right.com.cn/forum/thread-3682029-1-1.html)》，《[youtube大神的网卡、无线网卡配置视频教程](https://www.youtube.com/watch?v=X9v6Nd3wxkk)》，放视频在这里只是给大家了解一下怎么选择插件而已，不是叫大家对着视频照着干，千万不要这样做，你就看会什么东西在哪个位置就好了。
#
- 10、`完成编译，下载固件`《[固件下载教程](https://github.com/danshui-git/shuoming/blob/master/4%E5%9B%BA%E4%BB%B6%E4%B8%8B%E8%BD%BD.md)》
#
- 11、`安装固件`，安装固件时出现“Please press Enter to activate this console”就表示安装好了，出现这个就不会跑码的，稍等1分钟就可以进入网页了
- 如果会跑码，就耐心等待跑码完成，应该不需要1分钟就能跑完的
#
- 12、`保存固件配置`，编译固件之前打开‘`SSH连接服器配置固件`’跟‘`上传【.config】配置文件在github空间`’，编译的时候SSH连接服务器修改好插件跟其他应用，编译成功后会有固件跟.config配置文件的，下载.config配置文件后，解压得到一个【config.buildinfo】文件，用记事本打开，把里面的内容都复制，然后覆盖对应机型.config里面原来的内容，这样就会保持你的配置了，下次编译在不修改配置的情况下可以使用定时编译功能，或者手机启动编译，本地提取.config配置文件覆盖进去也可以
#
- 13、
《[定时触发编译说明](https://github.com/danshui-git/shuoming/blob/master/%E5%AE%9A%E6%97%B6%E7%BC%96%E8%AF%91%E8%AF%B4%E6%98%8E.md)》
《[修改跟删除](https://github.com/danshui-git/shuoming/blob/master/%E5%88%A0%E9%99%A4%E5%92%8C%E4%BF%AE%E6%94%B9%E6%96%87%E4%BB%B6.md)》
《[本地提取.config](https://github.com/danshui-git/shuoming/blob/master/%E6%9C%AC%E5%9C%B0%E6%8F%90%E5%8F%96.config.md)》
《[IPV4/IPV6选择](https://github.com/danshui-git/shuoming/blob/master/%E5%85%B6%E4%BB%96%E8%AF%B4%E6%98%8E.md)》
《[固件包减负](https://github.com/danshui-git/shuoming/blob/master/%E5%9B%BA%E4%BB%B6%E6%96%87%E4%BB%B6%E5%A4%B9%E6%95%B4%E7%90%86.md)》
《[banner的说明](https://github.com/danshui-git/shuoming/blob/master/banner%E8%AF%B4%E6%98%8E.md)》
《[patch补丁制作](https://github.com/danshui-git/shuoming/blob/master/buding.md)》
《[NTFS优盘挂载](https://github.com/danshui-git/shuoming/blob/master/ntfs.md)》
《[各种命令的简单介绍](https://github.com/danshui-git/shuoming/blob/master/ming.md)》
《[微信通知跟自动发布固功能密匙获取跟使用教程](https://github.com/danshui-git/shuoming/blob/master/ms.md)》
《[Telegram机器人推送信息教程](https://github.com/danshui-git/shuoming/blob/master/bot.md )》
#
- 14、建议准备梯子一把，虽然云编译不需要梯子，不过你使用SSH连接、下载固件、打开github网页也是需要梯子比较好的（没有也行，比较卡就是）

#
#
- 感谢[coolsnowwolf](https://github.com/coolsnowwolf/lede.git)大神提供的源码
- 感谢[Lienol](https://github.com/Lienol/openwrt.git)大神提供的源码
- 感谢[ctcgfw](https://github.com/project-openwrt/openwrt.git)大神提供的源码
- 感谢[P3TERX](https://github.com/P3TERX/Actions-OpenWrt)大神提供的一键编译脚本
- 感谢[garypang13](https://github.com/garypang13/Actions-OpenWrt)大神提供的一键编译脚本
- 感谢[tuanqing](https://github.com/tuanqing/mknop)大神提供的一键打包脚本
- 感谢[hyird](https://github.com/hyird/Action-Openwrt)大神，是这仁兄告诉我有patch补丁这回事的
- 还有要感谢<a href="#/README.md">World Peace</a>仁兄，这个仁兄是在P3TERX大神的Telegram群认识的，我刚接触云编译时告诉我使用files修改设置的，非常感谢!
- 感谢微软免费提供的编译平台
- 感谢各位大佬提供的各种各样的插件
- 感谢各位帮助过我的人，祝福各位好人一生平安
