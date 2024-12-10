import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/model/time_setting.dart';
import 'package:time_note/repository/time_settings_repository.dart';

class TimeSettingsRepositoryLocal implements TimeSettingsRepository {
  final TimeSettingsDatabaseService databaseService;

  TimeSettingsRepositoryLocal({required this.databaseService});

  @override
  Future<TimeSetting> insert(TimeSetting timeSetting) async {
    return await databaseService.insert(timeSetting);
  }

  @override
  Future<TimeSetting?> getTimeSetting(int id) async {
    return await databaseService.getTimeSetting(id);
  }

  @override
  Future<List<TimeSetting>> getAllTimeSettings() async {
    return await databaseService.getAllTimeSettings();
  }

  @override
  Future<int> updateMemo(int timeSettingId, String memo) async {
    return await databaseService.updateMemo(timeSettingId, memo);
  }

  @override
  Future<int> deleteTimeSetting(int id) async {
    return await databaseService.deleteTimeSetting(id);
  }
}
