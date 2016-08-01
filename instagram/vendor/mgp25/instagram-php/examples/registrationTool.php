<?php

include __DIR__.'/../vendor/autoload.php';
require_once __DIR__.'/../src/InstagramRegistration.php';

// NOTE: THIS IS A CLI TOOL
/// DEBUG MODE ///
$debug = false;

$r = new \InstagramAPI\InstagramRegistration($debug);

echo "###########################\n";
echo "#                         #\n";
echo "# Instagram Register Tool #\n";
echo "#                         #\n";
echo "###########################\n";

do {
    echo "\n\nUsername: ";
    $username = trim(fgets(STDIN));

    $check = $r->checkUsername($username);
    if ($check['available'] == false) {
        echo "Username $username not available, try with another one\n\n";
    }
} while ($check['available'] == false);

echo "Username $username is available\n\n";

echo "\nPassword: ";
$password = trim(fgets(STDIN));

echo "\nEmail: ";
$email = trim(fgets(STDIN));

$result = $r->createAccount($username, $password, $email);

if (isset($result['account_created']) && ($result['account_created'] == true)) {
    echo 'Your account was successfully created! :)';
}
