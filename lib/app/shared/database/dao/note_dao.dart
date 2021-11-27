import 'package:flutter_notas/app/shared/database/app_database.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteDAO {
  final AppDatabase _appDatabase = AppDatabase();

  Future<List<NoteModel>> findAll(GroupModel group) async {
    Database db = await _appDatabase.getDatabase();
    List<Map<String, dynamic>> result = await db
        .rawQuery(
          "SELECT " +
              "n.id_note, n.title, n.description, n.last_modify, n.theme, " +
              "g.id_group, g.title AS g_title, g.image " +
              "FROM note AS n " +
              "LEFT JOIN 'group' AS g ON g.id_group = n.id_group " +
              "WHERE status = 1 " +
              (group.idGroup! == -1 ? "" : "AND ? = g.id_group ") +
              "ORDER BY last_modify DESC;",
          group.idGroup! == -1
              ? []
              : [
                  group.idGroup,
                ],
        )
        .timeout(Duration(seconds: 5));
    List<NoteModel> notes =
        result.map((json) => NoteModel.fromJson(json)).toList();

    return notes;
  }

  Future delete(NoteModel note) async {
    Database db = await _appDatabase.getDatabase();
    await db.execute(
      'UPDATE note SET status = 0 WHERE id_note = ?',
      [note.id],
    ).timeout(Duration(seconds: 5));
  }

  Future save(NoteModel note) async {
    if (note.id == null) {
      await _insert(note);
    } else {
      await _update(note);
    }
  }

  Future _insert(NoteModel note) async {
    Database db = await _appDatabase.getDatabase();
    await db
        .insert(
          'note',
          note.toJson(),
        )
        .timeout(Duration(seconds: 5));
  }

  Future _update(NoteModel note) async {
    Database db = await _appDatabase.getDatabase();
    await db.update(
      'note',
      note.toJson(),
      where: 'id_note = ?',
      whereArgs: [note.id],
    ).timeout(Duration(seconds: 5));
  }
}
