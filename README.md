php test
-----
- god bless

[![Build Status](https://travis-ci.org/brownman/php_test.svg?branch=master)](https://travis-ci.org/brownman/php_test)



release
-----
(deb amd64)[./release/amd64.deb]
(deb i386)[./release/i386.deb]

Summary
====

```
#visit:
#http://www.mabishu.com/blog/2011/03/20/how-to-easily-create-debian-packages-for-php-extensions/

#query:
apt-cache search php ssh2
#found:
#libssh2-php - PHP Bindings for libssh2
run:
apt-get source libssh2-php

query:
apt-cache search dh_make
#found: pkg-php-tools - various packaging tools and scripts for PHP PEAR packages

#query:
#searching after a diff tool:
#visit:
#http://www.commandlinefu.com/commands/matching/diff/ZGlmZg==/sort-by-votes
#found:
#diff -r -u $dir1 $dir2 > $file
#I try to find the differents between the code generated with dh-make-pecl and the package: libssh2-php
#results:
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
#so I updated the parameters sent to dh-make-pecl with those details.
#..and build the .deb package.

```

[demo](http://asciinema.org/a/12010)
