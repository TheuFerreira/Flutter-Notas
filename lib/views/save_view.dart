import 'package:flutter/material.dart';
import 'package:flutter_notas/models/note_model.dart';

import 'package:provider/provider.dart';

import 'home/home_controller.dart';

class SaveView extends StatefulWidget {
  final NoteModel note;

  const SaveView(this.note, {Key? key}) : super(key: key);

  @override
  _SaveViewState createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    if (widget.note.id != null) {
      _titleController.text = widget.note.title!;
      _descriptionController.text = widget.note.description!;
    }

    _isEditing = widget.note.id != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Anotação' : 'Nova Anotação',
        ),
        actions: [
          if (_isEditing)
            IconButton(
              onPressed: () => _deleteNote(controller),
              icon: Icon(Icons.delete),
            ),
          IconButton(
            onPressed: () => _saveNote(controller),
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
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Título',
                ),
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                controller: _descriptionController,
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

  void _deleteNote(HomeController controller) async {
    await controller.delete(widget.note);

    Navigator.pop(context, true);
  }

  void _saveNote(HomeController controller) async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    if (description == '' && title == '') {
      Navigator.pop(context);
      return;
    }

    widget.note.title = title;
    widget.note.description = description;

    await controller.save(widget.note);

    Navigator.pop(context, true);
  }
}
