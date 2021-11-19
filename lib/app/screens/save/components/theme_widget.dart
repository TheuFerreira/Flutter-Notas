import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/save/components/theme_tile_widget.dart';
import 'package:flutter_notas/app/screens/save/save_bloc.dart';

class ThemeWidget extends StatefulWidget {
  final SaveBloc bloc;
  const ThemeWidget(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              'Alterar Tema',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: StreamBuilder<int>(
              stream: widget.bloc.currentTheme,
              initialData: 0,
              builder: (context, snapshot) {
                final currentTheme = snapshot.data!;
                return Row(
                  children: themes.map((e) {
                    int currentIndex = themes.indexOf(e);
                    return ThemeTileWidget(
                      title: e.title,
                      fontColor: e.fontColor,
                      bgColor: e.bgColor,
                      bgAsset: e.bgAsset,
                      currentIndex: currentIndex,
                      isSelected: currentIndex == currentTheme,
                      onTap: (i) {
                        widget.bloc.changeTheme(i);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class OptionTheme {
  final String? title;
  final Color? fontColor;
  final Color? bgColor;
  final String? bgAsset;

  const OptionTheme({this.title, this.fontColor, this.bgColor, this.bgAsset});
}

const themes = [
  OptionTheme(
    title: 'Padrão',
    fontColor: null,
    bgColor: null,
    bgAsset: null,
  ),
  OptionTheme(
    title: 'Blue Accent',
    fontColor: Colors.white,
    bgColor: Colors.blueAccent,
    bgAsset: null,
  ),
  OptionTheme(
    title: 'Imagem',
    fontColor: Colors.white,
    bgColor: null,
    bgAsset: 'assets/images/backgrounds/bg_01.jpg',
  ),
  OptionTheme(
    title: 'Imagem',
    fontColor: Colors.black,
    bgColor: null,
    bgAsset: 'assets/images/backgrounds/bg_02.jpg',
  ),
];
