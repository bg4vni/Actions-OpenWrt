#!/bin/bash
#
# 1. 添加 Nikki 官方软件源
echo 'src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main' >> feeds.conf.default

# 拉取 PassWall 2 主插件与依赖包 (Openwrt-Passwall 官方新仓库)
#git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall
#git clone https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/passwall2


# 2. 添加 PassWall 2 官方源（通过 feeds 机制拉取，会自动匹配系统依赖）
echo 'src-git passwall_dep https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' >> feeds.conf.default
echo 'src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main' >> feeds.conf.default
