import 'dart:async';

import 'package:flutter_notas/app/shared/database/dao/group.dao.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
import 'package:rxdart/rxdart.dart';

class GroupBloc {
  final _dao = GroupDAO();
  late List<GroupModel> _groups = [];
  late List<int> _selectedGroups = [];

  final _streamGroups = StreamController<List<GroupModel>>();
  Stream<List<GroupModel>> get asGroups => _streamGroups.stream;

  final _streamSelectedGroups = BehaviorSubject<List<int>>();
  Stream<List<int>> get asSelectedGroups => _streamSelectedGroups.stream;

  GroupBloc() {
    getAll();
  }

  void getAll() async {
    _groups = await _dao.getAll();
    _streamGroups.add(_groups);
  }

  void changeSelectionGroup(GroupModel group) {
    int index = _groups.indexOf(group);

    if (_selectedGroups.contains(index)) {
      _selectedGroups.remove(index);
    } else {
      _selectedGroups.add(index);
    }

    _streamSelectedGroups.add(_selectedGroups);
  }

  void deleteSelectedGroups() async {
    List<GroupModel> groupsToDelete = [];
    for (int i in _selectedGroups) {
      groupsToDelete.add(_groups[i]);
      _groups.removeAt(i);
    }

    await _dao.deleteList(groupsToDelete);

    _streamGroups.add(_groups);

    _selectedGroups = [];
    _streamSelectedGroups.add(_selectedGroups);
  }
}
