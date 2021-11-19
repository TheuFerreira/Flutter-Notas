import 'package:flutter_notas/app/shared/database/migrations/migrations.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Future<Database> getDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = dbPath + '\notas.db';

    return openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion == 2) {
          final batch = db.batch();
          version2.forEach((script) => batch.execute(script));
          await batch.commit();
        }
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    version1.forEach((script) async => db.execute(script));
  }
}
