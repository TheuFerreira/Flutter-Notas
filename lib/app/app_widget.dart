import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_bloc.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/home/home_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppModule.to.bloc<AppBloc>().loadTheme();

    return StreamBuilder<List<dynamic>>(
        stream: AppModule.to.bloc<AppBloc>().settings,
        initialData: [false, 'Roboto', false, false],
        builder: (context, snapshot) {
          List<dynamic> values = snapshot.data as List<dynamic>;
          bool isDarkMode = values[0] as bool;
          String font = values[1] as String;
          bool bold = values[2] as bool;
          bool italic = values[3] as bool;

          return MaterialApp(
            title: 'Notas',
            theme: isDarkMode
                ? ThemeData(
                    fontFamily: GoogleFonts.getFont(
                      font,
                      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                      fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                    ).fontFamily,
                    brightness: Brightness.dark,
                    accentColor: Colors.yellowAccent[400],
                    accentColorBrightness: Brightness.dark,
                    iconTheme: IconThemeData(
                      color: Colors.yellowAccent[400],
                    ),
                    textTheme: TextTheme(
                      bodyText1: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : ThemeData(
                    fontFamily: GoogleFonts.getFont(
                      font,
                      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                      fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                    ).fontFamily,
                    brightness: Brightness.light,
                    primaryColor: Colors.white,
                    accentColor: Colors.yellowAccent[400],
                    accentColorBrightness: Brightness.light,
                    iconTheme: IconThemeData(
                      color: Colors.yellowAccent[400],
                    ),
                    textTheme: TextTheme(
                      bodyText1: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
            home: HomeWidget(),
          );
        });
  }
}
