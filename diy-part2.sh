#!/bin/bash
#


# 1. DTS：精准修改 UBI 分区 size 为 0x7000000 (112M)
sed -i 's/reg = <0x3800000 0x[0-9a-fA-F]*>/reg = <0x3800000 0x7000000>/' target/linux/mediatek/dts/mt7981b-h3c-magic-nx30-pro.dts

# 2. 合并操作：限制在 NX30 Pro 区块内，精准修改 IMAGE_SIZE 并安全追加 UBIFS_OPTS 参数
sed -i '/define Device\/h3c_magic-nx30-pro/,/endef/ s/IMAGE_SIZE := .*/IMAGE_SIZE := 114688k\n  UBIFS_OPTS := -m 2048 -e 126976 -c 8800/' target/linux/mediatek/image/filogic.mk


# 修改默认LAN IP为192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 设置argon为默认主题
cat > package/base-files/files/etc/uci-defaults/99-set-theme <<EOF
#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-set-theme



# === 调试校验：打印修改后的 NX30 Pro 镜像打包参数 ===
echo "================ NX30 Pro filogic.mk 校验 ================"
grep -A15 "define Device/h3c_magic-nx30-pro" target/linux/mediatek/image/filogic.mk
echo "=========================================================="
