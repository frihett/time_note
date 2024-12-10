import 'package:flutter/foundation.dart';
import 'package:time_note/data_source/sqlite_database.dart';
import 'package:time_note/model/time_setting.dart';

class HomePageViewModel extends ChangeNotifier {
  final SqliteDatabase _dbHelper = SqliteDatabase.instance;
  List<TimeSetting> _timeSettings = [];

  List<TimeSetting> get timeSettings => _timeSettings;

  HomePageViewModel() {
    loadTimeSettings();
  }

  Future<void> loadTimeSettings() async {
    final timeSettings = await _dbHelper.getAllTimeSettings();
    _timeSettings = timeSettings;
    notifyListeners();
  }

  Future<void> addTimeSetting(TimeSetting newTimeSetting) async {
    await _dbHelper.insert(newTimeSetting);
    loadTimeSettings(); // 데이터 갱신
  }

  Future<void> deleteTimeSetting(int id) async {
    await _dbHelper.deleteTimeSetting(id);
    loadTimeSettings();
  }
}
