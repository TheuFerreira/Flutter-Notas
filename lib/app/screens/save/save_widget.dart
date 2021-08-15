import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/save/save_bloc.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';

class SaveView extends StatelessWidget {
  final NoteModel note;
  final SaveBloc bloc = SaveBloc();
  final Function()? onAction;

  SaveView(
    this.note, {
    Key? key,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.id != null ? 'Editar Anotação' : 'Nova Anotação',
        ),
        actions: [
          if (note.id != null)
            IconButton(
              onPressed: () {
                bloc.delete(context, note);
                onAction!();
              },
              icon: Icon(Icons.delete),
            ),
          IconButton(
            onPressed: () {
              bloc.save(context, note);
              onAction!();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                controller: bloc.titleController,
                decoration: InputDecoration(
                  hintText: 'Título',
                ),
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                controller: bloc.descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: 'Descrição',
                ),
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
