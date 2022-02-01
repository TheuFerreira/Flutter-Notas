import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notas/app/shared/database/dao/group.dao.dart';
import 'package:flutter_notas/app/shared/database/dao/note_dao.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

class SaveBloc {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final NoteDAO _noteDAO = NoteDAO();

  late int _currentTheme;
  final _streamCurrentTheme = BehaviorSubject<int>();
  Stream<int> get currentTheme => _streamCurrentTheme.stream;

  late List<GroupModel> _groups = [];
  final _streamGroups = BehaviorSubject<List<GroupModel>>();
  Stream<List<GroupModel>> get groups => _streamGroups.stream;

  late GroupModel? _currentGroup;
  final _streamSelectedGroup = BehaviorSubject<GroupModel?>();
  Stream<GroupModel?> get currentGroup => _streamSelectedGroup.stream;

  SaveBloc() {
    getAllGroups();
  }

  void getAllGroups() async {
    _groups = await GroupDAO().getAll();

    final noneGroup = GroupModel();
    noneGroup.title = "Sem Grupo";
    _groups.insert(0, noneGroup);

    _streamGroups.add(_groups);
  }

  setValues(NoteModel note) {
    _currentTheme = 0;
    _currentGroup = null;

    if (note.id != null) {
      titleController.text = note.title!;
      descriptionController.text = note.description!;
      _currentTheme = note.theme == null ? 0 : note.theme!;
      _currentGroup = note.group;
    }

    _streamCurrentTheme.add(_currentTheme);
    _streamSelectedGroup.add(_currentGroup);
  }

  void save(BuildContext context, NoteModel note) async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title != '' || description != '') {
      note.title = title.trim();
      note.description = description.trim();
      note.lastModify = DateTime.now();
      note.theme = _currentTheme;
      note.group = _currentGroup;

      await _noteDAO.save(note);
    }

    Navigator.pop(context);
  }

  Future favorite(NoteModel note, int value) async {
    note.favorited = value;
    await _noteDAO.favorite(note);
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

  void changeTheme(int? newTheme) {
    _currentTheme = newTheme!;
    _streamCurrentTheme.add(newTheme);
  }

  void changeSelectedGroup(GroupModel group) {
    _currentGroup = group;
    if (_groups.indexOf(group) == 0) {
      _currentGroup = null;
    }

    _streamSelectedGroup.add(_currentGroup);
  }
}
