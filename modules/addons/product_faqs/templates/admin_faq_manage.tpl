<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage FAQs</title>
    <style>
    .faq-management { font-family: Arial, sans-serif; background-color: #f5f5f5; margin: 0; padding: 20px; }
    .faq-management h2, .faq-management h3 {
        background-color: #1a4d80; /* Main ArkHost Color */
        color: #fff;
        padding: 10px;
        border-radius: 3px;
        text-align: center;
    }
    .faq-management table { border-collapse: collapse; width: 100%; background-color: #fff; margin-top: 20px; }
    .faq-management th, .faq-management td { border: 1px solid #ddd; padding: 10px; text-align: left; }
    .faq-management th { background-color: #1a4d80; color: white; } /* Main ArkHost Color */
    .faq-management tr:hover { background-color: #f5f5f5; }
    .faq-management a { color: #0C9FED; text-decoration: none; } /* Lighter ArkHost Color */
    .faq-management a:hover { text-decoration: underline; color: #1a4d80 ; } /* Main ArkHost Color */
    .faq-management form { background-color: #fff; padding: 20px; border-radius: 5px; box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1); margin-bottom: 20px; }
    .faq-management input[type="text"], .faq-management textarea {
        width: 100%; padding: 10px; margin: 5px 0; border: 1px solid #ddd; border-radius: 3px;
    }
    .faq-management input[type="submit"] {
        background-color: #4CAF50; color: #fff; border: none; padding: 10px 20px; border-radius: 3px; cursor: pointer;
    }
    .faq-management input[type="submit"]:hover { background-color: #4CAF50; }
    
    /* Tooltip styles */
    [data-tooltip] {
        position: relative;
        cursor: pointer;
        text-decoration: underline;
        color: #3A4C6B; /* Lighter ArkHost Color */
    }
    [data-tooltip]::before, [data-tooltip]::after {
        position: absolute;
        visibility: hidden;
        opacity: 0;
        left: 50%;
        pointer-events: none;
        transform: translateX(-50%);
        transition: all 0.3s;
        z-index: 100;
    }
    [data-tooltip]::before {
        content: attr(data-tooltip);
        bottom: 120%;
        background-color: #555;
        color: #fff;
        padding: 5px;
        border-radius: 5px;
        white-space: nowrap;
        font-size: 12px;
    }
    [data-tooltip]::after {
        content: '';
        bottom: 110%;
        border-width: 5px;
        border-style: solid;
        border-color: #555 transparent transparent transparent;
    }
    [data-tooltip]:hover::before, [data-tooltip]:hover::after {
        visibility: visible;
        opacity: 1;
    }

    /* Pagination styles */
    .pagination {
        text-align: center;
        margin-top: 20px;
    }
    .pagination a {
        color: #3A4C6B; /* Lighter ArkHost Color */
        text-decoration: none;
        padding: 5px 10px;
        margin: 0 5px;
        border: 1px solid #ddd;
        border-radius: 3px;
    }
    .pagination a:hover {
        background-color: #f5f5f5;
    }
    /* Style for the Cancel button */
    .cancel-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #d9534f; /* Red color */
        color: #fff; /* White text color */
        text-decoration: none;
        border-radius: 3px;
        transition: background-color 0.3s;
    }
    .cancel-button:hover {
        background-color: #c9302c; /* Darker red color on hover */
    }
    .cancel-button {
        text-decoration: none !important; /* Remove underline */
        color: #fff; /* Set text color to white */
    }
    .cancel-button,
    .cancel-button:hover,
    .cancel-button:active,
    .cancel-button:focus {
        color: #fff !important; /* Set text color to white */
    }

</style>

</head>
<body>

<div class="faq-management">
    <h2>📚 FAQ Management</h2>

    {if $faqToEdit}
    <h3>🔄 Update Existing FAQ</h3>
    <!-- Edit FAQ form -->
    <form method="post" action="{$adminUrl}/addonmodules.php?module=product_faqs">
        <input type="hidden" name="id" value="{$faqToEdit->id}">
        <label for="question"><i class="fas fa-question-circle"></i> Question:</label><br>
        <input type="text" name="question" value="{$faqToEdit->question}" required><br><br>
        <label for="answer"><i class="fas fa-reply"></i> Answer:</label><br>
        <textarea name="answer" required>{$faqToEdit->answer}</textarea><br><br>
        <label for="language"><i class="fas fa-globe"></i> Language:</label><br>
        <input type="text" name="language" value="{$faqToEdit->language}" required><br><br>
        <label for="group_id"><i class="fas fa-tag"></i> Product Group ID:</label><br>
        <input type="text" name="group_id" value="{$faqToEdit->group_id}" required><br><br>
        <input type="hidden" name="action" value="update">
        <input type="submit" value="Update FAQ">
        
        <!-- Cancel button -->
        <a href="{$adminUrl}/addonmodules.php?module=product_faqs" class="cancel-button">Cancel</a>
    </form>
    {else}
    <h3>➕ Add New FAQ</h3>
        <!-- Add New FAQ form -->
    <form method="post" action="{$adminUrl}/addonmodules.php?module=product_faqs">
        <label for="question"><i class="fas fa-question-circle"></i> Question:</label><br>
        <input type="text" name="question" required><br><br>
        <label for="answer"><i class="fas fa-reply"></i> Answer:</label><br>
        <textarea name="answer" required></textarea><br><br>
        <label for="language"><i class="fas fa-globe"></i> Language (<span data-tooltip="Use lowercase like 'english' or 'dutch'">info</span>):</label><br>
        <input type="text" name="language" required><br><br>
        <label for="group_id"><i class="fas fa-tag"></i> Product Group ID (<span data-tooltip="The product group ID can be found on the WHMCS admin product page">where?</span>):</label><br>
        <input type="text" name="group_id" required><br><br>
        <input type="hidden" name="action" value="create">
        <input type="submit" value="Add FAQ">
    </form>
    {/if}
    <!-- Search Input -->
    <input type="text" id="faqSearch" onkeyup="filterFAQs()" placeholder="Search FAQs...">
    
    <!-- Pagination -->
    <div class="pagination" id="paginationTop"></div>

    <!-- Display the FAQs table -->
    <table>
        <tr>
            <th>Question</th>
            <th>Answer</th>
            <th>Language</th>
            <th>Group ID</th>
            <th>Actions</th>
        </tr>
        {foreach $faqs as $faq}
            <tr>
                <td>{$faq->question}</td>
                <td>{$faq->answer}</td>
                <td>{$faq->language}</td>
                <td>{$faq->group_id}</td>
                <td>
                    <a href="{$adminUrl}/addonmodules.php?module=product_faqs&action=edit&id={$faq->id}">Edit</a> | 
                    <a href="{$adminUrl}/addonmodules.php?module=product_faqs&action=delete&id={$faq->id}" onclick="return confirm('Are you sure you want to delete this FAQ?');">Delete</a>
                </td>
            </tr>
        {/foreach}
    </table>
    
    <!-- Pagination -->
    <div class="pagination" id="paginationBottom"></div>
    <!-- Centered div -->
    <div style="text-align: center; margin-top: 20px;">
        Made with ❤️ and ☕.<br>
        by <a href="https://arkhost.com">ArkHost</a>
    </div>
</div>
<script>
    function filterFAQs() {
        const input = document.getElementById('faqSearch');
        const filter = input.value.toUpperCase();
        const table = document.querySelector('.faq-management table');
        const tr = table.getElementsByTagName('tr');

        // Loop through all table rows and hide those that don't match the search query
        for (let i = 1; i < tr.length; i++) {
            let showRow = false;
            const td = tr[i].getElementsByTagName('td');
            for (let j = 0; j < td.length; j++) {
                if (td[j]) {
                    const txtValue = td[j].textContent || td[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        showRow = true;
                        break;
                    }
                }
            }
            tr[i].style.display = showRow ? '' : 'none';
        }
    }
</script>
<script>
    // Number of FAQs per page
    const faqsPerPage = 10;

    // Current page
    let currentPage = 1;

    // Function to display FAQs for the current page
    function displayFAQsForPage(page) {
        const table = document.querySelector('.faq-management table');
        const tr = table.getElementsByTagName('tr');

        // Calculate the range of FAQs to display
        const startIdx = (page - 1) * faqsPerPage;
        const endIdx = startIdx + faqsPerPage;

        // Loop through all table rows and hide/show based on the current page
        for (let i = 1; i < tr.length; i++) {
            tr[i].style.display = (i > startIdx && i <= endIdx) ? '' : 'none';
        }
    }

    // Function to generate and update pagination controls
    function updatePagination() {
        const numFAQs = document.querySelectorAll('.faq-management table tr').length - 1;
        const numPages = Math.ceil(numFAQs / faqsPerPage);

        const paginationTop = document.getElementById('paginationTop');
        const paginationBottom = document.getElementById('paginationBottom');
        let paginationHTML = '';

        // Generate pagination links
        for (let i = 1; i <= numPages; i++) {
            paginationHTML += '<a href="#" onclick="changePage(' + i + ')">' + i + '</a> ';
        }

        paginationTop.innerHTML = paginationHTML;
        paginationBottom.innerHTML = paginationHTML;

        // Display FAQs for the current page
        displayFAQsForPage(currentPage);
    }

    // Function to change the current page
    function changePage(page) {
        currentPage = page;
        displayFAQsForPage(currentPage);
        updatePagination();
    }

    // Initial update of pagination controls
    updatePagination();
</script>

</body>
</html>
