import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('meeting.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE meetings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      date TEXT,
      responsible TEXT,
      status TEXT,
      summary TEXT,
      note TEXT
    )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await instance.database;
    return db.insert('meetings', row);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await instance.database;
    return db.query('meetings', orderBy: 'date DESC');
  }

  Future<int> update(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return db.update(
      'meetings',
      row,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      'meetings',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}