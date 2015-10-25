screens[0] = new Screen [[
  new ImageItem(-3.546875, -3.5, "img/logo-shaded.png", ->
    screens[0].eggoCount++
    if screens[0].eggoCount is config.eggo
      document.body.classList.add "eggomylego"
  ),
  new ImageItem(-1.5625, -1.5, "img/playbutton.png", ->
    screen = 1
  ),
  new ImageItem(-1.5625, 0, "img/creditsbutton.png", ->
    # TODO: Go to credits screen here.
  )
]], "aud/carnivalloader.mp3",
  eggoCount: 0
