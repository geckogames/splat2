class Item
  constructor: (@x, @y) ->
    @update = ->
    @image = new Image
    @calcClickZone = -> {
      top: @y + @image.height
      left: @x
      bottom: @y
      right: @x + @image.width
    }

class ImageItem extends Item
  constructor: (x, y, url) ->
    super x, y
    @image.src = url
