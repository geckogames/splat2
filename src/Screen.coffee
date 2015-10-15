class Screen
  calcOrigin: -> 0
  constructor: (height, items, music, additional = {}) ->
    @height = height
    @items = items
    @music = new Audio
    @music.src = music
    @[i] = o for i,o of additional
