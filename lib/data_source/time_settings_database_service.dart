import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_note/model/time_setting.dart';

class TimeSettingsDatabaseService {
  static final TimeSettingsDatabaseService instance = TimeSettingsDatabaseService._privateConstructor();
  static Database? _database;

  TimeSettingsDatabaseService._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'time_settings.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,

    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // time_settings 테이블 생성
    await db.execute('''
      CREATE TABLE time_settings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        period TEXT NOT NULL,         
        hour INTEGER NOT NULL,         
        minute INTEGER NOT NULL,       
        date TEXT NOT NULL,            
        memo TEXT,         
        isToggled INTEGER DEFAULT 0

      )
    ''');
  }
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('''
      ALTER TABLE time_settings ADD COLUMN isToggled INTEGER DEFAULT 0
    ''');
    }
  }

  Future<TimeSetting> insert(TimeSetting timeSetting) async {
    final db = await database;
    timeSetting.id = await db.insert('time_settings', timeSetting.toMap());
    return timeSetting;
  }

  // 특정 TimeSetting 조회
  Future<TimeSetting?> getTimeSetting(int id) async {
    final db = await database;
    final result = await db.query(
      'time_settings',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return TimeSetting.fromMap(result.first);
    }
    return null;
  }

  // 모든 TimeSetting 조회
  Future<List<TimeSetting>> getAllTimeSettings() async {
    final db = await database;
    final result = await db.query('time_settings');
    return result.map((map) => TimeSetting.fromMap(map)).toList();
  }

  // 메모 업데이트
  Future<int> updateMemo(int timeSettingId, String memo) async {
    final db = await database;
    return await db.update(
      'time_settings',
      {'memo': memo},
      where: 'id = ?',
      whereArgs: [timeSettingId],
    );
  }

  // TimeSetting 삭제
  Future<int> deleteTimeSetting(int id) async {
    final db = await database;
    return await db.delete(
      'time_settings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateToggleState(int id, bool isToggled) async {
    final db = await database;
    return await db.update(
      'time_settings',
      {'isToggled': isToggled ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
