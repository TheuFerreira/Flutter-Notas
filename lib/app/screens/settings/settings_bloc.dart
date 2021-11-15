import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_notas/app/app_bloc.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/shared/models/settings_model.dart';
import 'package:flutter_notas/app/shared/services/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends BlocBase {
  final List<String> themes = [
    'Sistema (automático)',
    'Claro',
    'Escuro',
  ];
  final List<String> fonts = [
    'Antic Slab',
    'Arvo',
    'Karla',
    'Rajdhani',
    'Roboto',
  ];

  final StreamController<String> _stream = StreamController<String>();
  Stream<String> get valueTheme => _stream.stream;

  final StreamController<String> _streamFont = StreamController<String>();
  Stream<String> get valueFont => _streamFont.stream;

  final StreamController<bool> _streamBold = StreamController<bool>();
  Stream<bool> get valueBold => _streamBold.stream;

  final StreamController<bool> _streamItalic = StreamController<bool>();
  Stream<bool> get valueItalic => _streamItalic.stream;

  final StreamController<bool> _streamAuth = StreamController<bool>();
  Stream<bool> get valueAuth => _streamAuth.stream;

  SettingsBloc() {
    SettingsModel _settings = SettingsModel();
    String _valueTheme = themes[0];

    SharedPreferences.getInstance().then(
      (_prefs) {
        int indexTheme = 0;
        if (_prefs.containsKey("theme")) {
          indexTheme = _prefs.getInt("theme")!;
        }

        _valueTheme = themes[indexTheme];
        _stream.add(_valueTheme);

        if (_prefs.containsKey('font')) {
          _settings.font = _prefs.getString('font')!;
        }

        _streamFont.add(_settings.font);

        if (_prefs.containsKey('bold')) {
          _settings.isBold = _prefs.getBool('bold')!;
        }

        _streamBold.add(_settings.isBold);

        if (_prefs.containsKey('italic')) {
          _settings.isItalic = _prefs.getBool('italic')!;
        }

        _streamItalic.add(_settings.isItalic);

        if (_prefs.containsKey('authentication')) {
          _settings.hasAuthentication = _prefs.getBool('authentication')!;
        }

        _streamAuth.add(_settings.hasAuthentication);
      },
    );
  }

  void setTheme(String? value) async {
    String _valueTheme = value!;
    _stream.add(_valueTheme);

    int index = themes.indexOf(_valueTheme);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt("theme", index);

    AppModule.to.bloc<AppBloc>().loadSettings();
  }

  void setFont(String? value) async {
    String font = value!;
    _streamFont.add(font);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("font", font);

    AppModule.to.bloc<AppBloc>().loadSettings();
  }

  void setBold(bool? value) async {
    bool isBold = !value!;
    _streamBold.add(isBold);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("bold", isBold);

    AppModule.to.bloc<AppBloc>().loadSettings();
  }

  void setItalic(bool? value) async {
    bool isItalic = !value!;
    _streamItalic.add(isItalic);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("italic", isItalic);

    AppModule.to.bloc<AppBloc>().loadSettings();
  }

  void setSecurity(bool? value) async {
    AuthenticationService auth = AuthenticationService();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (value!) {
      bool isSupported = await auth.isSupported();
      value = isSupported;

      if (isSupported) {
        bool isAuthenticated = await auth.authenticate();
        value = isAuthenticated;
      }
    }

    _prefs.setBool("authentication", value);
    _streamAuth.add(value);
  }
}
