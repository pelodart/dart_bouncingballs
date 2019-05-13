import 'dart:html';
import 'BouncingGame.dart';


class GameHost {
  BouncingGame _game;
  int _lastTimestamp;

  int TEST_COUNTER = 0;

  GameHost(String name, CanvasElement canvas) {
    _game = new BouncingGame(canvas);
    _lastTimestamp = 0;
  }

  void run() {
    window.requestAnimationFrame(_gameLoop);
  }

  void _gameLoop(final num _) {
    // this parameter must be of type 'num'
    double elapsed = _getElapsed();
    _game.update(elapsed);
    _game.render();

    TEST_COUNTER++;
    if (TEST_COUNTER == 500) return;

    window.requestAnimationFrame(_gameLoop);
  }

  double _getElapsed() {
    int time = new DateTime.now().millisecondsSinceEpoch;

    double elapsed = 0.0;
    if (_lastTimestamp != 0) {
      elapsed = (time - _lastTimestamp) / 1000.0; // return seconds
    }

    _lastTimestamp = time;
    return elapsed;
  }
}
