import 'dart:async';

import 'package:flutter_notas/app/shared/database/dao/group.dao.dart';
import 'package:flutter_notas/app/shared/database/dao/note_dao.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  List<NoteModel> _notes = [];
  final NoteDAO _noteDAO = NoteDAO();

  final _streamNotes = StreamController<List<NoteModel>>();
  Stream<List<NoteModel>> get notes => _streamNotes.stream;

  late List<GroupModel> groups = [];
  final _streamFilter = BehaviorSubject<String>();
  Stream<String> get asFilter => _streamFilter.stream;
  Sink<String> get isFilter => _streamFilter.sink;

  HomeBloc() {
    asFilter.listen((group) async {
      int index = groups.indexWhere((element) => element.title == group);
      await _findAll(groups[index]);
    });

    _startGroups();
  }

  void _startGroups() async {
    await _loadGroupModels();
    _streamFilter.add(groups[0].title!);
  }

  Future _loadGroupModels() async {
    groups = await GroupDAO().getAll();

    GroupModel allGroup = GroupModel();
    allGroup.idGroup = -1;
    allGroup.title = 'Todos';
    groups.insert(0, allGroup);
  }

  Future _findAll(GroupModel group) async {
    _notes = await _noteDAO.findAll(group);

    _streamNotes.add(_notes);
  }

  void reloadNotes() async {
    await _loadGroupModels();
    _streamFilter.add(_streamFilter.value);
  }

  @override
  void dispose() {
    super.dispose();
    _streamNotes.close();
  }
}
