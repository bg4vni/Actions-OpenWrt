#!/bin/bash
#
# 1. 添加 Nikki 官方软件源
echo 'src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main' >> feeds.conf.default

# 拉取 PassWall 2 主插件与依赖包 (Openwrt-Passwall 官方新仓库)
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall
git clone https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/passwall2
