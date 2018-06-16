var debug = localStorage.getItem('debug') === true

debug && console.log('Binding event handlers...');

chrome.downloads.onCreated.addListener(function(item) {
  console.log(item);

  debug && console.log(item.id);
  debug && console.log(item.exists);

  chrome.downloads.pause(item.id, function() {
    chrome.downloads.search({url item.url, exists: true}, function(items) {
      if (items.length) {
        chrome.notifications.create(['hidtb', items[0].id].join('|||'), {
          type: 'basic',
          title: 'You\'ve downloaded this before!',
          iconUrl: '../icon128.png',
          message: 'Click to open file'
        }, function() {});
      } else {
        chrome.downloads.resume(item.id);
      }
    });
  });
});

chrome.notifications.onClicked.addListener(function(notificationId) {
  debug && console.log(notificationId);

  var id = parseInt(notificationId.split('|||').pop(), 10);
  chrome.downloads.open(id);
});
