import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/settings/settings_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  SettingsBloc bloc = SettingsBloc();

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
            StreamBuilder<String>(
                stream: bloc.valueTheme,
                initialData: 'Sistema (automático)',
                builder: (context, snapshot) {
                  String valueTheme = snapshot.data as String;

                  return RadioGroup<String>.builder(
                    spacebetween: 45,
                    groupValue: valueTheme,
                    items: bloc.themes,
                    itemBuilder: (item) => RadioButtonBuilder(item),
                    onChanged: bloc.setTheme,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
