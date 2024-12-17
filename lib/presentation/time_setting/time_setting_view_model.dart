import 'dart:async';

import 'package:flutter/material.dart';

class TimeSettingViewModel extends ChangeNotifier {
  late String _selectedPeriod;
  late int _selectedHour;
  late int _selectedMinute;

  final List<String> periods = ["오전", "오후"];
  final List<int> hours = List.generate(12, (index) => index + 1);
  final List<int> minutes = List.generate(60, (index) => index);

  Timer? _timer;
  String _currentTime = "";

  TimeSettingViewModel({
    String? initialPeriod,
    int? initialHour,
    int? initialMinute,
  }) {
    _selectedPeriod = initialPeriod ?? "오전";
    _selectedHour = initialHour ?? 1;
    _selectedMinute = initialMinute ?? 0;

    _updateCurrentTime();
    _startTimer();
  }

  String get selectedPeriod => _selectedPeriod;

  int get selectedHour => _selectedHour;

  int get selectedMinute => _selectedMinute;

  String get currentTime => _currentTime;

  void updatePeriod(int index) {
    _selectedPeriod = periods[index];
    notifyListeners();
  }

  void updateHour(int index) {
    _selectedHour = hours[index];
    notifyListeners();
  }

  void updateMinute(int index) {
    _selectedMinute = minutes[index];
    notifyListeners();
  }

  Map<String, dynamic> getSelectedTime() {
    return {
      'period': _selectedPeriod,
      'hour': _selectedHour,
      'minute': _selectedMinute,
    };
  }

  void _updateCurrentTime() {
    final now = DateTime.now();
    _currentTime =
        "${now.hour > 12 ? '오후' : '오전'} ${now.hour % 12 == 0 ? 12 : now.hour % 12}:${now.minute.toString().padLeft(2, '0')}";
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _updateCurrentTime();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
