import 'dart:math' as math;
import 'dart:math';
import 'package:sprintf/sprintf.dart';
import 'dart:html';
import 'BouncingBall.dart';
import 'package:vector_math/vector_math.dart';
import 'Keyboard.dart';

class BouncingGame /* extends AbstractGame */ {
  // static final int NumStartBalls = 1;
  static final String Name = "bounce";

  final CanvasElement _canvas;

  Keyboard _keyboard;

  var _width;
  var _height;
  Random _random;

  List<BouncingBall> _listBalls;

  BouncingGame(this._canvas) /* : super(Name, canvas)  */ {
    _width = _canvas.clientWidth;
    _height = _canvas.clientHeight;
    print(sprintf("Width: %d - Height: %d", [_width, _height]));

    _random = new Random();
    _listBalls = new List<BouncingBall>();

    _canvas.onMouseDown.listen(onData);

    // test frame
    // for (int n = 0; n < NumStartBalls; n++) {
    //   BouncingBall ball = new BouncingBall(_random, n * 10.0, n * 20.0);
    //   _listBalls.add(ball);
    // }

    BouncingBall ball = new BouncingBall(_random, _width / 2, _height / 2);
    _listBalls.add(ball);

    _keyboard = new Keyboard();
    _keyboard.register(_onKeyPressed);
  }

  // getter / setter
  CanvasRenderingContext2D get Context => _canvas.context2D;

  void render() {
    _drawBackground();
    _drawBalls();
  }

  void update(double elapsed) {
    for (int i = 0; i < _listBalls.length; i++) {
      _moveBall(_listBalls[i], elapsed);
    }
  }

  void _moveBall(BouncingBall ball, double elapsed) {
    ball.move(elapsed);

    // check boundaries of window and other balls
    _checkBoundaries(ball);
    _checkCollisions(ball);
  }

  void _checkBoundaries(BouncingBall ball) {
    if (ball.Y < BouncingBall.Radius) {
      // top wall collision, invert direction vertical
      if (ball.Direction.y < 0)
        ball.Direction = new Vector2(ball.Direction.x, -ball.Direction.y);
    } else if (ball.Y > (_height - BouncingBall.Radius)) {
      // bottom wall collision, invert direction vertical
      if (ball.Direction.y > 0)
        ball.Direction = new Vector2(ball.Direction.x, -ball.Direction.y);
    } else if (ball.X < BouncingBall.Radius) {
      // left wall collision, invert direction horizontal
      if (ball.Direction.x < 0)
        ball.Direction = new Vector2(-ball.Direction.x, ball.Direction.y);
    } else if (ball.X > (_width - BouncingBall.Radius)) {
      // left wall collision, invert direction horizontal
      if (ball.Direction.x > 0)
        ball.Direction = new Vector2(-ball.Direction.x, ball.Direction.y);
    }
  }

  void _checkCollisions(BouncingBall ball) {
    // bool colorswap = false;

    for (int i = 0; i < _listBalls.length; i++) {
      if (ball == _listBalls[i]) continue;

      Vector2 difference = ball.Center - _listBalls[i].Center;
      if (difference.length <= (BouncingBall.Radius * 2)) {
        difference.normalize();
        ball.Direction += difference;
        // colorswap = true;
      }
    }

    ball.normalizeDirection();

    //  if (colorswap)
    //  {
    //      if (ball.Circle.Stroke == Brushes.Blue)
    //          ball.Circle.Stroke = Brushes.Red;
    //      else if (ball.Circle.Stroke == Brushes.Red)
    //          ball.Circle.Stroke = Brushes.Green;
    //      else if (ball.Circle.Stroke == Brushes.Green)
    //          ball.Circle.Stroke = Brushes.Yellow;
    //      else if (ball.Circle.Stroke == Brushes.Yellow)
    //          ball.Circle.Stroke = Brushes.White;
    //      else if (ball.Circle.Stroke == Brushes.White)
    //          ball.Circle.Stroke = Brushes.Blue;
    //  }
  }

  // private helper methods
  void _drawBackground() {
    Context
      ..globalAlpha = 1
      ..fillStyle = "lightgray"
      ..beginPath()
      ..rect(0, 0, _width, _height)
      ..fill();
  }

  void _drawBalls() {
    for (int i = 0; i < _listBalls.length; i++) {
      _drawBall(_listBalls[i]);
    }
  }

  void _drawBall(BouncingBall ball) {
    Context
      ..beginPath()
      ..fillStyle = "green"
      ..arc(ball.X, ball.Y, BouncingBall.Radius, 0, math.pi * 2.0)
      ..fill();
  }

  void _onKeyPressed(var key) {
    print(sprintf("_onKeyPressed: %d", [key]));
  }

  void onData(MouseEvent event) {
    // print("MouseEvent ....");
    _getMousePos(_canvas, event);
  }

  void _getMousePos(CanvasElement canvas, MouseEvent evt) {
    var rect = canvas.getBoundingClientRect();

    int x =
        ((evt.client.x - rect.left) / (rect.right - rect.left) * canvas.width)
            .toInt();
    int y =
        ((evt.client.y - rect.top) / (rect.bottom - rect.top) * canvas.height)
            .toInt();

    BouncingBall ball = new BouncingBall(_random, x.toDouble(), y.toDouble());
    _listBalls.add(ball);

    print(sprintf("_getMousePos: %d === %d", [x, y]));
  }
}
