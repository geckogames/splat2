# Get the game canvas and the context for it.
canvas = document.querySelector '#cvas'
ctx = canvas.getContext '2d'

# The update function is triggered every tick of the game.
update = ->
  # Loop through every item in the current screen and update it.
  for i in screens[screen].items
    i.update()

  # Loop through every item in keysdown and change the keys that are marked as
  # being just pressed (2) so that they instead are labeled as held down (1).
  for i in keysdown
    i = if i isnt 0 then 1 else 0

  # Loop through every screen.
  for o, i in screens
    # If this screen isn't the current screen and this screen has music, stop
    # the music because only the current screen's music should play.
    if o.music and i isnt screen
      o.music.pause()
      o.music.currentTime = 0
    # If this is the current screen, play the music, unless it is already
    # playing, in which case the play function does nothing.
    else
      o.music.play()

render = ->
  helpers.updateCanvasSize()
  # Set the Font Styles
  ctx.textAlign = "center"
  ctx.fillStyle = "#fff"
  ctx.font = "10px sans-serif"
  ctx.clearRect 0, 0, canvas.width, canvas.height
  ctx.fillText "#{config.credits} - v #{config.version}",
  canvas.width / 2, canvas.height - 10

  for i in screens[screen].items
    coords = helpers.toCanvasTerms i.x, i.y, i.image.height
    ctx.drawImage i.image, coords.x, coords.y if i.image

# This is the game loop.
now = 0
dt = 0
last = helpers.timestamp()
step = 1/config.fps
frame = ->
  now = helpers.timestamp()
  dt = dt + Math.min 1, (now - last) / 1000
  while dt > step
    dt = dt - step
    update()
  render()
  last = now
  requestAnimationFrame frame

# Now we start the game, finally.
window.onload = ->
  if localStorage and localStorage.muted is "true"
    helpers.toggleMute()

  document.querySelector("#mute").onclick = ->
    helpers.toggleMute()
  requestAnimationFrame frame

# Triggered whenever the canvas is clicked.
canvas.onmouseup = (e) ->
  # Loop through every item on the current screen.
  for i in screens[screen].items
    if i.click # Only do the work if this item is clickable.
      # Get the coordinates of the click.
      coords = helpers.toCanvasTerms i.x, i.y, i.image.height
      # Trigger the item's click event if the alpha of it's image is greater
      # than alphaThreshold at the click point.
      i.click() if helpers.getImageAlpha(i.image, e.clientX - coords.x,
      e.clientY - coords.y) > config.alphaThreshold

# A list of mapped keys that are down.
# Values:
#  - 0 or undefined: Up
#  - 1: Continually Pressed
#  - 2: Just Pressed
keysdown = []

downness = 0 # Figure it out yourself.

# Triggered whenever a key is pressed down.
window.onkeydown = (e) ->
  if not keysdown[e.keyCode]
    keysdown[e.keyCode] = 2

    if e.keyCode is config.keys.down
      downness += 1
      if downness >= config.mindown
        canvas.classList.add "flipped"
    else
      downness += if downness > 0 then -1 else 0

# Triggered whenever a key is released.
window.onkeyup = (e) ->
  keysdown[e.keyCode] = 0
