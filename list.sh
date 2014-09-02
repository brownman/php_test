step1
dh-make-pecl --phpversion 5 --prefix php5- ${name1}-${ver1}.tgz
cd php5-${name1}-${ver1}/
fakeroot ./debian/rules binary
dpkg -c ../php5-${name1}_${ver1}-1_${arch}.deb
dpkg -I ../php5-${name1}_${ver1}-1_${arch}.deb
