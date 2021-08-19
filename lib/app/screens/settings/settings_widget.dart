import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final List<String> typeThemes = ['Sistema (automático)', 'Claro', 'Escuro'];

  int selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tema Padrão',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioGroup<String>.builder(
              spacebetween: 45,
              groupValue: typeThemes[selectedTheme],
              items: typeThemes,
              itemBuilder: (item) => RadioButtonBuilder(item),
              onChanged: (value) {
                final int index = typeThemes.indexOf(value!);

                setState(() => selectedTheme = index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
