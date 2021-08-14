import 'package:flutter/material.dart';
import 'package:flutter_notas/database/dao/note_dao.dart';
import 'package:flutter_notas/models/note_model.dart';

class HomeController extends ChangeNotifier {
  final NoteDAO _noteDAO = NoteDAO();

  bool isSelecting = false;

  Future<List<NoteModel>> findAll() async {
    return await _noteDAO.findAll();
  }
}
