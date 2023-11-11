<?php

use WHMCS\Database\Capsule;
use WHMCS\View\Menu\Item as MenuItem;

add_hook('ClientAreaPage', 1, function($vars) {
    // Get the current language from WHMCS
    $currentLanguage = $vars['language'];

    // Check if the current URL contains '/store'
    if (strpos($_SERVER['REQUEST_URI'], '/store') !== false) {
        // Check if the 'language' GET parameter is set
        if (isset($_GET['language'])) {
            // Update the cookie if the language parameter is different from the current language
            if ($_GET['language'] != $currentLanguage) {
                setcookie('WHMCSUserLanguage', $_GET['language'], time() + (86400 * 30), "/");
                $currentLanguage = $_GET['language'];
            }
        } else {
            // If 'language' GET parameter is not set, try to get the language from the cookie
            if (isset($_COOKIE['WHMCSUserLanguage'])) {
                $currentLanguage = $_COOKIE['WHMCSUserLanguage'];
            }
        }
        // Update the language of the FAQs for the current Product Group page
        if ($currentLanguage) {
            $groupId = ...;  // Retrieve the group ID from the URL or elsewhere
            Capsule::table('product_group_faqs')
                ->where('group_id', $groupId)
                ->update(['language' => $currentLanguage]);
        }
    }
});

?>

