chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.search
    url: downloadItem.url
    exists: true
    startedBefore: downloadItem.startTime
    , (downloadItems) ->
      if downloadItems.length
        notification = webkitNotifications.createNotification(
          ""
          "Duplicate Found!"
          "You've already downloaded #{downloadItem.url}. Click to delete"
        )
        notification.onclick = ->
          chrome.downloads.erase(id: downloadItem.id)
        notification.show()
        previous = downloadItems[0]
        console.log previous
        # chrome.downloads.show(previous.id)
