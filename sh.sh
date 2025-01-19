# git pull && sh sh.sh

#删除docker无脑初始化教程
# sed -i '31,39d' package/lean/luci-app-docker/po/zh-cn/docker.po
# rm -rf lean/luci-app-docker/root/www

# cd ./luci-app-openclash
# svn update
# cd ../

#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-passwall luci-app-passwall
#cd ./luci-app-passwall
#svn update
#cd ../

# cd ./luci-app-openclash
# svn update
# cd ../

git pull && git add -A && git commit -am "Initial commit" && git push





git clone https://github.com/ophub/amlogic-s9xxx-openwrt

sudo ./make -b s905d -k 6.1.54_5.4.183

cd ./lede-sdb/amlogic-s9xxx-openwrt/


sudo ./make -b s905d -k 6.1.55


sed -i 's#usr www#$usr www kuaicdn#' amlogic-s9xxx/common-files/files/usr/sbin/openwrt-install-amlogic
sed -i 's#usr www kuaicdn kuaicdn#$usr www kuaicdn#' amlogic-s9xxx/common-files/files/usr/sbin/openwrt-install-amlogic



sed -i 's/20ea8a4b-f0bc-8e13-3288-02550e922882/'"${uuid}"'/g' /boot/grub/grub.cfg

chmod 7777 -R ../amlogic-s9xxx-openwrt
rm -R ./out


git clone https://github.com/ophub/kernel


svn co svn://svn.dd-wrt.com/DD-WRT ./DD-WRT
