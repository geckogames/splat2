screens[1] = new Screen helpers.toGameMap([
    [
      [0,1,0,1,0],
      [1,0,1,0,1],
      [0,1,0,1,0],
      [1,0,1,0,1],
      [0,1,0,1,0],
    ],
    [
      [x,x,x,2]
    ]
  ],
  [
    ((x, y) -> new ImageItem(x, y, "img/grass.png")),
    ((x, y) -> new ImageItem(x, y, "img/grass2.png")),
    ((x, y) -> new Player(x, y))
  ]
  ), "aud/Smoke Machine 2.wav",
  calcOriginX: -> 2
  calcOriginY: -> 2.5
