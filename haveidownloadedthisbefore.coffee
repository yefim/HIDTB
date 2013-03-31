chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.search
    url: downloadItem.url
    exists: true
    startedBefore: downloadItem.startTime
    , (downloadItems) ->
      if downloadItems.length
        notification = webkitNotifications.createNotification(
          ''
          'duplicate'
          'DUPLICATE DOWNLOAD'
        )
        notification.show()
        previous = downloadItems[0]
        console.log "You've already downloaded this"
        chrome.downloads.erase(id: downloadItem.id)
        chrome.downloads.show(previous.id)
      else
        console.log "there are no duplicates"
