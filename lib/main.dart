import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_note/config/ui_style/UiStyle.dart';
import 'package:time_note/main_page.dart';
import 'package:time_note/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: UiStyle.thirdColorSurface,
              foregroundColor: UiStyle.black),
          useMaterial3: true,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
