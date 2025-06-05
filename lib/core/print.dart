import 'package:flutter/foundation.dart';

class PrintCustom {
  final String _className;

  // Códigos ANSI para cores
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _blue = '\x1B[34m';
  static const String _cyan = '\x1B[36m';

  PrintCustom(this._className);

  void info(String? message) {
    if (kDebugMode) {
      print('[$_className]: $message');
    }
  }

  void title(String? message) {
    if (kDebugMode) {
      print('$_reset$_blue[$_className]: ===== $message$_reset =====');
    }
  }

  void success(String? message) {
    if (kDebugMode) {
      print('$_green[$_className]: $message$_reset');
    }
  }

  void error(String? message) {
    if (kDebugMode) {
      print('$_red[$_className]: $message$_reset');
    }
  }

  void line() {
    if (kDebugMode) {
      print('$_cyan--------------------------------$_reset');
    }
  }
}
