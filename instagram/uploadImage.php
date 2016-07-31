<?php
include __DIR__.'/vendor/autoload.php';
//require '../src/Instagram.php';
/////// CONFIG ///////
$username = 'klarnatlvtest1';
$password = 'klarnatlvtest2';
$debug = false;
$photo = '/home/pi/day.zip/instagram/osama.jpg';     // path to the photo
$caption = 'testing hello';     // caption
//////////////////////
$i = new \InstagramAPI\Instagram($username, $password, $debug);
try {
    $i->login();
} catch (Exception $e) {
    $e->getMessage();
    exit();
}
try {
    $i->uploadPhoto($photo, $caption);
} catch (Exception $e) {
    echo $e->getMessage();
}
