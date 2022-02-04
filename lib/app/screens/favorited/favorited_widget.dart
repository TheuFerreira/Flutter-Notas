import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/favorited/favorited_bloc.dart';
import 'package:flutter_notas/app/screens/save/save_widget.dart';
import 'package:flutter_notas/app/shared/components/note_item.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';

class FavoritedWidget extends StatefulWidget {
  const FavoritedWidget({Key? key}) : super(key: key);

  @override
  _FavoritedWidgetState createState() => _FavoritedWidgetState();
}

class _FavoritedWidgetState extends State<FavoritedWidget> {
  @override
  void initState() {
    super.initState();

    AppModule.to.bloc<FavoritedBloc>().findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.close,
          ),
        ),
        title: Text(
          'Favoritos',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: AppModule.to.bloc<FavoritedBloc>().notes,
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
                    Icons.star,
                    size: 64.0,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    'Nenhuma nota favoritada',
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
    );
  }

  void _toSaveScreen(BuildContext context, NoteModel note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) {
          return SaveView(
            note,
            onAction: () {
              AppModule.to.bloc<FavoritedBloc>().findAll();
            },
          );
        },
      ),
    );
  }
}
