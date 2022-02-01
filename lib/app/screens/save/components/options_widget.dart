import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  final bool? showShare;
  final bool isFavorited;
  final Function()? themeTap;
  final Function()? shareTap;
  final Function(int)? favoriteTap;
  const OptionsWidget({
    Key? key,
    this.showShare,
    this.isFavorited = false,
    this.themeTap,
    this.shareTap,
    this.favoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              'Opções',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.palette),
          title: Text('Tema'),
          onTap: themeTap,
        ),
        Visibility(
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartilhar'),
            onTap: shareTap,
          ),
          visible: showShare!,
        ),
        Visibility(
          child: isFavorited == false
              ? ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Favoritar'),
                  onTap: () => favoriteTap!(1),
                )
              : ListTile(
                  leading: Icon(Icons.star_outline),
                  title: Text('Remover dos Favoritos'),
                  onTap: () => favoriteTap!(0),
                ),
          visible: showShare!,
        ),
      ],
    );
  }
}
