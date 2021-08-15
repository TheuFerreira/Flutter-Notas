import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_widget.dart';
import 'package:flutter_notas/app/screens/home/home_bloc.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => HomeBloc())];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
