#!/usr/bin/php -q
<?php


echo "pear install Console_CommandLine\n";
require_once 'Console/CommandLine.php';



$parser = new Console_CommandLine();
$parser->description = 'A senseless string processor';
$parser->version = '0.1.0';

$reverseCmd = $parser->addCommand('reverse', array(
        'description' => 'Reverse a string'
)); 

$reverseCmd->addArgument('name', array(
        'description' => 'The string'
)); 

try {

  // Parse the input
  $result = $parser->parse();

  // Generate a new project
  if ($result->command_name == 'reverse') {
    printf("%s
", strrev($result->command->args['name']));
  }

} catch (Exception $e) {

  $parser->displayError($e->getMessage());

}

