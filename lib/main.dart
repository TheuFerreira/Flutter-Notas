import 'package:flutter/material.dart';
import 'package:flutter_notas/views/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomeView(),
    );
  }
}
