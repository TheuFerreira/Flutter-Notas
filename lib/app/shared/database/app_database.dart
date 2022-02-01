import 'package:flutter_notas/app/shared/database/migrations/migrations.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Future<Database> getDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = dbPath + '\notas.db';

    return openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion == 2) {
          await executeV2(db);
        } else if (newVersion == 3) {
          await executeV3(db, oldVersion);
        }
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    defaultBD.forEach((script) async => db.execute(script));
  }

  Future executeV3(Database db, int oldVersion) async {
    if (oldVersion < 2) {
      await executeV2(db);
    }

    final batch = db.batch();
    version3.forEach((script) => batch.execute(script));
    await batch.commit();
  }

  Future executeV2(Database db) async {
    final batch = db.batch();
    version2.forEach((script) => batch.execute(script));
    await batch.commit();
  }
}
