import 'package:flutter_notas/app/shared/database/app_database.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class GroupDAO {
  final _db = AppDatabase();

  Future<List<GroupModel>> getAll() async {
    final db = await _db.getDatabase();
    final result = await db.query('group');

    final List<GroupModel> groups = [];
    for (Map<String, dynamic> map in result) {
      GroupModel group = GroupModel.fromJson(map);
      groups.add(group);
    }

    return groups;
  }

  Future save(GroupModel group) async {
    if (group.idGroup == null) {
      await _insert(group);
    } else {
      await _update(group);
    }
  }

  Future _insert(GroupModel group) async {
    final db = await _db.getDatabase();

    final json = group.toJson();
    json.remove('id_group');

    db.insert('group', json);
  }

  Future _update(GroupModel group) async {
    final db = await _db.getDatabase();
    final json = group.toJson();

    await db.update(
      'group',
      json,
      where: "id_group = ?",
      whereArgs: [group.idGroup],
    );
  }
}
