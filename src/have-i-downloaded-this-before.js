var debug = localStorage.getItem('debug') === 'true';
var noop = function() {};
var id = {
  serialize: function(downloadId) {
    return ['hidbt', downloadId].join('|||');
  },
  parse: function(notificationId) {
    return parseInt(notificationId.split('|||').pop(), 10);
  }
};

debug && console.log('Binding event handlers...');

// Once a user starts downloading a file
chrome.downloads.onCreated.addListener(function(item) {
  // Pause the download
  chrome.downloads.pause(item.id, function() {
    // Check if the download already exists
    chrome.downloads.search({url: item.url, state: 'complete', exists: true}, function(items) {
      if (items.length) {
        // If it exists, prompt the user to open
        chrome.notifications.create(id.serialize(items[0].id), {
          type: 'basic',
          title: 'You\'ve downloaded this before!',
          iconUrl: '../icon128.png',
          message: 'Click to open file. Close to resume download.'
        }, noop);
      } else {
        // Otherwise, resume the new download
        chrome.downloads.resume(item.id);
      }
    });
  });
});

chrome.notifications.onClicked.addListener(function(notificationId) {
  debug && console.log(notificationId);

  chrome.downloads.open(id.parse(notificationId));
  chrome.notifications.clear(notificationId, noop);
});

chrome.notifications.onClosed.addListener(function(notificationId, byUser) {
  debug && console.log('byUser:', byUser);
  chrome.downloads.resume(id.parse(notificationId));
});
