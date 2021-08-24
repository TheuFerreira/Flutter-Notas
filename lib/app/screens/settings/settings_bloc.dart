import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_notas/app/app_bloc.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends BlocBase {
  final List<String> themes = ['Sistema (automático)', 'Claro', 'Escuro'];
  late String _valueTheme;

  final StreamController<String> _stream = StreamController<String>();
  Stream<String> get valueTheme => _stream.stream;

  final List<String> fonts = [
    'Antic Slab',
    'Arvo',
    'Karla',
    'Rajdhani',
    'Roboto',
  ];
  late String _valueFont;

  final StreamController<String> _streamFont = StreamController<String>();
  Stream<String> get valueFont => _streamFont.stream;

  late bool _valueBold;

  final StreamController<bool> _streamBold = StreamController<bool>();
  Stream<bool> get valueBold => _streamBold.stream;

  late bool _valueItalic;

  final StreamController<bool> _streamItalic = StreamController<bool>();
  Stream<bool> get valueItalic => _streamItalic.stream;

  SettingsBloc() {
    _valueTheme = themes[0];

    SharedPreferences.getInstance().then(
      (_prefs) {
        int indexTheme = 0;
        if (_prefs.containsKey("theme")) {
          indexTheme = _prefs.getInt("theme")!;
        }

        _valueTheme = themes[indexTheme];
        _stream.add(_valueTheme);

        String defaultFont = 'Roboto';
        if (_prefs.containsKey('font')) {
          defaultFont = _prefs.getString('font')!;
        }

        _valueFont = defaultFont;
        _streamFont.add(_valueFont);

        bool defaultBold = false;
        if (_prefs.containsKey('bold')) {
          defaultBold = _prefs.getBool('bold')!;
        }

        _valueBold = defaultBold;
        _streamBold.add(_valueBold);

        bool defaultItalic = false;
        if (_prefs.containsKey('italic')) {
          defaultItalic = _prefs.getBool('italic')!;
        }

        _valueItalic = defaultItalic;
        _streamItalic.add(_valueItalic);
      },
    );
  }

  void setTheme(String? value) async {
    _valueTheme = value!;
    _stream.add(_valueTheme);

    int index = themes.indexOf(_valueTheme);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt("theme", index);

    AppModule.to.bloc<AppBloc>().loadTheme();
  }

  void setFont(String? value) async {
    _valueFont = value!;
    _streamFont.add(_valueFont);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("font", _valueFont);

    AppModule.to.bloc<AppBloc>().loadTheme();
  }

  void setBold(bool? value) async {
    _valueBold = !value!;
    _streamBold.add(_valueBold);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("bold", _valueBold);

    AppModule.to.bloc<AppBloc>().loadTheme();
  }

  void setItalic(bool? value) async {
    _valueItalic = !value!;
    _streamItalic.add(_valueItalic);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("italic", _valueItalic);

    AppModule.to.bloc<AppBloc>().loadTheme();
  }
}
