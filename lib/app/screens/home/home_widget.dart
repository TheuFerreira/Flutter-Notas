import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/home/components/note_item.dart';
import 'package:flutter_notas/app/screens/home/home_bloc.dart';
import 'package:flutter_notas/app/screens/save/save_widget.dart';
import 'package:flutter_notas/app/shared/animations/screen_transitions.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
        actions: [
          StreamBuilder(
            stream: AppModule.to.bloc<HomeBloc>().isSelected,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool isSelected = snapshot.data as bool;

                if (isSelected) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: AppModule.to.bloc<HomeBloc>().clearSelection,
                        icon: Icon(Icons.clear),
                      ),
                      IconButton(
                        onPressed: AppModule.to.bloc<HomeBloc>().deleteSelected,
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  );
                }
              }

              return IconButton(
                onPressed: () => _toSaveScreen(context, NoteModel()),
                icon: Icon(Icons.add),
              );
            },
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
                    color: Colors.yellow,
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
                onLongPress: AppModule.to.bloc<HomeBloc>().setSelection,
              );
            },
          );
        },
      ),
    );
  }

  void _toSaveScreen(BuildContext context, NoteModel note) {
    Navigator.push(
      context,
      ScreenTransition().rightToLeft(
        context,
        SaveView(
          note,
          onAction: () async {
            await AppModule.to.bloc<HomeBloc>().findAll();
          },
        ),
      ),
    );
  }
}
