php test
-----
- god bless

[![Build Status](https://travis-ci.org/brownman/php_test.svg?branch=master)](https://travis-ci.org/brownman/php_test)



release
-----
(deb amd64)[./release/amd64.deb]
(deb i386)[./release/i386.deb]

steps
-----
```
#visit:
#http://www.mabishu.com/blog/2011/03/20/how-to-easily-create-debian-packages-for-php-extensions/

apt-cache search php ssh2

apt-get source libssh2-php
#found: libssh2-php - PHP Bindings for libssh2

apt-cache search dh_make
#found: pkg-php-tools - various packaging tools and scripts for PHP PEAR packages

#searching after a diff tool:
#http://www.commandlinefu.com/commands/matching/diff/ZGlmZg==/sort-by-votes
#found a nice command: diff -r -u $dir1 $dir2 > $file

#cheating :) $dir1/debian $dir2/debian > result.patch
#found:
+Source: php-ssh2
+Section: devel
+Priority: extra
+Maintainer: Martin Meredith <mez@debian.org>
+Uploaders: Lior Kaplan <kaplan@debian.org>
+Build-Depends: debhelper (>= 7), php5-dev, libssh2-1-dev, libtool
+Standards-Version: 3.9.4
+Homepage: http://pecl.php.net/package/ssh2
-Package: php5-ssh2
+Package: libssh2-php

```

[demo](http://asciinema.org/a/11943)
