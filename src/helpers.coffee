helpers =
  # updateCanvasSize changes the size of the canvas to take up the whole screen.
  updateCanvasSize: ->
    canvas.width =
      window.innerWidth || document.clientWidth || document.body.clientWidth
    canvas.height =
      window.innerHeight || document.clientHeight || document.body.clientHeight

  # Converts the in-game coordinates to real, on screen coordinates.
  toCanvasTerms: (x, y) ->
    originx = canvas.width / 2 - screens[screen].calcOriginX() * config.tileSize
    originy = canvas.height / 2 -
    screens[screen].calcOriginY() * config.tileSize
    {
      x: originx + x * config.tileSize
      y: originy + y * config.tileSize
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

  # Returns an array of items from a multidimensional array.
  toGameMap: (multis, things) ->
    result = []
    for x, k in multis
      result.push []
      for a, i in x
        for o, j in a
          if things[o]
            result[k].push things[o](j, i)
    result
