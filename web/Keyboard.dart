import 'dart:collection';
import 'dart:html';

typedef KeyboardListener = void Function(int key);

class Keyboard {
  HashSet<int> _keys;
  KeyboardListener _listener;
  Keyboard() {
    _keys = new HashSet<int>();
    // window.onKeyDown.listen(_keyDown);
    // window.onKeyUp.listen(_keyReleased);
    window.onKeyPress.listen(_keyPressed);
  }

  // public interface
  void register(KeyboardListener listener) {
    _listener = listener;
  }

  void unregister(KeyboardListener listener) {
    _listener = null;
  }

  void _keyDown(final KeyboardEvent e) {
    print('_keyPressed');
    _keys.add(e.keyCode);
  }

  void _keyReleased(final KeyboardEvent e) {
    print('_keyReleased');
    _keys.remove(e.keyCode);
  }

  void _keyPressed(final KeyboardEvent e) {
    // print('_keyPressed');

    // if (_listener != null) {
    //   if (e.key == '+') {
    //     print('+ pressed !!!');
    //   } else if (e.key == '-') {
    //     print('- pressed !!!');
    //   }
    // }

    if (e.key == '+') {
      print('+ pressed !!!');
      if (_listener != null) {
        _listener(1);
      }
    } else if (e.key == '-') {
      print('- pressed !!!');
      if (_listener != null) {
        _listener(-1);
      }
    }
  }

  // _listener();
}

// bool isPressed(final int keyCode) => _keys.contains(keyCode);
