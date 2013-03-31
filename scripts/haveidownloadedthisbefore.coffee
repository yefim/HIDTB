chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.search
    url: downloadItem.url
    exists: true
    startedBefore: downloadItem.startTime
    , (downloadItems) ->
      if downloadItems.length
        previous = downloadItems[0]
        #url = escape downloadItem.url
        view_id = previous.id
        notification = webkitNotifications.createHTMLNotification(
          "notification.html?id=#{downloadItem.id}&view=#{view_id}"
        )
        notification.show()
