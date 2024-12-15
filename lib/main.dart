import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_note/data_source/memo_database_service.dart';
import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
