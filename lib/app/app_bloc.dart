import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BlocBase {
  bool _isDarkMode = false;

  final StreamController<bool> _streamController = StreamController<bool>();
  Stream<bool> get isDarkMode => _streamController.stream;

  void loadTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.containsKey("theme")) {
      int indexTheme = _prefs.getInt("theme")!;
      if (indexTheme == 0) {
        _isDarkMode = SchedulerBinding.instance!.window.platformBrightness !=
            Brightness.light;
      } else {
        _isDarkMode = indexTheme != 1;
      }
    }

    _streamController.add(_isDarkMode);
  }
}
