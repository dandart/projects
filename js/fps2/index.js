// Generated by CoffeeScript 1.7.1
(function() {
  var Camera, Map, cam, frame, map;

  Camera = (function() {
    function Camera(w, h, fov, x, y, z, tx, ty, tz) {
      var _ref;
      this.canvases = document.getElementsByTagName('canvas');
      this.canvas = this.canvases[0];
      this.canvas.height = h;
      this.canvas.width = w;
      this.canvas.style.height = h + 'px';
      this.canvas.style.width = w + 'px';
      this.ctx = this.canvas.getContext('2d');
      _ref = {
        w: w,
        h: h,
        fov: fov,
        x: x,
        y: y,
        z: z,
        tx: tx,
        ty: ty,
        tz: tz
      }, this.w = _ref.w, this.h = _ref.h, this.fov = _ref.fov, this.x = _ref.x, this.y = _ref.y, this.z = _ref.z, this.tx = _ref.tx, this.ty = _ref.ty, this.tz = _ref.tz;
      this.origin = {
        x: this.w / 2,
        y: this.h / 2
      };
    }

    Camera.prototype.clear = function() {
      this.ctx.fillStyle = 'black';
      return this.ctx.fillRect(0, 0, this.w, this.h);
    };

    Camera.prototype.trace = function(map) {
      var dpx, dpy, dx, dy, dz, iter, line, point, px, py, spoints, tx, ty, tz, _i, _j, _len, _len1, _ref, _ref1, _results;
      this.ctx.fillStyle = 'white';
      this.ctx.strokeStyle = 'white';
      spoints = {};
      _ref = map.points;
      for (iter = _i = 0, _len = _ref.length; _i < _len; iter = ++_i) {
        point = _ref[iter];
        dx = point[0] - this.x;
        dy = point[1] - this.y;
        dz = point[2] - this.z;
        tx = Math.atan(dx / dz + this.tx);
        ty = Math.atan(dy / dz + this.ty);
        tz = this.tz;
        dpx = this.fov * this.h * tx;
        dpy = this.fov * this.h * ty;
        px = dpx + this.origin.x;
        py = this.origin.y - dpy;
        spoints[iter] = [px, py];
      }
      _ref1 = map.lines;
      _results = [];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        line = _ref1[_j];
        this.ctx.beginPath();
        this.ctx.moveTo(spoints[line[0]][0], spoints[line[0]][1]);
        this.ctx.lineTo(spoints[line[1]][0], spoints[line[1]][1]);
        _results.push(this.ctx.stroke());
      }
      return _results;
    };

    return Camera;

  })();

  Map = (function() {
    function Map() {
      var file, json, obj;
      file = document.getElementById('map');
      json = file.innerText;
      obj = JSON.parse(json);
      this.points = obj.points;
      this.lines = obj.lines;
    }

    return Map;

  })();

  cam = new Camera(window.innerWidth, window.innerHeight, Math.PI / 2, 0.5, 0.3, -4, 0, 0, 0);

  map = new Map;

  frame = function() {
    cam.clear();
    cam.x += 0.005;
    cam.z += 0.005;
    cam.tx += 0.0015;
    cam.ty = 0.1 * Math.sin(cam.tx * 32);
    cam.trace(map);
    return window.requestAnimationFrame(frame);
  };

  frame();

}).call(this);
