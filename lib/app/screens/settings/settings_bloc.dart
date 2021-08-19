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

  SettingsBloc() {
    _valueTheme = themes[0];

    SharedPreferences.getInstance().then((_prefs) {
      int indexTheme = 0;
      if (_prefs.containsKey("theme")) {
        indexTheme = _prefs.getInt("theme")!;
      }

      _valueTheme = themes[indexTheme];
      _stream.add(_valueTheme);
    });
  }

  void setTheme(String? value) async {
    _valueTheme = value!;
    _stream.add(_valueTheme);

    int index = themes.indexOf(_valueTheme);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt("theme", index);
    AppModule.to.bloc<AppBloc>().loadTheme();
  }
}
