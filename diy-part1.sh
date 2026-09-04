#!/bin/bash
#
# 1. 添加 Nikki 官方软件源
echo 'src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main' >> feeds.conf.default




# 2. 添加 PassWall 2 官方源（通过 feeds 机制拉取，会自动匹配系统依赖）
echo 'src-git passwall_dep https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' >> feeds.conf.default
echo 'src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main' >> feeds.conf.default


#imm里面添加源：
# 1. 将 SourceForge 上的三个文件夹依次添加至 OPKG 配置文件
#cat << 'EOF' >> /etc/opkg/customfeeds.conf
#src/gz passwall_packages https://sourceforge.net/projects/openwrt-passwall-build/files/releases/packages-24.10/aarch64_cortex-a72/passwall_packages/
#src/gz passwall2 https://sourceforge.net/projects/openwrt-passwall-build/files/releases/packages-24.10/aarch64_cortex-a72/passwall2/
#src/gz passwall_luci https://sourceforge.net/projects/openwrt-passwall-build/files/releases/packages-24.10/aarch64_cortex-a72/passwall_luci/
#EOF
# 2. 关闭签名校验 (防止第三方源签名报错)
#sed -i 's/option check_signature/# option check_signature/' /etc/opkg.conf
