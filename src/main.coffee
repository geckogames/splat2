
canvas = document.querySelector '#cvas'
ctx = canvas.getContext '2d'

dimensions =
  width: ->
    canvas.width =
      window.innerWidth || document.clientWidth || document.body.clientWidth
  height: ->
    canvas.height =
      window.innerHeight || document.clientHeight || document.body.clientHeight

update = ->
  for i in screens[screen].items
    i.update()
  for i in keysdown
    i = if i isnt 0 then 1 else 0

# Converts the in-game coordinates to real, on screen coordinates.
toCanvasTerms = (x, y, height) ->
  originx = canvas.width / 2 - screens[screen].calcOrigin()
  originy = canvas.height / 2 - screens[screen].height / 2
  {
    x: originx + x
    y: canvas.height - (originy + y) - height
  }

render = ->
  dimensions.width()
  dimensions.height()
  # Set the Font Styles
  ctx.textAlign = "center"
  ctx.fillStyle = "#fff"
  ctx.font = "10px sans-serif"
  ctx.clearRect 0, 0, canvas.width, canvas.height
  ctx.fillText credits, canvas.width / 2, canvas.height - 10

  for i in screens[screen].items
    coords = toCanvasTerms i.x, i.y, i.image.height
    ctx.drawImage i.image, coords.x, coords.y if i.image

# This is the game loop.
# Gets a timestamp.
timestamp = ->
  window.performance.now() ? new Date().getTime()
# Now for the actual loop.
now = 0
dt = 0
last = timestamp()
step = 1/fps
frame = ->
  now = timestamp()
  dt = dt + Math.min 1, (now - last) / 1000
  while dt > step
    dt = dt - step
    update()
  render()
  last = now
  requestAnimationFrame frame

# Now we start the game, finally.
window.onload = ->
  requestAnimationFrame frame

# getImageAlpha gets the alpha (opacity) of a certain pixel in an image.
# alpha is from 0 (transparent) to 255 (fully opaque)
getImageAlpha = (image, x, y) ->
  cvctx = document.createElement("canvas").getContext "2d"
  cvctx.drawImage image, 0, 0
  cvctx.getImageData(x, y, 1, 1).data[3]

# Triggered whenever the canvas is clicked.
canvas.onmouseup = (e) ->
  # Loop through every item on the current screen.
  for i in screens[screen].items
    if i.click # Only do the work if this item is clickable.
      # Get the coordinates of the click.
      coords = toCanvasTerms i.x, i.y, i.image.height
      # Trigger the item's click event if the alpha of it's image is greater
      # than alphaThreshold at the click point.
      i.click() if getImageAlpha(i.image, e.clientX - coords.x,
      e.clientY - coords.y) > alphaThreshold

# A list of mapped keys that are down.
# Values:
#  - 0 or undefined: Up
#  - 1: Continually Pressed
#  - 2: Just Pressed
keysdown = []

downness = 0 # Figure it out yourself.

# Array.indexOf for Objects
Object::indexOf = (v) ->
  for key, val of @
    return key if val is v
  -1

# Triggered whenever a key is pressed down.
window.onkeydown = (e) ->
  kcloc = keys.indexOf e.keyCode
  if kcloc isnt -1
    if not keysdown[e.keyCode]
      keysdown[e.keyCode] = 2
      if e.keyCode is keys.down
        downness += 1
        if downness >= mindown
          canvas.classList.add "flipped"
      else
        downness += if downness > 0 then -1 else 0

# Triggered whenever a key is released.
window.onkeyup = (e) ->
  kcloc = keys.indexOf e.keyCode
  if kcloc isnt -1
    keysdown[e.keyCode] = 0

# Returns the status of a key by name from keysdown.
keyStatus = (kname) -> keysdown[keys[kname]]
