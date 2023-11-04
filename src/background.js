// Copyright (c) 2023 Nikita Voronchev <n.voronchev@gmail.com>
// MIT License

chrome.action.onClicked.addListener((tab) => {
    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      files: ['content.js']
    });
  });