chrome.downloads.onCreated.addListener (downloadItem) ->
  chrome.downloads.search
    url: downloadItem.url
    exists: true
    startedBefore: downloadItem.startTime
    , (downloadItems) ->
      if downloadItems.length
        console.log "You've already downloaded this"
      else
        console.log "there are no duplicates"
