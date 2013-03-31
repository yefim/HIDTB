chrome.downloads.onCreated.addListener (downloadItem) ->
  id = downloadItem.id
  chrome.downloads.pause id, ->
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
            "notification.html?id=#{id}&view=#{view_id}&url=#{url}"
          )
          notification.onclose = ->
            chrome.downloads.resume id
          notification.show()
        else
          chrome.downloads.resume id
