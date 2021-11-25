import 'package:flutter/material.dart';
import 'package:flutter_notas/app/shared/models/theme_model.dart';

const themes = [
  ThemeModel(
    title: 'Padrão',
    fontColor: null,
    bgColor: null,
    hintColor: null,
    lastModifyColor: null,
    bgAsset: null,
  ),
  ThemeModel(
    title: 'Blue Accent',
    fontColor: Colors.white,
    bgColor: Colors.blueAccent,
    hintColor: Color.fromARGB(125, 255, 255, 255),
    lastModifyColor: Color.fromARGB(200, 255, 255, 255),
    bgAsset: null,
  ),
  ThemeModel(
    title: 'Imagem',
    fontColor: Colors.white,
    bgColor: null,
    hintColor: Color.fromARGB(125, 255, 255, 255),
    lastModifyColor: Color.fromARGB(200, 255, 255, 255),
    bgAsset: 'assets/images/backgrounds/bg_01.jpg',
  ),
  ThemeModel(
    title: 'Imagem',
    fontColor: Colors.black,
    bgColor: Color.fromARGB(255, 0, 0, 0),
    hintColor: Color.fromARGB(125, 0, 0, 0),
    lastModifyColor: Color.fromARGB(200, 0, 0, 0),
    bgAsset: 'assets/images/backgrounds/bg_02.jpg',
  ),
];
