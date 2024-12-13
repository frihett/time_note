import 'package:time_note/model/time_setting.dart';

abstract interface class TimeSettingsRepository {
  Future<TimeSetting> createTimeSetting(TimeSetting timeSetting);

  Future<TimeSetting?> fetchTimeSetting(int id);

  Future<List<TimeSetting>> fetchAllTimeSettings();

  Future<int> deleteTimeSetting(int id);

  Future<int> updateToggleState(int id, bool isToggled);
}
