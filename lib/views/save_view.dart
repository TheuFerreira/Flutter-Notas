import 'package:flutter/material.dart';
import 'package:flutter_notas/database/dao/note_dao.dart';
import 'package:flutter_notas/models/note_model.dart';

class SaveView extends StatefulWidget {
  final NoteModel note;

  const SaveView(this.note, {Key? key}) : super(key: key);

  @override
  _SaveViewState createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final NoteDAO _noteDAO = NoteDAO();
  bool _isEditing = false;

  @override
  void initState() {
    if (widget.note.id != null) {
      String? title = widget.note.title;

      _titleController.text = title == null ? '' : title;
      _descriptionController.text = widget.note.description!;
    }

    _isEditing = widget.note.id != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Anotação' : 'Nova Anotação',
        ),
        actions: [
          if (_isEditing)
            IconButton(
              onPressed: () async {
                await _noteDAO.delete(widget.note);

                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
              ),
            ),
          IconButton(
            onPressed: () async {
              String title = _titleController.text;
              String description = _descriptionController.text;

              if (description == '') {
                Navigator.pop(context);
                return;
              }

              widget.note.title = title == '' ? null : title;
              widget.note.description = description;

              await _noteDAO.save(widget.note);

              Navigator.pop(context, true);
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
              SizedBox(height: 8.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Título',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: 'Descrição',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
