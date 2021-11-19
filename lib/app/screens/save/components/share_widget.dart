import 'package:flutter/material.dart';

class ShareWidget extends StatelessWidget {
  final Function()? fileTap;
  final Function()? copyTap;
  const ShareWidget({
    Key? key,
    this.fileTap,
    this.copyTap,
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
              'Compartilhar como',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        ListTile(
          onTap: fileTap,
          leading: Icon(Icons.file_present),
          title: Text('Arquivo TXT'),
        ),
        ListTile(
          onTap: copyTap,
          leading: Icon(Icons.text_snippet),
          title: Text('Texto Copiável'),
        ),
      ],
    );
  }
}
