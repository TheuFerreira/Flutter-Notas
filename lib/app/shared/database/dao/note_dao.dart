import 'package:flutter_notas/app/shared/database/app_database.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteDAO {
  final AppDatabase _appDatabase = AppDatabase();

  Future<List<NoteModel>> findAll() async {
    Database db = await _appDatabase.getDatabase();
    List<Map<String, dynamic>> result =
        await db.query('note', where: 'status = 1');
    List<NoteModel> notes =
        result.map((json) => NoteModel.fromJson(json)).toList();

    return notes;
  }

  Future delete(NoteModel note) async {
    Database db = await _appDatabase.getDatabase();
    await db.execute(
      'UPDATE note SET status = 0 WHERE id_note = ?',
      [note.id],
    );
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
    await db.insert('note', note.toJson());
  }

  Future _update(NoteModel note) async {
    Database db = await _appDatabase.getDatabase();
    await db.update(
      'note',
      note.toJson(),
      where: 'id_note = ?',
      whereArgs: [note.id],
    );
  }
}
