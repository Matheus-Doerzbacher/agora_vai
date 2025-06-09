import 'dart:io';

import 'package:flutter/foundation.dart';

class PrintCustom {
  final String _className;

  // Tipo de aparelho ios
  final bool _isIos = Platform.isIOS;

  // Códigos ANSI para cores
  String get _reset => _isIos ? '' : '\x1B[0m';
  String get _error => _isIos ? '❌ ' : '\x1B[31m';
  String get _success => _isIos ? '✅ ' : '\x1B[92m';
  String get _title => _isIos ? '💣 ' : '\x1B[93m';
  String get _fim => _isIos ? '💥 ' : '\x1B[93m';
  String get _info => _isIos ? '💡' : '\x1B[37m';

  PrintCustom(this._className);

  void info(String message) {
    if (kDebugMode) {
      print('[$_className]: $_info$message$_reset');
    }
  }

  void title(String message) {
    if (kDebugMode) {
      print('');
      print('[$_className]: $_title===== $message =====$_reset');
    }
  }

  void success(String message) {
    if (kDebugMode) {
      print('[$_className]: $_success$message$_reset');
    }
  }

  void error(String message) {
    if (kDebugMode) {
      print('[$_className]: $_error$message$_reset');
    }
  }

  void line() {
    if (kDebugMode) {
      print(
        // ignore: lines_longer_than_80_chars
        '[$_className]: $_fim==================================================$_reset',
      );
    }
  }
}
