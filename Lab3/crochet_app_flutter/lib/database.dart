import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'first_page.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'pattern.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE crochet_patterns(
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT,
          category TEXT,
          level INTEGER
      )
      ''');
  }

  Future<List<CrochetPattern>> getPatterns() async {
    Database db = await instance.database;
    var patterns = await db.query('crochet_patterns', orderBy: 'name');
    List<CrochetPattern> patternsList = patterns.isNotEmpty
        ? patterns.map((c) => CrochetPattern.fromMap(c)).toList()
        : [];
    return patternsList;
  }

  Future<int> add(CrochetPattern pattern) async {
    Database db = await instance.database;
    return await db.insert('crochet_patterns', pattern.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('crochet_patterns', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(CrochetPattern pattern) async {
    Database db = await instance.database;
    return await db.update('crochet_patterns', pattern.toMap(),
        where: "id = ?", whereArgs: [pattern.id]);
  }
}