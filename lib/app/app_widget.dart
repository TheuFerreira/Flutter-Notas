import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/home/home_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomeWidget(),
    );
  }
}
