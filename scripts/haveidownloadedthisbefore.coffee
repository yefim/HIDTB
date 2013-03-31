chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.pause downloadItem.id, ->
    chrome.downloads.search
      url: downloadItem.url
      exists: true
      startedBefore: downloadItem.startTime
      state: "complete"
      , (downloadItems) ->
        if downloadItems.length
          previous = downloadItems[0]
          url = escape downloadItem.url
          view_id = previous.id
          notification = webkitNotifications.createHTMLNotification(
            "notification.html?id=#{downloadItem.id}&view=#{view_id}&url=#{url}"
          )
          notification.show()
        else
          chrome.downloads.resume downloadItem.id
