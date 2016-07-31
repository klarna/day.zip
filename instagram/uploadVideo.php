<?php
include __DIR__.'/vendor/autoload.php';
//require '../src/Instagram.php';
/////// CONFIG ///////
$username = 'klarnatlvtest1';
$password = 'klarnatlvtest2';
$debug = false;
$video = '/home/pi/day.zip/instagram/sample-video.mp4';     // path to the photo
$caption = 'video!';     // caption
//////////////////////
$i = new \InstagramAPI\Instagram($username, $password, $debug);
try {
    $i->login();
} catch (Exception $e) {
    $e->getMessage();
    exit();
}
try {
    $i->uploadVideo($video, $caption);
} catch (Exception $e) {
    echo $e->getMessage();
}
