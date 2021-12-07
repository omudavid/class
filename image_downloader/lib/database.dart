import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'image_dao.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database?> initializeDatabase() async {
    var dir = await getDatabasesPath();
    final dbLocation = dir + 'image.db';

    if (!await Directory(dirname(dbLocation)).exists()) {
      try {
        await Directory(dirname(dbLocation)).create(recursive: true);
      } catch (e) {
        log('Error in  creating db $e');
      }
    }

    return await openDatabase(dbLocation, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE images (
      id INTEGER PRIMARY KEY,
      imageUrl TEXT
      )
     ''');
    }, version: 1);
  }

  Future<int?> addToDataBase(ImageDao image) async {
    final db = await database;
    final res = await db?.insert('images', image.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<ImageDao>> retrieveFromDataBase() async {
    final db = await database;
    final res = await db?.query('images');

    return res?.map((e) => ImageDao.fromJson(e)).toList() ?? [];
  }
}
