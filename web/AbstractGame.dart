import 'dart:html';

abstract class AbstractGame {
  final String _name;
  final CanvasElement _canvas;

  AbstractGame(this._name, this._canvas);

  CanvasElement get Canvass => _canvas;
  CanvasRenderingContext2D get Context => _canvas.context2D;
  String get GameName => _name;

  void render();
  void update(double elapsed);
}
