#!/usr/local/bin/php

<?php
require('/var/www/html/installation/config_setup.php');

$data = array(
    'db_host' => getenv('DB_HOST'),
    'db_name' => getenv('DB_NAME'),
    'db_user' => getenv('DB_USER'),
    'db_pass' => getenv('DB_PASS')
);

WriteConfig($data, '/var/www/html');

$admin_email = getenv('ADMIN_EMAIL');
$site_name = getenv('SITE_NAME');
$admin_password = getenv('ADMIN_PASSWORD');

$_SESSION = array();
$_SESSION['host_name'] = $data['db_host'];
$_SESSION['username'] = $data['db_user'];
$_SESSION['db_password'] = $data['db_pass'];
$_SESSION['db_name'] = $data['db_name'];

$_SESSION['email'] = $admin_email;
$_SESSION['site_name'] = $site_name;
$_SESSION['password'] = $admin_password;
$_SESSION['directus_path'] = '/';

$abspath = str_replace('\\', '/', dirname( dirname(__FILE__) ) . '/');
$site_url = getenv('SITE_URL') . $_SESSION['directus_path'];
$_SESSION['default_dest'] = $abspath.'media/';
$_SESSION['default_url'] = $site_url.'media/';
$_SESSION['thumb_dest'] = $abspath.'media/thumbs/';
$_SESSION['thumb_url'] = $site_url.'media/thumbs/';
$_SESSION['temp_dest'] = $abspath.'media/temp/';
$_SESSION['temp_url'] = $site_url.'media/temp/';

require('/var/www/html/installation/query.php');
$setupResponse = $main->execute(array('', 'db:setup'));
$migrateResponse = $main->execute(array('', 'db:migrate'));
AddSettings($mysqli);
AddDefaultUser($_SESSION['email'], $_SESSION['password'], $mysqli);
AddStorageAdapters($mysqli);

if (getenv('SAMPLE_DATA')) {
  echo "Installing Sample Data as requested\n";
  InstallSampleData($mysqli);
}

?>
