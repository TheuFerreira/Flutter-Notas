import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  final bool? showShare;
  final Function()? themeTap;
  final Function()? shareTap;
  const OptionsWidget({
    Key? key,
    this.showShare,
    this.themeTap,
    this.shareTap,
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
      ],
    );
  }
}
