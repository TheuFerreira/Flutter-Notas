import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/home/home_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(ThemeData.dark().primaryColor);
    return MaterialApp(
      title: 'Notas',
      theme: true != true
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
  }
}
