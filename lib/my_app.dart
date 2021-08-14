import 'package:flutter/material.dart';
import 'package:flutter_notas/views/home/home_controller.dart';
import 'package:flutter_notas/views/home/home_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
      ],
      child: MaterialApp(
        title: 'Notas',
        theme: ThemeData(primaryColor: Colors.white),
        home: HomeView(),
      ),
    );
  }
}
