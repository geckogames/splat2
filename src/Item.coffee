class Item
  update: ->
    console.log "UPDATE"
  image: new Image
  x: 0
  y: 0

class ImageItem extends Item
  constructor: (@x, @y, url)->
    @image.src = url
