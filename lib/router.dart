import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/data_source/memo_database_service.dart';
import 'package:time_note/data_source/time_settings_database_service.dart';
import 'package:time_note/main_page.dart';
import 'package:time_note/model/memo.dart';
import 'package:time_note/presentation/memo/memo_manage_page.dart';
import 'package:time_note/presentation/memo/memo_manage_view_model.dart';
import 'package:time_note/presentation/memo/memo_write_page.dart';
import 'package:time_note/presentation/home/home_page.dart';
import 'package:time_note/presentation/home/home_page_view_model.dart';
import 'package:time_note/presentation/memo/memo_write_view_model.dart';
import 'package:time_note/presentation/time_setting/time_setting_view_model.dart';
import 'package:time_note/repository/memo/memo_repository_local.dart';
import 'package:time_note/repository/time_setting/time_settings_repository_local.dart';
import 'package:time_note/presentation/time_setting/time_setting_page.dart';

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
            return ChangeNotifierProvider(
              create: (context) => MemoManageViewModel(
                  memoRepository: MemoRepositoryLocal(
                      databaseService: MemoDatabaseService.instance)),
              child: MemoManagePage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/timeSettingPage',
      builder: (context, state) {
        return ChangeNotifierProvider(
            create: (context) => TimeSettingViewModel(),
            child: TimeSettingPage()); // MainPage 외부의 페이지
      },
    ),
    GoRoute(
      path: '/memoWritePage',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final memo = extra['memo'] as Memo?;
        final period = extra['period'] as String;
        final hour = extra['hour'] as int;
        final minute = extra['minute'] as int;
        final year = extra['year'] as int;
        final month = extra['month'] as int;
        final day = extra['day'] as int;
        return ChangeNotifierProvider(
          create: (context) => MemoWriteViewModel(
            memo : memo,
            period: period,
            hour: hour,
            minute: minute,
            year: year,
            month: month,
            day: day,
            memoRepository: MemoRepositoryLocal(
                databaseService: MemoDatabaseService.instance),
          ),
          child: MemoWritePage(),
        );
      },
    ),
  ],
);
