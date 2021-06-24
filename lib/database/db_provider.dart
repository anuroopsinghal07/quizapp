import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return Future.value(_database);

    // If database don't exists, create one
    _database = await initDB();
    // ignore: avoid_print
    print("initDB done : $_database");
    return Future.value(_database);
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'quiz.db');
    // ignore: avoid_print
    print("db path: $path");
    return await openDatabase(path, version: 1, onOpen: (db) {
      // ignore: avoid_print
      print("db open");
    }, onCreate: (Database db, int version) async {
      // ignore: avoid_print
      print("creating table");

      await db.execute('CREATE TABLE Answer('
          'id INTEGER PRIMARY KEY,'
          'questionId TEXT,'
          'score INTEGER,'
          'time INTEGER'
          ')');
    });
  }
}
