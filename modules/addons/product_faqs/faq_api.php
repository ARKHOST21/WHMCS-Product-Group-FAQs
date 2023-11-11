<?php
use WHMCS\Database\Capsule;

require_once realpath(dirname(__FILE__)) . '/../../../init.php';

$group_id = isset($_GET['group_id']) ? intval($_GET['group_id']) : null;
$language = isset($_GET['language']) ? $_GET['language'] : 'english';

$response = [];

if ($group_id !== null) {
    $faqs = Capsule::table('product_group_faqs')
        ->where('group_id', $group_id)
        ->where('language', $language)
        ->orderBy('sort_order', 'asc')
        ->get();

    if ($faqs) {
        $response['data'] = $faqs;
    } else {
        $response['error'] = "No FAQs found for group_id $group_id and language $language";
    }
} else {
    $response['error'] = "No group ID provided.";
}

header('Content-Type: application/json');
echo json_encode($response);
?>
