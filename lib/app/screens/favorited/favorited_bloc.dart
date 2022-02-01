import 'dart:async';

import 'package:flutter_notas/app/shared/database/dao/note_dao.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class FavoritedBloc extends BlocBase {
  List<NoteModel> _notes = [];
  final NoteDAO _noteDAO = NoteDAO();

  final _streamNotes = BehaviorSubject<List<NoteModel>>();
  Stream<List<NoteModel>> get notes => _streamNotes.stream;

  FavoritedBloc() {
    findAll();
  }

  Future findAll() async {
    _notes = await _noteDAO.findAll(GroupModel(), true);

    _streamNotes.add(_notes);
  }

  @override
  void dispose() {
    super.dispose();
    _streamNotes.close();
  }
}
