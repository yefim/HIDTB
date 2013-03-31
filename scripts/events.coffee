window.onload = ->
  query = window.location.search.substring(1)
  [_, id, view_id] = query.match /id=(\d+)&view=(\d+)/
  id = parseInt id, 10
  view_id = parseInt view_id, 10

  document.getElementById('cancel').addEventListener 'click', ->
    chrome.downloads.erase(id: id)
    window.close()

  document.getElementById('view').addEventListener 'click', ->
    chrome.downloads.erase(id: id, exists: true)
    chrome.downloads.show view_id
    window.close()

  document.getElementById('resume').addEventListener 'click', ->
    window.close()
