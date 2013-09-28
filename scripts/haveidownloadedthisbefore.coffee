# make notification id a JSON of id and view_id
chrome.notifications.onClosed.addListener (n_id) ->
  chrome.downloads.resume parseInt(n_id, 10)

chrome.downloads.onCreated.addListener (downloadItem) ->
  console.log downloadItem.url
  id = downloadItem.id
  chrome.downloads.pause id, ->
    chrome.downloads.search
      url: downloadItem.url
      , (downloadItems) ->
        console.log downloadItems
        if downloadItems.length
          previous = downloadItems[0]
          url = escape downloadItem.url
          view_id = previous.id
          opts =
            title: "You Have Already Downloaded This!"
            message: url
            iconUrl: "icon48.png"
            buttons: [
              {title: "Open File"}
              {title: "Resume Download"}
            ]
          chrome.notifications.create "" + id, opts, ->
        else
          chrome.downloads.resume id
