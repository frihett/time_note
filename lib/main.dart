import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_note/data_source/memo_database_service.dart';
import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/router.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));


  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onNotificationResponse);

  await requestExactAlarmPermission();

  await initializeDateFormatting('ko_KR', '');
  await TimeSettingsDatabaseService.instance.database;
  await MemoDatabaseService.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF2F2F7),
          appBarTheme: AppBarTheme(
            color: Color(0xFFF2F2F7),
            scrolledUnderElevation: 0,
          ),
          useMaterial3: true,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}

Future<void> requestExactAlarmPermission() async {
  final androidPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    final hasPermission = await androidPlugin.requestExactAlarmsPermission();
    if (!hasPermission!) {
      print('Exact alarms permission not granted');
    } else {
      print('Exact alarms permission granted');
    }
  }
}

void onNotificationResponse(NotificationResponse response) {
  if (response.payload != null) {
    final payload = response.payload!.split(',');
    final hour = int.parse(payload[0]);
    final minute = int.parse(payload[1]);

    goRouter.go('/memoWritePage', extra: {
      'period': hour >= 12 ? '오후' : '오전',
      'hour': hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour),
      'minute': minute,
      'year': DateTime.now().year,
      'month': DateTime.now().month,
      'day': DateTime.now().day,
    });
  }
}
