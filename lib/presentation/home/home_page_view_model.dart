import 'package:flutter/foundation.dart';
import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/model/time_setting.dart';
import 'package:time_note/repository/time_settings_repository.dart';

class HomePageViewModel extends ChangeNotifier {
  final TimeSettingsRepository _repository;
  List<TimeSetting> _timeSettings = [];

  List<TimeSetting> get timeSettings => _timeSettings;

  HomePageViewModel({required TimeSettingsRepository repository})
      : _repository = repository {
    loadTimeSettings();
  }

  Future<void> loadTimeSettings() async {
    final timeSettings = await _repository.getAllTimeSettings();
    _timeSettings = timeSettings;
    notifyListeners();
  }

  Future<void> addTimeSetting(TimeSetting newTimeSetting) async {
    await _repository.insert(newTimeSetting);
    loadTimeSettings(); // 데이터 갱신
  }

  Future<void> deleteTimeSetting(int id) async {
    await _repository.deleteTimeSetting(id);
    loadTimeSettings();
  }

  Future<void> updateToggleState(int id, bool isToggled) async {
    await _repository.updateToggleState(id, isToggled);
    final index = _timeSettings.indexWhere((setting) => setting.id == id);
    if (index != -1) {
      _timeSettings[index].isToggled = isToggled;
      notifyListeners();
    }
  }
}
