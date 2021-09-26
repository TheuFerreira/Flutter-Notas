import 'dart:async';

import 'package:flutter_notas/app/shared/database/dao/note_dao.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class HomeBloc extends BlocBase {
  List<NoteModel> _notes = [];
  final NoteDAO _noteDAO = NoteDAO();

  final StreamController<List<NoteModel>> _streamNotes = StreamController();
  Stream<List<NoteModel>> get notes => _streamNotes.stream;

  HomeBloc() {
    findAll();
  }

  Future findAll() async {
    _notes = await _noteDAO.findAll();

    _streamNotes.add(_notes);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
