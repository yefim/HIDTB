cancel = (id) ->
  chrome.downloads.erase(id: id)

window.onload = ->
  Params = (->
    params = {}
    query = window.location.search.substring(1)
    vars = query.split "&"
    for v in vars
      pair = v.split "="
      params[pair[0]] = parseInt pair[1], 10
    return params
    )()
  document.getElementById('cancel').addEventListener 'click', ->
    cancel Params.id
    window.close()

  document.getElementById('view').addEventListener 'click', ->
    cancel Params.id
    chrome.downloads.show Params.view
    window.close()

  document.getElementById('resume').addEventListener 'click', ->
    window.close()
