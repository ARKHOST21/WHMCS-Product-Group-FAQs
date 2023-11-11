document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM is fully loaded.");

    // Get the FAQ container
    let container = document.querySelector(".faq-container");

    if (container) {
        let groupId = container.getAttribute("data-group-id");

        // Determine language
        let language = getLanguage();

        let apiUrl = `/modules/addons/product_faqs/faq_api.php?group_id=${groupId}&language=${language}`;
        
        console.log("API URL:", apiUrl);

        fetch(apiUrl)
            .then((response) => response.json())
            .then((data) => {
                console.log("Data:", data);
                displayFaqs(data.data);
                setupClickHandlers(); // Call the function to set up click handlers
            })
            .catch((error) => {
                console.error("Error fetching FAQs:", error);
            });
    }
});

function getLanguage() {
    // 1. Check the URL
    let urlParams = new URLSearchParams(window.location.search);
    let urlLanguage = urlParams.get("language");
    if (urlLanguage) {
        localStorage.setItem('userLanguage', urlLanguage);  // Save to local storage
        return urlLanguage;
    }

    // 2. If not found in the URL, check local storage
    let storedLanguage = localStorage.getItem('userLanguage');
    if (storedLanguage) return storedLanguage;

    // 3. If not found in local storage, retrieve the language from the WHMCS session cookie
    let sessionLanguage = getSessionLanguage();
    if (sessionLanguage) return sessionLanguage;

    // 4. Default to English
    return "english";
}


function getSessionLanguage() {
    let cookies = document.cookie.split(';');
    for (let cookie of cookies) {
        let parts = cookie.trim().split('=');
        if (parts[0] === "WHMCSUserLanguage") {
            return parts[1];
        }
    }
    return null; // Return null if the session language is not found
}

function displayFaqs(faqs) {
    let container = document.querySelector(".faq-container");

    if (!container) {
        console.error("FAQ container not found!");
        return;
    }

    // Clear existing content, except the main heading
    let mainHeading = container.querySelector(".main-heading");
    container.innerHTML = '';
    container.appendChild(mainHeading);

    faqs.forEach((faq) => {
        let faqItem = `
            <div class="faq-item">
                <h3 class="faq-question">${faq.question}</h3>
                <p class="faq-answer">${faq.answer}</p>
            </div>
        `;

        container.innerHTML += faqItem;
    });
}

function setupClickHandlers() {
    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach((faq) => {
        const question = faq.querySelector('.faq-question');
        const answer = faq.querySelector('.faq-answer');
        faq.addEventListener('click', () => {
            if (answer.style.display === '' || answer.style.display === 'none') {
                answer.style.display = 'block';
            } else {
                answer.style.display = 'none';
            }
        });
    });
}