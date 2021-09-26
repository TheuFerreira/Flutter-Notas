import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notas/app/screens/save/save_bloc.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:flutter_notas/app/shared/services/dialog_service.dart';

class SaveView extends StatefulWidget {
  final NoteModel note;
  final Function()? onAction;

  SaveView(
    this.note, {
    Key? key,
    this.onAction,
  }) : super(key: key);

  @override
  _SaveViewState createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  final SaveBloc bloc = SaveBloc();
  final DialogService _dialogSerice = DialogService();

  @override
  void initState() {
    bloc.setValues(widget.note);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title: Text(
          widget.note.id != null ? 'Editar Anotação' : 'Nova Anotação',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          if (widget.note.id != null)
            IconButton(
              onPressed: () async {
                var result = await _dialogSerice.showAlertDialog(
                    context,
                    'Confirmação',
                    'Tem certeza de que deseja excluir as notas selecionadas?');

                if (result == null) {
                  return;
                }

                bloc.delete(context, widget.note);
                widget.onAction!();
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          IconButton(
            onPressed: () {
              bloc.save(context, widget.note);
              widget.onAction!();
            },
            icon: Icon(
              Icons.check,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
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
      floatingActionButton: widget.note.id != null
          ? FloatingActionButton(
              onPressed: _showModalBottomSheet,
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
              onTap: () async {
                await bloc.shareFile();

                Navigator.pop(context);
              },
              leading: Icon(Icons.file_present),
              title: Text('Arquivo TXT'),
            ),
            ListTile(
              onTap: () {
                bloc.copyText();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Descrição da nota copiado com sucesso!!!'),
                        ],
                      ),
                    ),
                  ),
                );
              },
              leading: Icon(Icons.text_snippet),
              title: Text('Texto Copiável'),
            ),
          ],
        );
      },
    );
  }
}
