// Copyright (c) 2023 Nikita Voronchev <n.voronchev@gmail.com>
// MIT License

function modifyElement(selector, onFound) {
    element = document.querySelector(selector);
    if (element) {
        onFound(element);
    } else {
        console.log("ERROR: Element '" + selector + "' not found");
    }
}

//

function modifyChangesArea(changesAreaElem) {
    changesAreaElem.style.height = "100%";
}

[
    "#pull-requests-container > * div:has(> div.changes)",
    "#main > * div.commit-changes"
].forEach((selector) => modifyElement(selector, modifyChangesArea));

//

function modifySidebar(sidebarElem) {
    sidebarElem.style.width = '15%';
}

[
    "#pull-requests-container > div > div > div > div > div > aside.changes-sidebar",
    "#main > div > div > div > div > aside.changes-sidebar"
].forEach((selector) => modifyElement(selector, modifySidebar));
