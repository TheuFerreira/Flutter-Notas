import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/home/components/note_item.dart';
import 'package:flutter_notas/app/screens/home/home_bloc.dart';
import 'package:flutter_notas/app/screens/save/save_widget.dart';
import 'package:flutter_notas/app/screens/settings/settings_widget.dart';
import 'package:flutter_notas/app/shared/animations/screen_transitions.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notas',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                ScreenTransition().rightToLeft(
                  context,
                  SettingsWidget(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: AppModule.to.bloc<HomeBloc>().notes,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Carregando',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.bookmark,
                    size: 64.0,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    'Nenhuma nota encontrada',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            );
          }

          List<NoteModel> notes = snapshot.data as List<NoteModel>;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              NoteModel note = notes[index];

              return NoteItem(
                note,
                key: UniqueKey(),
                onTap: () => _toSaveScreen(context, note),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _toSaveScreen(context, NoteModel()),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _toSaveScreen(BuildContext context, NoteModel note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) {
          return SaveView(
            note,
            onAction: () async {
              await AppModule.to.bloc<HomeBloc>().findAll();
            },
          );
        },
      ),
    );
  }
}
