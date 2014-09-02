step1
dh-make-pecl --phpversion 5 --prefix php5- ${name1}-${ver1}.tgz
cd php-${name1}-${ver1}/
./debian/rules binary
dpkg -c ../php5-${name1}_${ver1}-1_i386.deb
dpkg -I ../php5-${name1}_${ver1}-1_i386.deb
popd 
