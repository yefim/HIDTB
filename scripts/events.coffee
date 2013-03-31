Params = (->
  params = {}
  query = window.location.search.substring(1)
  vars = query.split "&"
  for v in vars
    pair = v.split "="
    params[pair[0]] = pair[1]
  return params
  )()

cancel = ->
  chrome.downloads.erase(id: Params.id)
  window.close()

view = ->
  cancel Params.id
  chrome.downloads.show Params.view
  window.close()

carry_on = ->
  window.close()
