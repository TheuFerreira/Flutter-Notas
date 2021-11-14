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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title: Text(
          'Configurações',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fonte',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder<String>(
              stream: bloc.valueFont,
              initialData: 'Roboto',
              builder: (context, snapshot) {
                String value = snapshot.data as String;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fonte Padrão: '),
                    DropdownButton<String>(
                      value: value,
                      onChanged: bloc.setFont,
                      items: bloc.fonts.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        },
                      ).toList(),
                    ),
                  ],
                );
              },
            ),
            StreamBuilder<bool>(
              stream: bloc.valueBold,
              initialData: false,
              builder: (context, snapshot) {
                bool value = snapshot.data as bool;

                return RadioButton(
                  description: 'Negrito',
                  value: value,
                  groupValue: true,
                  onChanged: bloc.setBold,
                );
              },
            ),
            StreamBuilder<bool>(
              stream: bloc.valueItalic,
              initialData: false,
              builder: (context, snapshot) {
                bool value = snapshot.data as bool;

                return RadioButton(
                  description: 'Ítalico',
                  value: value,
                  groupValue: true,
                  onChanged: bloc.setItalic,
                );
              },
            ),
            Divider(),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
