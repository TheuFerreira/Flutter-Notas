import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_notas/app/shared/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BlocBase {
  SettingsModel _settings = SettingsModel();

  final StreamController<SettingsModel> _streamController =
      StreamController<SettingsModel>();
  Stream<SettingsModel> get settings => _streamController.stream;

  void loadSettings() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.containsKey("theme")) {
      int indexTheme = _prefs.getInt("theme")!;
      if (indexTheme == 0) {
        _settings.isDark =
            SchedulerBinding.instance!.window.platformBrightness !=
                Brightness.light;
      } else {
        _settings.isDark = indexTheme != 1;
      }
    } else {
      _settings.isDark = SchedulerBinding.instance!.window.platformBrightness !=
          Brightness.light;
    }

    if (_prefs.containsKey("font")) {
      _settings.font = _prefs.getString("font")!;
    }

    if (_prefs.containsKey("bold")) {
      _settings.isBold = _prefs.getBool("bold")!;
    }

    if (_prefs.containsKey("italic")) {
      _settings.isItalic = _prefs.getBool("italic")!;
    }

    if (_prefs.containsKey("authentication")) {
      _settings.hasAuthentication = _prefs.getBool("authentication")!;
    }

    _streamController.add(_settings);
  }
}
