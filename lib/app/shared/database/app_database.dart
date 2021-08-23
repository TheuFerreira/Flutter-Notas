import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Future<Database> getDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = dbPath + '\notas.db';

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''
        'CREATE TABLE note ( '
        'id_note INTEGER, '
        'title TEXT, '
        'description TEXT, '
        'last_modify DATE, '
        'status	INTEGER NOT NULL DEFAULT 1, '
        'PRIMARY KEY("id_note" AUTOINCREMENT) '
        ');');
  }
}
