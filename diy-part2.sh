#!/bin/bash
#


# 修改普通版本dts，适配 112M 大分区 (ubi 分区大小改为 0x7000000)，扩容ubi到0x7000000
sed -i 's/0x4000000/0x7000000/g' target/linux/mediatek/dts/mt7981b-h3c-magic-nx30-pro.dts

# 替换filogic.mk下的IMAGE_SIZE
sed -i '/define Device\/h3c_magic-nx30-pro/,/endef/s/IMAGE_SIZE := .*/IMAGE_SIZE := 114688k/' target/linux/mediatek/image/filogic.mk


# 修改默认LAN IP为192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 设置argon为默认主题
cat > package/base-files/files/etc/uci-defaults/99-set-theme <<EOF
#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-set-theme

# 预置 Zashboard(Nikki Web面板) 静态文件到固件
mkdir -p files/usr/share/zashboard
curl -sL "https://github.com/Zephyruso/zashboard/archive/refs/heads/gh-pages.zip" -o /tmp/ui.zip
unzip -q /tmp/ui.zip -d /tmp/ui_temp
cp -rf /tmp/ui_temp/zashboard-gh-pages/* files/usr/share/zashboard/
rm -rf /tmp/ui.zip /tmp/ui_temp

# ----关键改动：不覆盖整个配置文件，使用uci‑set方式追加参数----
mkdir -p files/etc/config
# 把uci指令打包进固件开机脚本，第一次开机自动设置dashboard_path
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/99-nikki-zashboard <<'EOF'
#!/bin/sh
uci set nikki.main.dashboard_path='/usr/share/zashboard'
uci commit nikki
rm -f /etc/uci-defaults/99-nikki-zashboard
exit 0
EOF
chmod +x files/etc/uci-defaults/99-nikki-zashboard
