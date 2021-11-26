import 'dart:async';

import 'package:flutter_notas/app/shared/database/dao/group.dao.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class GroupBloc {
  final _dao = GroupDAO();

  final _streamGroups = StreamController<List<GroupModel>>();
  Stream<List<GroupModel>> get asGroups => _streamGroups.stream;

  GroupBloc() {
    getAll();
  }

  void getAll() async {
    final result = await _dao.getAll();
    _streamGroups.add(result);
  }
}
