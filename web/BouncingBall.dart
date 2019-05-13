import 'dart:math';
import 'package:sprintf/sprintf.dart';
import 'package:vector_math/vector_math.dart';

class BouncingBall {
  static const int Radius = 10;
  static const double velocity = 100.0;

  Random _random;

  // member data
  double _x;
  double _y;
  Vector2 _direction; // direction vector to move shape

  // default c'tor
  BouncingBall.origin(Random random)
      : _x = 0,
        _y = 0 {
    _random = random;
    _direction = new Vector2((_random.nextInt(20) - 10).toDouble(),
        (_random.nextInt(20) - 10).toDouble());
    _direction.normalize();
  }

  // user-defined c'tor
  BouncingBall(Random random, double x, double y)
      : _x = x,
        _y = y {
    _random = random;
    _direction = new Vector2((_random.nextInt(20) - 10).toDouble(),
        (_random.nextInt(20) - 10).toDouble());
    _direction.normalize();
  }

  BouncingBall.clone(BouncingBall ball)
      : _random = ball._random,
        _direction = ball._direction,
        _x = ball._x,
        _y = ball._y {}

  // getters and setters
  double get X => _x;
  double get Y => _y;
  Vector2 get Direction => _direction;
  set Direction(Vector2 direction) => _direction = direction;

  Vector2 get Center => new Vector2(_x, _y);

  // public interface
  void move(double elapsed) {
    // print(sprintf("move: %g - %g [elapsed = %g]", [_x, _y, elapsed]));

    _x += _direction.x * 1.5;
    _y += _direction.y * 1.5;

    // _x += (_direction.x * elapsed);
    // _y += (_direction.y * elapsed);
  }

  void normalizeDirection() {
    this._direction.normalize();
  }

  @override
  String toString() {
    return sprintf("BouncingBall: X=%g, Y=%g", [_x, _y]);
  }
}
