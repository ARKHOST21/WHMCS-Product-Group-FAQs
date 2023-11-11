# WHMCS Product Group FAQs Module

## Overview

The WHMCS Product Group FAQs Module is a powerful addition to your WHMCS system, allowing you to seamlessly integrate Frequently Asked Questions (FAQs) into your product groups. This module enhances user experience and provides a convenient way for customers to access essential information about your products and services.

## Features

- **Product Group Integration**: Easily associate FAQs with specific product groups, ensuring that customers see relevant information.

- **Multilingual Support**: Manage FAQs in multiple languages, catering to a diverse customer base.

- **Admin Panel Management**: All FAQs and answers can be added, modified, or deleted per language via the intuitive admin panel of the module.

- **User-Friendly Interface**: The module is designed with both administrators and customers in mind, offering a seamless and efficient experience for all users.

## Installation

1. **Extract Files**: Extract *includes/* and *hooks/* to your WHMCS directory.

2. **Module Configuration**: Enable the module within WHMCS and provide the admin URL part for integration.

3. **FAQ Management**: Start managing your FAQs through the admin panel, organizing them by product group and language.

## Integration Instructions
To integrate this feature into your WHMCS system, follow these steps:

1. Place the PHP scripts in the appropriate directory of your WHMCS installation.
2. Modify the `templates/orderforms/your_order_form/products.tpl` file in your WHMCS template by adding the following code at the end of the file:
   ```
   <!-- BEGIN: FAQ Block-->
   <div class="faq-container" data-group-id="{$gid}" data-language="{if isset($_SESSION['Language'])}{$_SESSION['Language']}{else}english{/if}">
       <h1 class="main-heading">{$LANG.orderForm.ProductFaqs}</h1>
       <div id="faq-list"></div>
   </div>
   <script src="/modules/addons/product_faqs/templates/js/faq.js"></script>
   ```

## Support

If you find this module valuable and would like to support its development, consider buying me a coffee. Your support helps maintain and improve this open-source project.

## Support

If you find this project valuable and would like to learn more or get in touch, please visit [arkhost.com](https://www.arkhost.com). Thank you for your interest in our project!

Thank you for choosing the WHMCS Product Group FAQs Module. We hope it enhances your WHMCS experience and benefits your customers.

## Contributing

Contributions to this project are welcome. Feel free to submit pull requests or report issues to help make this module even better for the WHMCS community.
