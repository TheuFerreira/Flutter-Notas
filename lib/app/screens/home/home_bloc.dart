import 'dart:async';

import 'package:flutter_notas/app/shared/database/dao/note_dao.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class HomeBloc extends BlocBase {
  List<NoteModel> _notes = [];
  List<NoteModel> _selectedNotes = [];
  final NoteDAO _noteDAO = NoteDAO();
  bool _isSelected = false;

  final StreamController<List<NoteModel>> _streamNotes = StreamController();
  Stream<List<NoteModel>> get notes => _streamNotes.stream;

  final StreamController<bool> _streamIsSelected = StreamController<bool>();
  Stream<bool> get isSelected => _streamIsSelected.stream;

  HomeBloc() {
    findAll();
  }

  Future findAll() async {
    _notes = await _noteDAO.findAll();

    _streamNotes.add(_notes);
  }

  void setSelection(NoteModel note) {
    int index = _selectedNotes.indexOf(note);
    if (index == -1) {
      _selectedNotes.add(note);
    } else {
      _selectedNotes.remove(note);
    }

    _isSelected = _selectedNotes.length > 0;
    _streamIsSelected.add(_isSelected);
  }

  void clearSelection() {
    _streamNotes.add(_notes);

    _selectedNotes = [];
    _isSelected = _selectedNotes.length > 0;
    _streamIsSelected.add(_isSelected);
  }

  void deleteSelected() {
    _selectedNotes.forEach((element) async {
      _notes.remove(element);
      await _noteDAO.delete(element);
    });
    _streamNotes.add(_notes);

    _selectedNotes = [];
    _isSelected = _selectedNotes.length > 0;
    _streamIsSelected.add(_isSelected);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
