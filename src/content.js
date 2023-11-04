// Copyright (c) 2023 Nikita Voronchev <n.voronchev@gmail.com>
// MIT License

function modifyElement(selector, lonOnNotFound, onFound) {
    element = document.querySelector(selector);
    if (element) {
        onFound(element);
    } else if (lonOnNotFound) {
        console.log("ERROR: Element '" + selector + "' not found");
    }
}

modifyElement("#header", false, (element) => {
    element.hidden = !element.hidden;
});

modifyElement("#pull-requests-container > header", false, (element) => {
    element.hidden = !element.hidden;
});

modifyElement("#pull-requests-container > * div:has(> div.changes)", true, (element) => {
    element.style.height = "";
});

modifyElement("#pull-requests-container > * div.change-view", true, (element) => {
    if (!element.style.marginTop) {
        element.style.marginTop = "-" + element.getBoundingClientRect().top + "px";
    } else {
        element.style.marginTop = "";
    }
});

modifyElement("#pull-requests-container > div > div > div > div > div > aside.changes-sidebar", true, (element) => {
    element.style.width = '15%'
});
