<?php
use Illuminate\Database\Capsule\Manager as Capsule;

function product_faqs_config()
{
    return [
        "name" => "Product Group FAQs",
        "description" => "Displays FAQs specific to a product group.",
        "version" => "1.0",
        "author" => '<a href="https://arkhost.com">ArkHost</a>',
        "fields" => [
            "admin_directory" => [
                "FriendlyName" => "Admin Directory",
                "Type" => "text",
                "Size" => "25",
                "Description" => "Enter the name of your WHMCS admin directory.",
                "Default" => "admin",
            ],
        ],
    ];
}

function product_faqs_activate()
{
    // Check if table already exists
    if (!Capsule::schema()->hasTable('product_group_faqs')) {
        // Create the table
        Capsule::schema()->create('product_group_faqs', function ($table) {
            $table->increments('id');
            $table->integer('group_id');
            $table->text('question')->collation('utf8mb4_general_ci');
            $table->text('answer')->collation('utf8mb4_general_ci');
            $table->integer('sort_order')->default(0);
            $table->text('language')->collation('utf8mb4_general_ci');
        });
    }

    return [
        'status' => 'success',
        'description' => 'Module activated successfully.'
    ];
}

function product_faqs_deactivate()
{
    return [
        'status' => 'success',
        'description' => 'Module deactivated successfully.'
    ];
}

function product_faqs_output($vars)
{
    $faqToEdit = null;

    if ($_GET['action'] === 'edit') {
        $id = intval($_GET['id']);
        $faqToEdit = Capsule::table('product_group_faqs')->where('id', $id)->first();
    } elseif ($_GET['action'] === 'delete') {
        $id = intval($_GET['id']);
        Capsule::table('product_group_faqs')->where('id', $id)->delete();
    } elseif ($_SERVER['REQUEST_METHOD'] === 'POST' && $_POST['action'] === 'update') {
        Capsule::table('product_group_faqs')->where('id', intval($_POST['id']))->update([
            'question' => $_POST['question'],
            'answer' => $_POST['answer'],
            'language' => $_POST['language'],
            'group_id' => $_POST['group_id']
        ]);
    } elseif ($_SERVER['REQUEST_METHOD'] === 'POST' && $_POST['action'] === 'create') {
        Capsule::table('product_group_faqs')->insert([
            'question' => $_POST['question'],
            'answer' => $_POST['answer'],
            'language' => $_POST['language'],
            'group_id' => $_POST['group_id']
        ]);
    }

    // Fetch the admin folder name and system URL dynamically from the WHMCS configuration
    $adminFolder = $vars['admin_directory'];
    $systemUrl = Capsule::table('tblconfiguration')->where('setting', 'SystemURL')->value('value');

    $faqs = Capsule::table('product_group_faqs')->get();
    $adminUrl = rtrim($systemUrl, '/') . '/' . ltrim($adminFolder, '/');
    $smarty = new Smarty;
    $smarty->caching = false;
    $smarty->compile_dir = $GLOBALS['templates_compiledir'];

    $smarty->assign('faqs', $faqs);
    $smarty->assign('faqToEdit', $faqToEdit);
    $smarty->assign('adminUrl', $adminUrl);
    $smarty->display(__DIR__ . '/templates/admin_faq_manage.tpl');
}
