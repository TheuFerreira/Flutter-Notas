import 'package:flutter/material.dart';
import 'package:flutter_notas/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomeView(),
    );
  }
}
