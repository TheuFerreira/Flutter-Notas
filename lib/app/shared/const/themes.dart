import 'package:flutter/material.dart';
import 'package:flutter_notas/app/shared/models/theme_model.dart';

const themes = [
  ThemeModel(
    title: 'Padrão',
    fontColor: null,
    bgColor: null,
    hintColor: null,
    bgAsset: null,
  ),
  ThemeModel(
    title: 'Blue Accent',
    fontColor: Colors.white,
    bgColor: Colors.blueAccent,
    hintColor: Color.fromARGB(125, 255, 255, 255),
    bgAsset: null,
  ),
  ThemeModel(
    title: 'Imagem',
    fontColor: Colors.white,
    bgColor: null,
    hintColor: Color.fromARGB(125, 255, 255, 255),
    bgAsset: 'assets/images/backgrounds/bg_01.jpg',
  ),
  ThemeModel(
    title: 'Imagem',
    fontColor: Colors.black,
    bgColor: null,
    hintColor: null,
    bgAsset: 'assets/images/backgrounds/bg_02.jpg',
  ),
];
