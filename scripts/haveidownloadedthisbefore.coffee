chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.search
    url: downloadItem.url
    exists: true
    startedBefore: downloadItem.startTime
    , (downloadItems) ->
      if downloadItems.length
        notification = webkitNotifications.createHTMLNotification(
          'notification.html'
        )
        notification.onclick = (e) =>
          console.log e
          chrome.downloads.erase(id: downloadItem.id)
        notification.show()
        previous = downloadItems[0]
        # chrome.downloads.show(previous.id)
