import 'dart:math' as math;
import 'dart:html';
import 'package:sprintf/sprintf.dart';

import 'abstractgame.dart';
import 'keyboard.dart';

class SimpleGame extends AbstractGame {
  static final String Name = "simple";
  static final double velocity = 100.0;

  double _x;
  double _y;
  Keyboard _keyboard;

  SimpleGame(CanvasElement canvas) : super(Name, canvas) {
    _x = 400.0;
    _y = 300.0;
    _keyboard = new Keyboard();
  }

  void render() {

    Context
      ..globalAlpha = 1
      ..fillStyle = "yellow"
      ..beginPath()
      ..rect(0, 0, 800, 600)
      ..fill();

    Context
      ..beginPath()
      ..fillStyle = "red"
      ..arc(_x, _y, 32, 0, math.pi * 2.0)
      ..fill();
  }

  void update(double elapsed) {
    // if (_keyboard.isPressed(KeyCode.LEFT)) _x -= velocity * elapsed;
    // if (_keyboard.isPressed(KeyCode.RIGHT)) _x += velocity * elapsed;
    // if (_keyboard.isPressed(KeyCode.UP)) _y -= velocity * elapsed;
    // if (_keyboard.isPressed(KeyCode.DOWN)) _y += velocity * elapsed;
  }
}
