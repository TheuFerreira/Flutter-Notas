import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BlocBase {
  bool _isDarkMode = false;
  String _defaultFont = '';
  bool _isBold = false;
  bool _isItalic = false;

  final StreamController<List<dynamic>> _streamController =
      StreamController<List<dynamic>>();
  Stream<List<dynamic>> get settings => _streamController.stream;

  void loadTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //await _prefs.clear();

    if (_prefs.containsKey("theme")) {
      int indexTheme = _prefs.getInt("theme")!;
      if (indexTheme == 0) {
        _isDarkMode = SchedulerBinding.instance!.window.platformBrightness !=
            Brightness.light;
      } else {
        _isDarkMode = indexTheme != 1;
      }
    } else {
      _isDarkMode = SchedulerBinding.instance!.window.platformBrightness !=
          Brightness.light;
    }

    _defaultFont = 'Roboto';
    if (_prefs.containsKey("font")) {
      _defaultFont = _prefs.getString("font")!;
    }

    _isBold = false;
    if (_prefs.containsKey("bold")) {
      _isBold = _prefs.getBool("bold")!;
    }

    _isItalic = false;
    if (_prefs.containsKey("italic")) {
      _isItalic = _prefs.getBool("italic")!;
    }

    _streamController.add([_isDarkMode, _defaultFont, _isBold, _isItalic]);
  }
}
