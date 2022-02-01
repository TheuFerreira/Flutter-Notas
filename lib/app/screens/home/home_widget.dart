import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/favorited/favorited_widget.dart';
import 'package:flutter_notas/app/screens/group/group_widget.dart';
import 'package:flutter_notas/app/screens/home/home_bloc.dart';
import 'package:flutter_notas/app/screens/save/save_widget.dart';
import 'package:flutter_notas/app/screens/settings/settings_widget.dart';
import 'package:flutter_notas/app/shared/animations/screen_transitions.dart';
import 'package:flutter_notas/app/shared/components/note_item.dart';
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
            onPressed: () async {
              await Navigator.of(context).push(
                ScreenTransition().rightToLeft(
                  context,
                  FavoritedWidget(),
                ),
              );

              AppModule.to.bloc<HomeBloc>().reloadNotes();
            },
            icon: Icon(
              Icons.star,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          IconButton(
            onPressed: () => _toGroupScreen(context),
            icon: Icon(
              Icons.layers,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filtrar',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  StreamBuilder<String>(
                    stream: AppModule.to.bloc<HomeBloc>().asFilter,
                    initialData: "Total",
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            strokeWidth: 2,
                          ),
                        );
                      }

                      final value = snapshot.data;
                      return DropdownButton<String>(
                        onChanged: (selectedGroup) => AppModule.to
                            .bloc<HomeBloc>()
                            .isFilter
                            .add(selectedGroup!),
                        underline: SizedBox(),
                        value: value,
                        items: AppModule.to
                            .bloc<HomeBloc>()
                            .groups
                            .map(
                              (e) => DropdownMenuItem<String>(
                                key: UniqueKey(),
                                child: Text(e.title!),
                                value: e.title!,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: StreamBuilder<List<NoteModel>>(
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _toSaveScreen(context, NoteModel()),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).iconTheme.color,
      ),
    );
  }

  void _toGroupScreen(BuildContext context) async {
    await Navigator.of(context).push(
      ScreenTransition().rightToLeft(
        context,
        GroupWidget(),
      ),
    );

    AppModule.to.bloc<HomeBloc>().reloadNotes();
  }

  void _toSaveScreen(BuildContext context, NoteModel note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) {
          return SaveView(
            note,
            onAction: () {
              AppModule.to.bloc<HomeBloc>().reloadNotes();
            },
          );
        },
      ),
    );
  }
}
