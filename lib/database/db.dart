import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DictionaryDatabase {
  var _database;

  DictionaryDatabase._privateConstructor();
  static final DictionaryDatabase instance =
      DictionaryDatabase._privateConstructor();

  Future get database async {
    if (_database != null) return _database;

    _database = await _initializeDb();
    return _database;
  }

  _initializeDb() async {
    String directory = await databaseFactory.getDatabasesPath();
    String path = join(directory, 'dictionary.db');

    await deleteDatabase(path);
    ByteData data = await rootBundle.load("assets/db/dictionary.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);

    return await openDatabase(path, version: 1);
  }

  Future<List> getEnglishWords() async {
    Database db = await instance.database;

    return await db.query('dictionary',
        columns: ["english_word"], orderBy: "english_word ASC");
  }

  Future<List> getMalayalamWordsWithDefinition() async {
    Database db = await instance.database;

    return await db.query('dictionary', orderBy: "malayalam_word ASC");
  }
}
