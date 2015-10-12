canvas = document.querySelector '#cvas'
ctx = canvas.getContext '2d'

dimensions =
  width: ->
    canvas.width =
      window.innerWidth || document.clientWidth || document.body.clientWidth
  height: ->
    canvas.height =
      window.innerHeight || document.clientHeight || document.body.clientHeight

dimensions.width()
dimensions.height()

console.log ctx.textAlign
ctx.textAlign = "center"
console.log ctx.textAlign
ctx.fillStyle = "#FFFFFF"
ctx.font = "10px sans-serif"
console.log ctx.fillStyle

ctx.fillText "By Geckogames", canvas.width / 2, canvas.height - 10
