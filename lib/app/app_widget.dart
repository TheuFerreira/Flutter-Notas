import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_bloc.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/home/home_widget.dart';
import 'package:flutter_notas/app/shared/models/settings_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppModule.to.bloc<AppBloc>().loadSettings();

    return StreamBuilder<SettingsModel>(
      stream: AppModule.to.bloc<AppBloc>().settings,
      initialData: SettingsModel(),
      builder: (context, snapshot) {
        SettingsModel settings = snapshot.data as SettingsModel;

        return MaterialApp(
          title: 'Notas',
          theme: settings.isDark ? _darkTheme(settings) : _lightTheme(settings),
          home: HomeWidget(),
        );
      },
    );
  }

  ThemeData _darkTheme(SettingsModel settings) {
    return ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 30, 30, 30),
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      fontFamily: _getFontFamily(settings),
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        secondary: Color(0xFFFFEA00),
        brightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 80, 80, 80),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      cardColor: Color.fromARGB(255, 60, 60, 60),
    );
  }

  ThemeData _lightTheme(SettingsModel settings) {
    return ThemeData(
      fontFamily: _getFontFamily(settings),
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: Colors.white,
        secondary: Color(0xFFFFEA00),
        brightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 150, 150, 150),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
      dividerColor: Colors.black54,
      cardColor: Colors.white,
    );
  }

  String? _getFontFamily(SettingsModel settings) {
    return GoogleFonts.getFont(
      settings.font,
      fontStyle: settings.isItalic ? FontStyle.italic : FontStyle.normal,
      fontWeight: settings.isBold ? FontWeight.w700 : FontWeight.normal,
    ).fontFamily;
  }
}
