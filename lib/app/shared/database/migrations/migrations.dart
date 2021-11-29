const defaultBD = [
  'CREATE TABLE [group] ( '
      'id_group INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
      'title    TEXT    NOT NULL, '
      'image    BIGINT  NOT NULL '
      ');',
  'CREATE TABLE note ( '
      'id_note INTEGER, '
      'id_group INTEGER REFERENCES [group] (id_group), '
      'title TEXT, '
      'description TEXT, '
      'last_modify DATE, '
      'theme INTEGER, '
      'status	INTEGER NOT NULL DEFAULT 1, '
      'PRIMARY KEY("id_note" AUTOINCREMENT) '
      ');',
];
const version2 = [
  "CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM note; ",
  "DROP TABLE note;",
  "CREATE TABLE note ( " +
      "id_note INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      "title TEXT, " +
      "description TEXT, " +
      "last_modify DATE, " +
      "theme INTEGER, " +
      "status NOT NULL DEFAULT (1) " +
      "); ",
  "INSERT INTO note ( " +
      "id_note, " +
      "title, " +
      "description, " +
      "last_modify, " +
      "status " +
      ") SELECT id_note, " +
      "title, " +
      "description, " +
      "last_modify, " +
      "status " +
      "FROM sqlitestudio_temp_table; ",
  "DROP TABLE sqlitestudio_temp_table;",
  "CREATE TABLE [group] ( " +
      "id_group INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      "title    TEXT    NOT NULL, " +
      "image    BIGINT  NOT NULL " +
      ");",
  "CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM note; ",
  "DROP TABLE note;",
  "CREATE TABLE note ( " +
      "id_note     INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      "id_group    INTEGER  REFERENCES [group] (id_group), " +
      "title       TEXT, " +
      "description TEXT, " +
      "last_modify DATE, " +
      "theme       INTEGER, " +
      "status               NOT NULL DEFAULT (1)  " +
      ");",
  "INSERT INTO note ( " +
      "id_note, " +
      "title, " +
      "description, " +
      "last_modify, " +
      "theme, " +
      "status " +
      ") " +
      "SELECT id_note, " +
      "title, " +
      "description, " +
      "last_modify, " +
      "theme, " +
      "status " +
      "FROM sqlitestudio_temp_table; ",
  "DROP TABLE sqlitestudio_temp_table;",
];
