import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notas/app/shared/database/dao/note_dao.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SaveBloc {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final NoteDAO _noteDAO = NoteDAO();

  SaveBloc();

  setValues(NoteModel note) {
    if (note.id != null) {
      titleController.text = note.title!;
      descriptionController.text = note.description!;
    }
  }

  void save(BuildContext context, NoteModel note) async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title != '' || description != '') {
      note.title = title.trim();
      note.description = description.trim();
      note.lastModify = DateTime.now();

      await _noteDAO.save(note);
    }

    Navigator.pop(context);
  }

  void delete(BuildContext context, NoteModel note) async {
    await _noteDAO.delete(note);

    Navigator.pop(context);
  }

  Future shareFile() async {
    Directory temporaryDirectory = await getTemporaryDirectory();
    String path = temporaryDirectory.path + "/nota.txt";

    File file = File(path);
    file.writeAsString(descriptionController.text);

    await Share.shareFiles([path]);
  }

  void copyText() {
    Clipboard.setData(ClipboardData(text: descriptionController.text));
  }
}
