import 'package:time_note/model/time_setting.dart';



abstract interface class TimeSettingsRepository {
  Future<TimeSetting> insert(TimeSetting timeSetting);
  Future<TimeSetting?> getTimeSetting(int id);
  Future<List<TimeSetting>> getAllTimeSettings();
  Future<int> updateMemo(int timeSettingId, String memo);
  Future<int> deleteTimeSetting(int id);
  Future<int> updateToggleState(int id, bool isToggled);
}
