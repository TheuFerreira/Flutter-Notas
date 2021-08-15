import 'package:flutter/material.dart';
import 'package:flutter_notas/database/dao/note_dao.dart';
import 'package:flutter_notas/models/note_model.dart';
import 'package:flutter_notas/views/home/home_state.dart';

class HomeController extends ChangeNotifier {
  final NoteDAO _noteDAO = NoteDAO();
  List<NoteModel> notes = [];
  List<NoteModel> selectedNotes = [];
  HomeState homeState = HomeState.Waiting;

  bool isSelecting = false;

  void findAll() async {
    if (homeState != HomeState.Waiting) {
      homeState = HomeState.Waiting;
      notifyListeners();
    }

    notes = await _noteDAO.findAll();

    homeState = notes.length > 0 ? HomeState.Contains : HomeState.Clear;

    notifyListeners();
  }

  Future save(NoteModel note) async {
    await _noteDAO.save(note);

    findAll();
  }

  Future delete(NoteModel note) async {
    await _noteDAO.delete(note);

    findAll();
  }

  void addNewSelecting(NoteModel note) {
    selectedNotes.add(note);
    isSelecting = true;
    notifyListeners();
  }

  void removeSelected(NoteModel note) {
    selectedNotes.remove(note);

    isSelecting = selectedNotes.length > 0;
    notifyListeners();
  }

  void deleteSelecteds() async {
    selectedNotes.forEach((element) async {
      await _noteDAO.delete(element);
    });

    selectedNotes = [];
    isSelecting = false;

    findAll();
  }
}
