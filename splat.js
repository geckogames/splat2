// Generated by CoffeeScript 1.9.3
(function() {
  var ImageItem, Item, alphaThreshold, canvas, credits, ctx, dimensions, downness, dt, eggo, fps, frame, getImageAlpha, keyStatus, keys, keysdown, last, mindown, muted, now, render, screen, screens, step, timestamp, toCanvasTerms, toggleMute, update, version,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  fps = 60;

  credits = "By GeckoGames";

  screens = [];

  screen = 0;

  alphaThreshold = 210;

  keys = {
    down: 40
  };

  eggo = 20;

  mindown = 30;

  version = "0.0.1-alpha";

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
    var i, j, k, l, len, len1, len2, o, ref, results;
    ref = screens[screen].items;
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      i.update();
    }
    for (k = 0, len1 = keysdown.length; k < len1; k++) {
      i = keysdown[k];
      i = i !== 0 ? 1 : 0;
    }
    results = [];
    for (i = l = 0, len2 = screens.length; l < len2; i = ++l) {
      o = screens[i];
      if (o.music && i !== screen) {
        o.music.pause();
        results.push(o.music.currentTime = 0);
      } else {
        results.push(o.music.play());
      }
    }
    return results;
  };

  toCanvasTerms = function(x, y, height) {
    var originx, originy;
    originx = canvas.width / 2 - screens[screen].calcOrigin();
    originy = canvas.height / 2 - screens[screen].height / 2;
    return {
      x: originx + x,
      y: canvas.height - (originy + y) - height
    };
  };

  render = function() {
    var coords, i, j, len, ref, results;
    dimensions.width();
    dimensions.height();
    ctx.textAlign = "center";
    ctx.fillStyle = "#fff";
    ctx.font = "10px sans-serif";
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillText(credits + " - v " + version, canvas.width / 2, canvas.height - 10);
    ref = screens[screen].items;
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      coords = toCanvasTerms(i.x, i.y, i.image.height);
      if (i.image) {
        results.push(ctx.drawImage(i.image, coords.x, coords.y));
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
    if (localStorage && localStorage.muted === "true") {
      toggleMute();
    }
    document.querySelector("#mute").onclick = function() {
      return toggleMute();
    };
    return requestAnimationFrame(frame);
  };

  getImageAlpha = function(image, x, y) {
    var cvctx;
    cvctx = document.createElement("canvas").getContext("2d");
    cvctx.drawImage(image, 0, 0);
    return cvctx.getImageData(x, y, 1, 1).data[3];
  };

  canvas.onmouseup = function(e) {
    var coords, i, j, len, ref, results;
    ref = screens[screen].items;
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      if (i.click) {
        coords = toCanvasTerms(i.x, i.y, i.image.height);
        if (getImageAlpha(i.image, e.clientX - coords.x, e.clientY - coords.y) > alphaThreshold) {
          results.push(i.click());
        } else {
          results.push(void 0);
        }
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  keysdown = [];

  downness = 0;

  window.onkeydown = function(e) {
    if (!keysdown[e.keyCode]) {
      keysdown[e.keyCode] = 2;
      if (e.keyCode === keys.down) {
        downness += 1;
        if (downness >= mindown) {
          return canvas.classList.add("flipped");
        }
      } else {
        return downness += downness > 0 ? -1 : 0;
      }
    }
  };

  window.onkeyup = function(e) {
    return keysdown[e.keyCode] = 0;
  };

  keyStatus = function(kid) {
    return keysdown[keys[kid] || kid];
  };

  muted = false;

  toggleMute = function() {
    var i, j, len, results;
    muted = !muted;
    if (localStorage) {
      localStorage.muted = muted;
    }
    results = [];
    for (j = 0, len = screens.length; j < len; j++) {
      i = screens[j];
      if (i.music) {
        results.push(i.music.volume = muted ? 0 : 1);
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  Item = (function() {
    function Item(x1, y1) {
      this.x = x1;
      this.y = y1;
      this.update = function() {};
      this.image = new Image;
      this.calcClickZone = function() {
        return {
          top: this.y + this.image.height,
          left: this.x,
          bottom: this.y,
          right: this.x + this.image.width
        };
      };
    }

    return Item;

  })();

  ImageItem = (function(superClass) {
    extend(ImageItem, superClass);

    function ImageItem(x, y, url) {
      ImageItem.__super__.constructor.call(this, x, y);
      this.image.src = url;
    }

    return ImageItem;

  })(Item);

  screens[0] = {
    eggoCount: 0,
    calcOrigin: function() {
      return 0;
    },
    items: [new ImageItem(-227, 200, "img/logo-shaded.png"), new ImageItem(-100, 130, "img/playbutton.png"), new ImageItem(-100, 30, "img/creditsbutton.png")],
    height: 300,
    music: new Audio
  };

  screens[0].music.src = "aud/carnivalloader.mp3";

  screens[0].items[0].click = function() {
    screens[0].eggoCount++;
    if (screens[0].eggoCount === eggo) {
      return document.body.classList.add("eggomylego");
    }
  };

  screens[0].items[1].click = function() {};

  screens[0].items[2].click = function() {};

}).call(this);
