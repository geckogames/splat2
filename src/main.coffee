
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
render = ->
  dimensions.width()
  dimensions.height()
  # Set the Font Styles
  ctx.textAlign = "center"
  ctx.fillStyle = "#fff"
  ctx.font = "10px sans-serif"
  ctx.clearRect(0,0,canvas.width, canvas.height)
  ctx.fillText credits, canvas.width / 2, canvas.height - 10

  originx = screens[screen].calcOrigin()
  originy = canvas.height / 2 + screens[screen].height / 2

  for i in screens[screen].items
    ctx.drawImage i.image,
    originx - i.x, originy - i.y if i.image

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
