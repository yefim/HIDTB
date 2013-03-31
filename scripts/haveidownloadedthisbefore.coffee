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
        notification.show()
