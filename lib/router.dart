import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/main_page.dart';
import 'package:time_note/memo_manage_page.dart';
import 'package:time_note/memo_write_page.dart';
import 'package:time_note/presentation/home/home_page.dart';
import 'package:time_note/presentation/home/home_page_view_model.dart';
import 'package:time_note/repository/time_settings_repository_local.dart';
import 'package:time_note/time_setting_page.dart';

final GoRouter goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => HomePageViewModel(
                  repository: TimeSettingsRepositoryLocal(
                      databaseService: TimeSettingsDatabaseService.instance)),
              child: HomePage(),
            );
          },
        ),
        GoRoute(
          path: '/memo',
          builder: (context, state) {
            return MemoManagePage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/timeSettingPage',
      builder: (context, state) {
        return TimeSettingPage(); // MainPage 외부의 페이지
      },
    ),
    GoRoute(
      path: '/memoWritePage',
      builder: (context, state) {
        return MemoWritePage(); // MainPage 외부의 페이지
      },
    ),
  ],
);
