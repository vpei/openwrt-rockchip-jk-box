#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/openwrt/openwrt / Branch: main
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add autocore support for armvirt
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='official'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# Modify default root's password（FROM 'password'[$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.] CHANGE TO 'your password'）
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
# sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$.q1gt4pK$9FjAkAv7TvFUyZYwWK8Td0:18923:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# 添加xray-core trojan-go sing-box
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go

sed -i 's/24.12.18/24.12.28/g' feeds/packages/net/xray-core/Makefile
sed -i 's/3d8b4a161a263e7af7bb1a2690961da075d13f980acd806f5cd4e5c8338d7534/9e7e14ac1da5aac22382b485bb2af3bbef07dc5e3b583e464c479f8f0f06b2d5/g' feeds/packages/net/xray-core/Makefile

sed -i 's/1.9.7/1.10.5/g' feeds/packages/net/sing-box/Makefile
sed -i 's/5b015352f3434bb780af01a6b1f6c0fe706166d6c44a69547e29892f0920b944/ca0385b45d160c2c2a1d0e09665f4f04caac27cb3dd9d6132173316dfd873b75/g' feeds/packages/net/sing-box/Makefile

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages

# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# 删除docker无脑初始化教程
# sed -i '31,39d' package/lean/luci-app-docker/po/zh-cn/docker.po
# rm -rf lean/luci-app-docker/root/www

# 自定义miniupnpd miniupnpd-2.2.2-2, 包中已包含
# rm -rf feeds/packages/net/miniupnpd

# mv ../files ./files && rm -rf files/kuaicdn/res && mkdir files/kuaicdn/res && wget --no-check-certificate -qO files/kuaicdn/res/ipes-linux-arm64-llc-latest.tar.gz 'https://ipes-tus.iqiyi.com/update/ipes-linux-arm64-llc-latest.tar.gz' && mkdir files/kuaicdn/app && tar -zxvf files/kuaicdn/res/ipes-linux-arm64-llc-latest.tar.gz -C files/kuaicdn/app && chmod 7777 files/kuaicdn -R
# rm -rf files/kuaicdn/res && mkdir files/kuaicdn/res && wget --no-check-certificate -qO files/kuaicdn/res/ipes-linux-arm64-llc-latest.tar.gz 'https://ipes-tus.iqiyi.com/update/ipes-linux-arm64-llc-latest.tar.gz' && mkdir files/kuaicdn/app && tar -zxvf files/kuaicdn/res/ipes-linux-arm64-llc-latest.tar.gz -C files/kuaicdn/app && chmod 7777 files/kuaicdn -R
rm -rf files/kuaicdn/res && mkdir files/kuaicdn/res && wget --no-check-certificate --tries=3 --timeout=10 https://ipes-tus.iqiyi.com/update/ipes-linux-arm64-llc-latest.tar.gz -qO files/kuaicdn/res/ipes-linux-arm64-llc-latest.tar.gz && mkdir files/kuaicdn/app && tar -zxvf files/kuaicdn/res/ipes-linux-arm64-llc-latest.tar.gz -C files/kuaicdn/app && chmod 7777 files/kuaicdn -R

# 修改KuaiPan数据盘位置或添加位置
sed -i 's#\\/data\\/storage\\/#\\/mnt\\/sda1\\/#' files/kuaicdn/app/ipes/var/db/ipes/happ-conf/custom.yml
# echo -e "args:\n - '/tmp/data1'\n - '/tmp/data1'" > ipes/var/db/ipes/happ-conf/custom.yml

# Add third-party software packages (The entire repository)
git clone https://github.com/vpei/vpe01.git package/vpei

# Add luci-app-amlogic
rm -rf package/luci-app-amlogic
git clone https://github.com/vpei/luci-app-amlogic.git package/luci-app-amlogic

# 生成快捷方式
# ln -s /mnt/sda3/clash/config.yaml files/www/config.yaml
# ln -s /mnt/sda3/clash/bak/config.yaml files/www/clash.yaml

# ln -s /mnt/sda3/clash/config.yaml files/www/www2/config.yaml
# ln -s /mnt/sda3/clash/bak/config.yaml files/www/www2/clash.yaml

#
# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------
