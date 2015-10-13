// Generated by CoffeeScript 1.9.3
(function() {
  var Item, canvas, credits, ctx, dimensions, dt, fps, frame, last, now, render, screen, screens, step, timestamp, update;

  fps = 60;

  credits = "By GeckoGames";

  screens = [];

  screen = 0;

  canvas = document.querySelector('#cvas');

  ctx = canvas.getContext('2d');

  dimensions = {
    width: function() {
      return canvas.width = window.innerWidth || document.clientWidth || document.body.clientWidth;
    },
    height: function() {
      return canvas.height = window.innerHeight || document.clientHeight || document.body.clientHeight;
    }
  };

  update = function() {
    var i, j, len, ref, results;
    ref = screens[screen].items;
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      results.push(i.update());
    }
    return results;
  };

  render = function() {
    var i, j, len, originx, originy, ref, results;
    dimensions.width();
    dimensions.height();
    ctx.textAlign = "center";
    ctx.fillStyle = "#fff";
    ctx.font = "10px sans-serif";
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillText(credits, canvas.width / 2, canvas.height - 10);
    originx = screens[screen].calcOrigin();
    originy = canvas.height / 2 + screens[screen].height / 2;
    ref = screens[screen].items;
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      if (i.image) {
        results.push(ctx.drawImage(i.image, originx - i.x, originy - i.y));
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  timestamp = function() {
    var ref;
    return (ref = window.performance.now()) != null ? ref : new Date().getTime();
  };

  now = 0;

  dt = 0;

  last = timestamp();

  step = 1 / fps;

  frame = function() {
    now = timestamp();
    dt = dt + Math.min(1, (now - last) / 1000);
    while (dt > step) {
      dt = dt - step;
      update();
    }
    render();
    last = now;
    return requestAnimationFrame(frame);
  };

  window.onload = function() {
    return requestAnimationFrame(frame);
  };

  Item = (function() {
    function Item() {}

    Item.prototype.update = function() {
      return console.log("UPDATE");
    };

    Item.prototype.image = new Image("http://r.duckduckgo.com/l/?kh=-1&uddg=http%3A%2F%2Fclub-poin t-de-croix.com%2Fimages%2Fclubpdc1%2F245x293%2Fplaceholder%2Fsmall_image.jpg");

    Item.prototype.x = 0;

    Item.prototype.y = 0;

    return Item;

  })();

  screens[0] = {
    calcOrigin: function() {
      return 0;
    },
    items: [new Item()]
  };

}).call(this);
