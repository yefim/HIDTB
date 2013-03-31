chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.search
    url: downloadItem.url
    exists: true
    startedBefore: downloadItem.startTime
    , (downloadItems) ->
      if downloadItems.length
        notification = webkitNotifications.createHTMLNotification(
          "notification.html?id=#{downloadItem.id}&view=#{downloadItems[0].id}"
        )
        # chrome.downloads.erase(id: downloadItem.id)
        notification.show()
        # previous = downloadItems[0]
        # chrome.downloads.show(previous.id)
