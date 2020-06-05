import 'dart:async';

import 'package:assignment2/DictionaryModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperSql {
  static final DatabaseHelperSql _instance = new DatabaseHelperSql.internal();

  factory DatabaseHelperSql() => _instance;

  final String tableContacts = 'contacts';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnPhoneNumber = 'phoneNumber';
  final String columnLandLine = 'landLine';
  final String columnImage = 'image';
  final bool columnFavourites = false;
  static Database _db;

  DatabaseHelperSql.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db
        .execute('CREATE TABLE $tableContacts($columnId INTEGER PRIMARY KEY,'
            ' $columnName TEXT,'
            ' $columnPhoneNumber TEXT'
            ', $columnLandLine TEXT'
            ', $columnFavourites INTEGER DEFAULT 0'
            ', $columnImage TEXT)');
  }

  Future<int> saveNote(DictionaryModel note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableContacts, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableContacts,
        columns: [columnId, columnName, columnPhoneNumber]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableContacts'));
  }

  Future<DictionaryModel> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableContacts,
        columns: [columnId, columnName, columnPhoneNumber],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new DictionaryModel.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableContacts, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(DictionaryModel note) async {
    var dbClient = await db;
    return await dbClient.update(tableContacts, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.name]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<DictionaryModel> getFavourites() async {
    var dbClient = await db;

    var result = await dbClient.rawQuery(
        'SELECT * FROM $tableContacts WHERE $columnFavourites = true');

    if (result.length > 0) {
      return new DictionaryModel.fromMap(result.first);
    }

    return null;
  }
}
