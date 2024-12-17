import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_note/main.dart';
import 'package:time_note/model/time_setting.dart';
import 'package:time_note/repository/time_setting/time_settings_repository.dart';
import 'package:timezone/timezone.dart' as tz;

class HomePageViewModel extends ChangeNotifier {
  final TimeSettingsRepository _repository;
  List<TimeSetting> _timeSettings = [];

  List<TimeSetting> get timeSettings => _timeSettings;

  HomePageViewModel({required TimeSettingsRepository repository})
      : _repository = repository {
    loadTimeSettings();
  }

  Future<void> loadTimeSettings() async {
    final timeSettings = await _repository.fetchAllTimeSettings();
    _timeSettings = timeSettings;
    notifyListeners();
  }

  Future<void> addTimeSetting(TimeSetting newTimeSetting) async {
    await _repository.createTimeSetting(newTimeSetting);
    loadTimeSettings();
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

      if (isToggled) {
        final timeSetting = _timeSettings[index];

        await scheduleDailyNotification(
          id: timeSetting.id!,
          hour: timeSetting.period == '오후' && timeSetting.hour != 12
              ? timeSetting.hour + 12
              : (timeSetting.period == '오전' && timeSetting.hour == 12
                  ? 0
                  : timeSetting.hour),
          minute: timeSetting.minute,
          title: '타임노트',
          body:
              '${timeSetting.period} ${timeSetting.hour}:${timeSetting.minute.toString().padLeft(2, '0')} 메모를 적으러 가세요.',
        );
        print('알람이 설정되었어요');
      } else {
        print('알람이 취소되었어요');
        await cancelNotification(id);
      }

      notifyListeners();
    }
  }

  Future<void> scheduleDailyNotification(
      {required int id,
      required int hour,
      required int minute,
      required String title,
      required String body}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // 알림 고유 ID
      title, // 알림 제목
      body, // 알림 내용
      tz.TZDateTime(tz.local, 2040, 12, 5, hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification_channel', // 채널 ID
          'Daily Notifications', // 채널 이름
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: '$hour,$minute',
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
