helpers =
  # updateCanvasSize changes the size of the canvas to take up the whole screen.
  updateCanvasSize: ->
    canvas.width =
      window.innerWidth || document.clientWidth || document.body.clientWidth
    canvas.height =
      window.innerHeight || document.clientHeight || document.body.clientHeight

  # Converts the in-game coordinates to real, on screen coordinates.
  toCanvasTerms: (x, y, height) ->
    originx = canvas.width / 2 - screens[screen].calcOrigin()
    originy = canvas.height / 2 - screens[screen].height / 2
    {
      x: originx + x
      y: canvas.height - (originy + y) - height
    }

  # Gets the current time as a timestamp.
  timestamp: ->
    window.performance.now() ? new Date().getTime()

  # getImageAlpha gets the alpha (opacity) of a certain pixel in an image.
  # alpha is from 0 (transparent) to 255 (fully opaque)
  getImageAlpha: (image, x, y) ->
    cvctx = document.createElement("canvas").getContext "2d"
    cvctx.drawImage image, 0, 0
    cvctx.getImageData(x, y, 1, 1).data[3]

  # Muted: Whether or not the game is currently muted.
  muted: false

  # ToggleMute: Toggle the game's state of being muted.
  toggleMute: ->
    @muted = !@muted # Toggle the muted variable.
    # Store it in localStorage so we can recall it next time the page loads.
    localStorage.muted = @muted if localStorage
    # Loop through every screen and adjust the volume of the music.
    for i in screens
      if i.music
        i.music.volume = if @muted then 0 else 1

  # Returns the status of a key by name or code from keysdown.
  keyStatus: (kid) -> keysdown[config.keys[kid] or kid]
