import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_bloc.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/home/home_widget.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppModule.to.bloc<AppBloc>().loadTheme();

    return StreamBuilder<bool>(
        stream: AppModule.to.bloc<AppBloc>().isDarkMode,
        initialData: false,
        builder: (context, snapshot) {
          bool isDarkMode = snapshot.data as bool;

          return MaterialApp(
            title: 'Notas',
            theme: isDarkMode
                ? ThemeData(
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
