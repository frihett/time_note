import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/model/time_setting.dart';
import 'package:time_note/repository/time_setting/time_settings_repository.dart';

class TimeSettingsRepositoryLocal implements TimeSettingsRepository {
  final TimeSettingsDatabaseService databaseService;

  TimeSettingsRepositoryLocal({required this.databaseService});

  @override
  Future<TimeSetting> createTimeSetting(TimeSetting timeSetting) async {
    return await databaseService.insert(timeSetting);
  }

  @override
  Future<TimeSetting?> fetchTimeSetting(int id) async {
    return await databaseService.getTimeSetting(id);
  }

  @override
  Future<List<TimeSetting>> fetchAllTimeSettings() async {
    return await databaseService.getAllTimeSettings();
  }

  @override
  Future<int> deleteTimeSetting(int id) async {
    return await databaseService.deleteTimeSetting(id);
  }

  Future<int> updateToggleState(int id, bool isToggled) async {
    return await databaseService.updateToggleState(id, isToggled);
  }
}
