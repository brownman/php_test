#!/usr/bin/php -q
<?php
echo "First PHP CLI script\n"; echo exec('ls -l\n') . "\n"; 


echo "hi1\n";
// Example loading an extension based on OS
if (!extension_loaded('sqlite')) {
    if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {

echo "hi2\n";
        dl('php_sqlite.dll');
    } else {


echo "hi3\n";
        dl('sqlite.so');
    }
}

// Or, the PHP_SHLIB_SUFFIX constant is available as of PHP 4.3.0
if (!extension_loaded('sqlite')) {


echo "hi4\n";
    $prefix = (PHP_SHLIB_SUFFIX === 'dll') ? 'php_' : '';
    dl($prefix . 'sqlite.' . PHP_SHLIB_SUFFIX);
}
?>
