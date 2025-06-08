import 'package:flutter/foundation.dart';

class PrintCustom {
  final String _className;

  // Códigos ANSI para cores
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[92m';
  static const String _yellow = '\x1B[93m';
  static const String _white = '\x1B[37m';

  PrintCustom(this._className);

  void info(String message) {
    if (kDebugMode) {
      print('[$_className]: $_white$message$_reset');
    }
  }

  void title(String message) {
    if (kDebugMode) {
      print('');
      print('[$_className]: $_yellow===== $message =====$_reset');
    }
  }

  void success(String message) {
    if (kDebugMode) {
      print('[$_className]: $_green$message$_reset');
    }
  }

  void error(String message) {
    if (kDebugMode) {
      print('[$_className]: $_red$message$_reset');
    }
  }

  void line() {
    if (kDebugMode) {
      print(
        // ignore: lines_longer_than_80_chars
        '[$_className]: $_yellow==================================================$_reset',
      );
    }
  }
}
