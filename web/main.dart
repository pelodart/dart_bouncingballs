import 'dart:core';
import 'dart:html';
import 'dart:async';

import 'BouncingGame.dart';
import 'GameHost.dart';

void main() {
  // just for testing
  // querySelector('#dada').text = 'Arghhhhhhhhhhhhhhhhh';
  print('in main');

  final CanvasElement canvas = querySelector("#area");
  canvas.focus();
  GameHost host = new GameHost(BouncingGame.Name, canvas);
  scheduleMicrotask(host.run);
}
