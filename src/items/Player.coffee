class Player extends Item
  constructor: (x, y) ->
    super x, y
    @image.src = "img/player.png"
    @update = ->
      console.log helpers.keyStatus 'down'
      if helpers.keyStatus 'down' then @y += 0.05
      if helpers.keyStatus 'up' then @y -= 0.05
      if helpers.keyStatus 'left' then @x -= 0.05
      if helpers.keyStatus 'right' then @x += 0.05
