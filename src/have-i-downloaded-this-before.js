chrome.downloads.onCreated.addListener(function(item) {
  if (item.exists) {
    chrome.downloads.pause(item.id, function() {
      chrome.notifications.create('hidtb', {
        type: 'basic',
        title: 'You\'ve downloaded this before!',
        iconUrl: '../icon128.png',
        message: 'Do you want to open it?',
        buttons: [
          {title: 'Open'},
          {title: 'Resume'}
        ]
      }, function() {});
    });
  }
});

chrome.notifications.onButtonClicked.addListener(function(notificationId, buttonIndex) {
  console.log(buttonIndex);
});
