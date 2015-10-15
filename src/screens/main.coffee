screens[0] =
  eggoCount: 0
  calcOrigin: -> 0
  items: [
    new ImageItem(-227, 200, "img/logo-shaded.png"),
    new ImageItem(-100, 130, "img/playbutton.png"),
    new ImageItem(-100, 30, "img/creditsbutton.png")
  ]
  height: 300
  music: new Audio

screens[0].music.src = "aud/carnivalloader.mp3"

screens[0].items[0].click = ->
  screens[0].eggoCount++
  if screens[0].eggoCount is eggo
    document.body.classList.add "eggomylego"

screens[0].items[1].click = ->
  # TODO: Go to game screen here.

screens[0].items[2].click = ->
  # TODO: Go to credits screen here.
