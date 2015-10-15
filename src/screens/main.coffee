screens[0] = new Screen 300, [
  new ImageItem(-227, 200, "img/logo-shaded.png", ->
    console.log eggo, screens[0].eggoCount
    screens[0].eggoCount++
    if screens[0].eggoCount is eggo
      document.body.classList.add "eggomylego"
  ),
  new ImageItem(-100, 130, "img/playbutton.png", ->
    # TODO: Go to game screen here.
  ),
  new ImageItem(-100, 30, "img/creditsbutton.png", ->
    # TODO: Go to credits screen here.
  )
], "aud/carnivalloader.mp3",
  eggoCount: 0
