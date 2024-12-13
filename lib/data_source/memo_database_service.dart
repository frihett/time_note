import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_note/model/memo.dart';

class MemoDatabaseService {
  static final MemoDatabaseService instance =
      MemoDatabaseService._privateConstructor();
  static Database? _database;

  MemoDatabaseService._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'memos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE memos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT NOT NULL,
            content TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Memo>> getMemosByDate(DateTime date) async {
    final db = await database;
    final formattedDate =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final result = await db.query(
      'memos',
      where: 'date LIKE ?',
      whereArgs: ['$formattedDate%'],
    );
    return result.map((map) => Memo.fromMap(map)).toList();
  }

  Future<Memo> insertMemo(Memo memo) async {
    final db = await database;
    memo.id = await db.insert('memos', memo.toMap());
    return memo;
  }

  Future<int> deleteMemo(int id) async {
    final db = await database;
    return await db.delete(
      'memos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateMemo(int id, String content) async {
    final db = await database;
    return await db.update(
      'memos',
      {'content': content},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
