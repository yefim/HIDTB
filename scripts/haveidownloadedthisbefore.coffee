notificationOptions =
  type: 'basic'
  iconUrl: '../icon128.png'
  title: 'You have already downloaded this!'
  message: ''
  buttons: [{title: 'Open File', iconUrl: '../open.png'}, {title: 'Resume Download', iconUrl: '../resume.png'}]

chrome.notifications.onButtonClicked.addListener (notificationId, buttonIndex) ->
  [currentDownloadId, previousDownloadId] = notificationId.split('|').map (id) -> parseInt(id, 10)
  switch buttonIndex
    when 0
      chrome.downloads.erase {id: currentDownloadId}
      chrome.downloads.open previousDownloadId
    when 1
      try
        chrome.downloads.resume currentDownloadId
      catch e
        # pass

chrome.notifications.onClicked.addListener (notificationId) ->
  [currentDownloadId, _] = notificationId.split('|').map (id) -> parseInt(id, 10)
  try
    chrome.downloads.resume currentDownloadId
  catch e
    # pass

chrome.notifications.onClosed.addListener (notificationId) ->
  [currentDownloadId, _] = notificationId.split('|').map (id) -> parseInt(id, 10)
  try
    chrome.downloads.resume currentDownloadId
  catch e
    # pass

chrome.downloads.onCreated.addListener (downloadItem) ->
  startTime = new Date(downloadItem.startTime)
  # Only consider recent downloads
  return if startTime < Date.now() - (5*60*1000)
  id = downloadItem.id
  query =
    url: downloadItem.url
    exists: true
    state: 'complete'
  chrome.downloads.pause id, ->
    chrome.downloads.search query, (downloadItems) ->
      if downloadItems.length
        previous = downloadItems[0]
        notificationId = id + '|' + previous.id
        notificationOptions.message = downloadItem.url or ''
        chrome.notifications.create notificationId, notificationOptions, (->)
      else
        chrome.downloads.resume id
