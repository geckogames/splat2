class Screen
  calcOriginX: -> 0
  calcOriginY: -> 0
  constructor: (items, music, additional = {}) ->
    @items = items
    @music = new Audio
    @music.src = music
    @[i] = o for i,o of additional
