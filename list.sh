download_pecl_package
dh-make-pecl
dh-make-pecl1
cd php*-${name1}-${ver1}/
tree
cat1 debian/control 
head -10 debian/rules
fakeroot ./debian/rules binary
dpkg -c ../php5-${name1}_${ver1}-1_${arch_local}.deb
dpkg -I ../php5-${name1}_${ver1}-1_${arch_local}.deb
ls ../*.deb
mv ../*.deb $dir_self/release





ls $dir_self


mv $dir_parent/*.deb $dir_parent/release

mv /tmp/1 /tmp/$(date +%s)

dpkg-buildpackage -rfakeroot

pwd

echo sed -i 's/any/amd64/1' debian/control

#later2
echo 'Install PHP-SSH2 ( php-ssh ) extension'
echo Install Build Dependancies
apt-get install libssh2-1 libssh2-1-dev
echo Download ssh2 files
cd /tmp
wget http://pecl.php.net/get/ssh2-0.12.tgz
tar -zxvf ssh2-0.12.tgz
echo Compile and Install
cd ssh2-0.12
phpize
./configure --with-ssh2
make && make install
Configure php-ssh2
echo -e "\n\n[php-ssh2]\n;http://pecl.php.net/package/ssh2\nextension=ssh2.so\n\n" >> /etc/php5/mods-available/ssh2.ini
echo Enable php-ssh2
ln -s /etc/php5/mods-available/ssh2.ini /etc/php5/conf.d/20-ssh2.ini
echo Restart PHP5-fpm to apply the config
service php5-fpm restart

