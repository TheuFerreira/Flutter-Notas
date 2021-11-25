import 'package:flutter/material.dart';

class ThemeModel {
  final String? title;
  final Color? fontColor;
  final Color? bgColor;
  final Color? hintColor;
  final String? bgAsset;

  const ThemeModel({
    this.title,
    this.fontColor,
    this.bgColor,
    this.hintColor,
    this.bgAsset,
  });
}
