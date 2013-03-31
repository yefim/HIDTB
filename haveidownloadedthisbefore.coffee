chrome.downloads.onCreated.addListener (downloadItem) ->
  alert 'item is downloading'
  console.log downloadItem
